---@class NeovimTipsPicker
---@field private M table
local M = {}

-- Import components
local search_parser = require("neovim_tips.picker.search_parser")
local help_picker = require("neovim_tips.picker.help_picker")
local layout = require("neovim_tips.picker.layout")
local events = require("neovim_tips.picker.events")

-- Import other modules
local config = require("neovim_tips.config")
local renderer = require("neovim_tips.renderer")
local tips = require("neovim_tips.tips")
local utils = require("neovim_tips.utils")

---@class NuiPickerOptions
---@field get_content function(title: string)|nil Function to get the tip content by the title
---@field on_select function(title: string)|nil Callback when tip is selected

---@class NuiPicker
---@field opts table Configuration options
---@field layout table Layout components (search_popup, titles_popup, preview_popup, footer_popup, layout)
---@field all_titles string[] All available tip titles
---@field filtered_titles string[] Currently filtered tip titles
---@field selected_index integer Currently selected tip index
---@field search_text string Current search query
---@field active_query table Parsed search query with categories, tags, title_words
---@field update_timer uv_timer_t|nil Debounce timer for preview updates
---@field help_picker_active boolean Whether help picker is currently shown
---@field original_cursor_pos integer[]|nil Original cursor position
---@field original_window integer|nil Original window ID
---@field original_mode string|nil Original vim mode
local NuiPicker = {}
NuiPicker.__index = NuiPicker

---Create a new NuiPicker instance
---@param opts NuiPickerOptions|nil Configuration options
---@return NuiPicker picker New picker instance
function NuiPicker:new(opts)
  local picker = {
    opts = opts or {},
    -- Components
    layout = {},
    -- State
    all_titles = {},
    filtered_titles = {},
    selected_index = 1,
    search_text = "",
    active_query = { categories = {}, tags = {}, title_words = {} },
    update_timer = nil,
    help_picker_active = false,
    -- Preserve original state
    original_cursor_pos = nil,
    original_window = nil,
    original_mode = nil,
  }
  setmetatable(picker, NuiPicker)
  return picker
end

---Set the tip titles that will be displayed in the picker
---@param titles string[] List of tip titles to display
---@return nil
function NuiPicker:set_titles(titles)
  self.all_titles = titles
  self.filtered_titles = titles
  if #titles > 0 and self.selected_index < 1 then
    self.selected_index = 1
  end
end

---Filter titles based on current search text and update display
---@return nil
function NuiPicker:filter_titles()
  if self.search_text == "" then
    self.filtered_titles = self.all_titles
    self.active_query = { categories = {}, tags = {}, title_words = {} }
  else
    self.filtered_titles = {}
    self.active_query = search_parser.parse_search_query(self.search_text)

    for _, title in ipairs(self.all_titles) do
      local tip = tips.get_tip_by_title(title)
      if not tip then goto continue end

      local matches = true

      -- Check category filters
      if #self.active_query.categories > 0 then
        matches = matches and search_parser.category_matches(tip.category, self.active_query.categories)
      end

      -- Check tag filters
      if #self.active_query.tags > 0 then
        matches = matches and search_parser.tag_matches(tip.tags, self.active_query.tags)
      end

      -- Check title word filters
      if #self.active_query.title_words > 0 then
        matches = matches and search_parser.title_matches(title, self.active_query.title_words)
      end

      if matches then
        table.insert(self.filtered_titles, title)
      end

      ::continue::
    end
  end

  -- Reset selection if needed
  if self.selected_index > #self.filtered_titles then
    self.selected_index = 1
  end
  if self.selected_index < 1 and #self.filtered_titles > 0 then
    self.selected_index = 1
  end
end

---Update the titles display
---@return nil
function NuiPicker:update_titles_display()
  layout.update_titles_display(
    self.layout.titles_popup,
    self.filtered_titles,
    self.all_titles,
    self.selected_index,
    self.active_query
  )
end

---Update preview content with debouncing
---@param debounced boolean Whether to debounce rendering
---@return nil
function NuiPicker:update_preview(debounced)
  if not self.layout.preview_popup then return end

  -- If no filtered titles, clear the preview
  if #self.filtered_titles == 0 then
    layout.update_preview_content(self.layout.preview_popup, "No Results", "No matching tips found.", renderer)
    return
  end

  local selected_title = self.filtered_titles[self.selected_index]
  if not selected_title then return end

  -- Cancel any pending timer
  if self.update_timer then
    self.update_timer:stop()
    self.update_timer:close()
    self.update_timer = nil
  end

  -- Get content
  local content = self.opts.get_content and self.opts.get_content(selected_title) or "No content available"

  local function update()
    if not vim.api.nvim_buf_is_valid(self.layout.preview_popup.bufnr) then return end
    layout.update_preview_content(self.layout.preview_popup, selected_title, content, renderer)
    self.update_timer = nil
  end

  if debounced then
    self.update_timer = vim.defer_fn(update, 100)
  else
    update()
  end
end

---Handle search text change
---@param search_text string The new search text
---@return nil
function NuiPicker:on_search_change(search_text)
  self.search_text = search_text
  self:filter_titles()
  self:update_titles_display()
  self:update_preview(true)
end

---Handle selection change
---@param new_index integer The new selected index
---@return nil
function NuiPicker:on_selection_change(new_index)
  if new_index ~= self.selected_index and new_index <= #self.filtered_titles and new_index > 0 then
    self.selected_index = new_index
    self:update_titles_display()
    self:update_preview(false)
    -- Ensure cursor stays synced with selection for future key navigation
    vim.api.nvim_win_set_cursor(self.layout.titles_popup.winid, { self.selected_index, 0 })
  end
end

---Handle help trigger detection
---@param trigger_type string "tag" or "category"
---@param search_text string The current search text
---@return nil
function NuiPicker:on_help_trigger(trigger_type, search_text)
  if self.help_picker_active then return end
  self.help_picker_active = true

  help_picker.show(
    trigger_type,
    function(selected_value)
      -- On selection: replace trigger with selected value
      self:replace_help_trigger(trigger_type, selected_value)
      self.help_picker_active = false
    end,
    function()
      -- On cancel: remove just the ? from trigger
      self:replace_help_trigger(trigger_type, nil)
      self.help_picker_active = false
    end,
    self.layout.search_popup
  )
end

---Replace help trigger in search text with selected value
---@param trigger_type string "tag" or "category"
---@param selected_value string|nil The selected tag/category, or nil to just remove trigger
---@return nil
function NuiPicker:replace_help_trigger(trigger_type, selected_value)
  local search_text = self.search_text or ""
  local prefix = trigger_type == "tag" and "t:" or "c:"

  -- Handle selected value - escape special characters and quote if needed
  local replacement
  if selected_value then
    -- If the value contains spaces or special characters, quote it
    if selected_value:match("[%s\"\\]") then
      -- Escape quotes in the value and wrap in quotes
      local escaped_value = selected_value:gsub('"', '\\"')
      replacement = prefix .. '"' .. escaped_value .. '"'
    else
      replacement = prefix .. selected_value
    end
  else
    replacement = prefix
  end

  -- The search text should end with just the prefix (t: or c:) by now
  -- since the ? was already removed when help picker was triggered
  local new_search
  if search_text:match(prefix .. "$") then
    -- Replace the prefix with our full replacement
    new_search = search_text:gsub(prefix .. "$", replacement)
  else
    -- Fallback: just append to current search
    new_search = search_text .. replacement
  end

  -- Update search field
  vim.api.nvim_buf_set_lines(self.layout.search_popup.bufnr, 0, 1, false, { new_search })
  self.search_text = new_search

  -- Update filtering
  self:filter_titles()
  self:update_titles_display()
  self:update_preview(true)

  -- Position cursor at end
  vim.api.nvim_win_set_cursor(self.layout.search_popup.winid, { 1, #new_search })
end

---Move selection up or down
---@param direction integer 1 for down, -1 for up
---@return nil
function NuiPicker:move_selection(direction)
  local new_index = self.selected_index + direction
  if new_index >= 1 and new_index <= #self.filtered_titles then
    self.selected_index = new_index
    self:update_titles_display()
    self:update_preview(true)
    -- Keep cursor synced in titles window
    vim.api.nvim_win_set_cursor(self.layout.titles_popup.winid, { self.selected_index, 0 })
  end
end

---Create event handlers for the picker
---@return table handlers Event handler functions
function NuiPicker:create_event_handlers()
  return {
    on_search_change = function(search_text)
      self:on_search_change(search_text)
    end,
    on_selection_change = function(new_index)
      self:on_selection_change(new_index)
    end,
    on_help_trigger = function(trigger_type, search_text)
      self:on_help_trigger(trigger_type, search_text)
    end,
    focus_search = function()
      vim.api.nvim_set_current_win(self.layout.search_popup.winid)
      vim.cmd("startinsert!")
    end,
    focus_titles = function()
      vim.api.nvim_set_current_win(self.layout.titles_popup.winid)
      vim.cmd("stopinsert")
    end,
    focus_preview = function()
      vim.api.nvim_set_current_win(self.layout.preview_popup.winid)
      vim.cmd("stopinsert")
    end,
    move_up = function()
      self:move_selection(-1)
    end,
    move_down = function()
      self:move_selection(1)
    end,
    select_item = function()
      if self.opts.on_select and #self.filtered_titles > 0 then
        local selected = self.filtered_titles[self.selected_index]
        self.opts.on_select(selected)
      end
      self:close()
    end,
    close_picker = function()
      self:close()
    end
  }
end

---Show the picker and preserve current state
---@return nil
function NuiPicker:show()
  if not self.all_titles or #self.all_titles == 0 then
    utils.warn("No titles available")
    return
  end

  -- Save current state
  self.original_window = vim.api.nvim_get_current_win()
  self.original_cursor_pos = vim.api.nvim_win_get_cursor(self.original_window)
  self.original_mode = vim.api.nvim_get_mode().mode

  -- Create layout
  self.layout = layout.create_layout()

  -- Set up event handlers
  local handlers = self:create_event_handlers()
  events.setup_keymaps(self.layout, handlers)
  events.setup_autocmds(self.layout, handlers)

  -- Mount the layout
  layout.mount_layout(self.layout)

  -- Initial display
  self.search_text = ""
  self:filter_titles()
  self:update_titles_display()
  self:update_preview(true)

  -- Set up footer
  local message = config.options.messages.picker.footer
  layout.setup_footer(self.layout.footer_popup, message, renderer)

  -- Focus search and enter insert mode
  vim.api.nvim_set_current_win(self.layout.search_popup.winid)
  vim.cmd("startinsert!")
end

---Close the picker and restore original state
---@return nil
function NuiPicker:close()
  -- Cancel any pending timer
  if self.update_timer then
    self.update_timer:stop()
    self.update_timer:close()
    self.update_timer = nil
  end

  -- Unmount layout
  layout.unmount_layout(self.layout)

  -- Restore original state
  if self.original_window and vim.api.nvim_win_is_valid(self.original_window) then
    vim.api.nvim_set_current_win(self.original_window)
    if self.original_cursor_pos then
      pcall(vim.api.nvim_win_set_cursor, self.original_window, self.original_cursor_pos)
    end

    -- Restore original mode
    if self.original_mode == "i" then
      vim.cmd("startinsert")
    elseif self.original_mode == "v" or self.original_mode == "V" then
      -- Visual mode restoration is complex, just go to normal mode
      vim.cmd("stopinsert")
    else
      vim.cmd("stopinsert")
    end
  end
end

---Create a new picker instance
---@param opts table|nil Configuration options
---@return NuiPicker picker New picker instance
function M.new(opts)
  return NuiPicker:new(opts)
end

---Show the tips picker interface
---Creates and displays a picker with all available tips
---Uses the tips module for data and handles tip selection
---@return nil
function M.show()
  local titles = tips.get_titles()

  if not titles or vim.tbl_isempty(titles) then
    utils.error("No tips loaded")
    return
  end

  -- Create picker instance
  local picker = M.new({
    get_content = function(title)
      return tips.get_description(title) or "Description not available"
    end,
    on_select = function(_)
      -- Title argument is not used
      -- Do nothing - just close picker
    end
  })

  picker:set_titles(titles)
  picker:show()
end

return M