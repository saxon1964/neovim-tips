---@class NeovimTipsPicker
---@field private M table
local M = {}

-- Import nui components
local Popup = require("nui.popup")
local Layout = require("nui.layout")
local event = require("nui.utils.autocmd").event
local config = require("neovim_tips.config")
local renderer = require("neovim_tips.renderer")
local tips = require("neovim_tips.tips")

---Stub definition of a class defined in libuv
---@class uv_timer_t
---@field start fun(self: uv_timer_t, timeout: number, repeat: number, callback: fun())
---@field stop fun(self: uv_timer_t)
---@field close fun(self: uv_timer_t)

---@class NuiPickerOptions
---@field get_content function(title: string)|nil Function to get the tip content by the title
---@field on_select function(title: string)|nil Callback when tip is selected

---@class NuiPicker
---@field opts table Configuration options
---@field layout NuiLayout|nil Main layout container
---@field search_popup NuiPopup|nil Search input popup
---@field titles_popup NuiPopup|nil Tips list popup
---@field preview_popup NuiPopup|nil Preview content popup
---@field footer_popup NuiPopup|nil Footer popup with GitHub submission message
---@field all_titles string[] All available tip titles
---@field filtered_titles string[] Currently filtered tip titles
---@field selected_index integer Currently selected tip index
---@field search_text string Current search query
---@field update_timer uv_timer_t|nil Debounce timer for preview updates
---@field original_cursor_pos integer[]|nil Original cursor position
---@field original_window integer|nil Original wendow ID
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
    layout = nil,
    search_popup = nil,
    titles_popup = nil,
    preview_popup = nil,
    footer_popup = nil,
    -- State
    all_titles = {},
    filtered_titles = {},
    selected_index = 1,
    search_text = "",
    update_timer = nil,
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

---Filter titles based on search text using word-based matching
---All words in the search query must be found in the title (case-insensitive)
---@return nil
function NuiPicker:filter_titles()
  local search_text = self.search_text or ""

  if search_text == "" then
    self.filtered_titles = self.all_titles
  else
    self.filtered_titles = {}
    local search_lower = string.lower(search_text)

    -- Split search text into words
    local search_words = {}
    for word in search_lower:gmatch("%S+") do
      table.insert(search_words, word)
    end

    for _, title in ipairs(self.all_titles) do
      local title_lower = string.lower(title)
      local matches_all = true

      -- Check that all search words are found in the title
      for _, word in ipairs(search_words) do
        if not string.find(title_lower, word, 1, true) then
          matches_all = false
          break
        end
      end

      if matches_all then
        table.insert(self.filtered_titles, title)
      end
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

---Update the titles list display with current filtered results
---Updates the titles popup content and applies highlighting to selected item
---Also updates the border title with current tip counts (filtered/total)
---@return nil
function NuiPicker:update_titles_display()
  if not self.titles_popup then return end

  local lines = {}
  for i, title in ipairs(self.filtered_titles or {}) do
    local prefix = (i == self.selected_index) and "> " or "  "
    table.insert(lines, prefix .. title)
  end

  -- Show empty state if no results
  if #lines == 0 then
    lines = {"  No matching tips found"}
  end

  -- Update border title with tip count
  local total_tips = #(self.all_titles or {})
  local filtered_count = #(self.filtered_titles or {})
  local title_text = string.format(" Tips: %d/%d ", filtered_count, total_tips)
  self.titles_popup.border:set_text("top", title_text, "center")

  -- Temporarily make modifiable to update, then restore
  vim.bo[self.titles_popup.bufnr].modifiable = true
  vim.api.nvim_buf_set_lines(self.titles_popup.bufnr, 0, -1, false, lines)
  vim.bo[self.titles_popup.bufnr].modifiable = false

  -- Highlight selected line
  local ns_id = vim.api.nvim_create_namespace("neovim_tips_picker")
  vim.api.nvim_buf_clear_namespace(self.titles_popup.bufnr, ns_id, 0, -1)
  if self.selected_index > 0 and self.selected_index <= #lines then
    local line_content = lines[self.selected_index]
    local line_length = #line_content

    -- Highlight entire selected line including all text
    vim.api.nvim_buf_set_extmark(self.titles_popup.bufnr, ns_id, self.selected_index - 1, 0, {
      end_col = line_length,
      hl_group = "Visual",
      priority = 100
    })
    -- Highlight the ">" prefix more prominently
    vim.api.nvim_buf_set_extmark(self.titles_popup.bufnr, ns_id, self.selected_index - 1, 0, {
      end_col = 2,
      hl_group = "IncSearch",
      priority = 101
    })
  end
end

---Update preview content, possibly with debounced rendering
---Gets content for selected tip and updates preview popup with markdown rendering
---If debounced, uses a 100ms debounce timer to prevent flickering during navigation
---@param debounced boolean Whether to debounce rendering
---@return nil
function NuiPicker:update_preview(debounced)
  if not self.preview_popup or #self.filtered_titles == 0 then return end

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
  local lines = vim.split(content, "\n")

  local function update()
    if not vim.api.nvim_buf_is_valid(self.preview_popup.bufnr) then return end

    -- Update title
    self.preview_popup.border:set_text("top", " " .. selected_title .. " ", "center")

    -- Temporarily make modifiable to update content
    vim.bo[self.preview_popup.bufnr].modifiable = true
    
    -- Update content
    vim.api.nvim_buf_set_lines(self.preview_popup.bufnr, 0, -1, false, lines)
    vim.bo[self.preview_popup.bufnr].filetype = "markdown"

    -- Render markdown
    renderer.enable(self.preview_popup.bufnr)
    
    -- Make non-modifiable again to prevent user editing
    vim.bo[self.preview_popup.bufnr].modifiable = false

    self.update_timer = nil
  end

  if debounced then
    self.update_timer = vim.defer_fn(update, 100)
  else
    update()
  end
end

---Create the three-pane layout with search, titles, and preview popups
---Sets up the main UI structure with proper sizing and borders
---@return nil
function NuiPicker:create_layout()
  -- Create popups
  self.search_popup = Popup({
    enter = true,
    focusable = true,
    border = {
      style = "rounded",
      text = {
        top = " Search Tips ",
        top_align = "center",
      },
    },
    buf_options = {
      modifiable = true,
      readonly = false,
      buftype = "nofile",
      complete = "",
      completefunc = "",
      omnifunc = "",
      filetype = "neovim-tips-search",
    },
    win_options = {
      wrap = false,
      number = false,
      winhighlight = "FloatBorder:Normal",
    },
  })

  self.titles_popup = Popup({
    enter = false,
    focusable = true,
    border = {
      style = "rounded",
      text = {
        top = " Tips ",
        top_align = "center",
      },
    },
    buf_options = {
      modifiable = false, -- Prevent user editing
      readonly = false,   -- Keep readonly=false to avoid W10 when we update content
      buftype = "nofile",
    },
    win_options = {
      wrap = false,
      number = false,
      cursorline = false,
      winhighlight = "FloatBorder:Normal",
    },
  })

  self.preview_popup = Popup({
    enter = false,
    focusable = true,
    border = {
      style = "rounded",
      text = {
        top = " Preview ",
        top_align = "center",
      },
    },
    buf_options = {
      buftype = "nofile",
      modifiable = false,
      readonly = false,
    },
    win_options = {
      wrap = true,
      number = false,
      winhighlight = "FloatBorder:Normal",
    },
  })

  self.footer_popup = Popup({
    enter = false,
    focusable = false,
    border = {
      style = "rounded",
      text = {
        top = " Contribute ",
        top_align = "center",
      },
    },
    buf_options = {
      buftype = "nofile",
      modifiable = true,
      readonly = false,
    },
    win_options = {
      wrap = false,
      number = false,
      winhighlight = "FloatBorder:Normal",
    },
  })

  -- Create layout
  self.layout = Layout(
    {
      position = "50%",
      size = {
        width = "90%",
        height = "80%",
      },
    },
    Layout.Box({
      Layout.Box(self.search_popup, { size = "10%" }),
      Layout.Box({
        Layout.Box(self.titles_popup, { size = "40%" }),
        Layout.Box(self.preview_popup, { size = "60%" }),
      }, { dir = "row", size = "80%" }),
      Layout.Box(self.footer_popup, { size = "10%" }),
    }, { dir = "col" })
  )
end

---Set up key mappings for all popups
---Configures navigation, selection, and closing keys for search, titles, and preview panels
---@return nil
function NuiPicker:setup_keymaps()
  local function close_picker()
    self:close()
  end

  local function move_down()
    if self.selected_index < #self.filtered_titles then
      self.selected_index = self.selected_index + 1
      self:update_titles_display()
      self:update_preview(true)  -- Back to debounced updates for smooth navigation
      -- Keep cursor synced in titles window
      vim.api.nvim_win_set_cursor(self.titles_popup.winid, {self.selected_index, 0})
    end
  end

  local function move_up()
    if self.selected_index > 1 then
      self.selected_index = self.selected_index - 1
      self:update_titles_display()
      self:update_preview(true)  -- Back to debounced updates for smooth navigation
      -- Keep cursor synced in titles window
      vim.api.nvim_win_set_cursor(self.titles_popup.winid, {self.selected_index, 0})
    end
  end

  local function select_item()
    if self.opts.on_select and #self.filtered_titles > 0 then
      local selected = self.filtered_titles[self.selected_index]
      self.opts.on_select(selected)
    end
    self:close()
  end

  local function focus_search()
    vim.api.nvim_set_current_win(self.search_popup.winid)
    vim.cmd("startinsert!")
  end

  local function focus_titles()
    vim.api.nvim_set_current_win(self.titles_popup.winid)
    vim.cmd("stopinsert")
  end

  local function focus_preview()
    vim.api.nvim_set_current_win(self.preview_popup.winid)
    vim.cmd("stopinsert")
  end

  -- Search popup keymaps
  self.search_popup:map("i", "<Esc>", close_picker, { noremap = true })
  self.search_popup:map("i", "<C-c>", close_picker, { noremap = true })
  self.search_popup:map("i", "<CR>", select_item, { noremap = true })
  self.search_popup:map("i", "<Down>", move_down, { noremap = true })
  self.search_popup:map("i", "<Up>", move_up, { noremap = true })
  self.search_popup:map("i", "<C-j>", move_down, { noremap = true })
  self.search_popup:map("i", "<C-k>", move_up, { noremap = true })
  self.search_popup:map("i", "<Tab>", focus_titles, { noremap = true })
  self.search_popup:map("i", "<C-l>", focus_preview, { noremap = true })

  self.search_popup:map("n", "<Esc>", close_picker, { noremap = true })
  self.search_popup:map("n", "q", close_picker, { noremap = true })
  self.search_popup:map("n", "<CR>", select_item, { noremap = true })
  self.search_popup:map("n", "j", move_down, { noremap = true })
  self.search_popup:map("n", "k", move_up, { noremap = true })
  self.search_popup:map("n", "<Tab>", focus_titles, { noremap = true })
  self.search_popup:map("n", "<C-l>", focus_preview, { noremap = true })

  -- Titles popup keymaps
  self.titles_popup:map("n", "<Esc>", close_picker, { noremap = true })
  self.titles_popup:map("n", "q", close_picker, { noremap = true })
  self.titles_popup:map("n", "<CR>", select_item, { noremap = true })
  self.titles_popup:map("n", "j", move_down, { noremap = true })
  self.titles_popup:map("n", "k", move_up, { noremap = true })
  self.titles_popup:map("n", "<Down>", move_down, { noremap = true })
  self.titles_popup:map("n", "<Up>", move_up, { noremap = true })
  self.titles_popup:map("n", "<S-Tab>", focus_search, { noremap = true })
  self.titles_popup:map("n", "<Tab>", focus_preview, { noremap = true })
  self.titles_popup:map("n", "<C-h>", focus_search, { noremap = true })
  self.titles_popup:map("n", "<C-l>", focus_preview, { noremap = true })

  -- Preview popup keymaps
  self.preview_popup:map("n", "<Esc>", close_picker, { noremap = true })
  self.preview_popup:map("n", "q", close_picker, { noremap = true })
  self.preview_popup:map("n", "<CR>", select_item, { noremap = true })
  self.preview_popup:map("n", "<S-Tab>", focus_titles, { noremap = true })
  self.preview_popup:map("n", "<Tab>", focus_search, { noremap = true })
  self.preview_popup:map("n", "<C-h>", focus_titles, { noremap = true })
  self.preview_popup:map("n", "<C-j>", focus_search, { noremap = true })
end

---Set up autocmds for real-time search and mouse interaction
---Handles text changes in search popup and cursor movement in titles popup
---@return nil
function NuiPicker:setup_autocmds()
  -- Debounced search filtering to reduce flicker
  local function debounced_search_update()
    if self.search_timer then
      self.search_timer:stop()
      self.search_timer = nil
    end
    self.search_timer = vim.defer_fn(function()
      local lines = vim.api.nvim_buf_get_lines(self.search_popup.bufnr, 0, 1, false)
      self.search_text = lines[1] or ""
      self:filter_titles()
      self:update_titles_display()
      self:update_preview(true)
      self.search_timer = nil
    end, 50) -- 50ms debounce
  end

  self.search_popup:on(event.TextChangedI, debounced_search_update)
  self.search_popup:on(event.TextChanged, debounced_search_update)

  -- Mouse click support in titles
  self.titles_popup:on(event.CursorMoved, function()
    local cursor = vim.api.nvim_win_get_cursor(self.titles_popup.winid)
    local new_index = cursor[1]
    if new_index ~= self.selected_index and new_index <= #self.filtered_titles and new_index > 0 then
      self.selected_index = new_index
      self:update_titles_display()
      self:update_preview(false)
      -- Ensure cursor stays synced with selection for future key navigation
      vim.api.nvim_win_set_cursor(self.titles_popup.winid, {self.selected_index, 0})
    end
  end)

  -- Exit insert mode when entering titles panel
  self.titles_popup:on(event.WinEnter, function()
    vim.cmd("stopinsert")
  end)

  -- Auto-enter insert mode when returning to search
  self.search_popup:on(event.WinEnter, function()
    -- Set filetype first
    vim.bo[self.search_popup.bufnr].filetype = "neovim-tips-search"

    -- Aggressively disable all completion for this buffer
    vim.bo[self.search_popup.bufnr].complete = ""
    vim.bo[self.search_popup.bufnr].completefunc = ""
    vim.bo[self.search_popup.bufnr].omnifunc = ""

    vim.cmd("startinsert!")
  end)
end

---Set up the footer popup with GitHub contribution message
---@return nil
function NuiPicker:setup_footer()
  if not self.footer_popup then return end

  local message = config.options.messages.footer

  -- Set the content without centering to avoid interfering with markdown
  vim.api.nvim_buf_set_lines(self.footer_popup.bufnr, 0, -1, false, {message})

  -- Set filetype to markdown and enable rendering
  vim.bo[self.footer_popup.bufnr].filetype = "markdown"
  renderer.enable(self.footer_popup.bufnr)
end

---Show the picker and preserve current state
---Saves current cursor position, window, and mode for restoration on close
---Mounts the layout and initializes the search interface
---@return nil
function NuiPicker:show()
  if not self.all_titles or #self.all_titles == 0 then
    vim.notify("No titles available", vim.log.levels.INFO)
    return
  end

  -- Save current state
  self.original_window = vim.api.nvim_get_current_win()
  self.original_cursor_pos = vim.api.nvim_win_get_cursor(self.original_window)
  self.original_mode = vim.api.nvim_get_mode().mode

  self:create_layout()
  self:setup_keymaps()
  self:setup_autocmds()

  -- Mount the layout
  self.layout:mount()

  -- Initial display
  self.search_text = ""
  self:filter_titles()
  self:update_titles_display()
  self:update_preview(true)
  self:setup_footer()

  -- Focus search and enter insert mode
  vim.api.nvim_set_current_win(self.search_popup.winid)
  vim.cmd("startinsert!")
end

---Close the picker and restore original state
---Restores cursor position, window focus, and vim mode to pre-picker state
---Cleans up temporary files and unmounts the layout
---@return nil
function NuiPicker:close()
  -- Cancel any pending timer
  if self.update_timer then
    self.update_timer:stop()
    self.update_timer:close()
    self.update_timer = nil
  end

  -- Unmount layout (nui handles cleanup)
  if self.layout then
    self.layout:unmount()
  end

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
    vim.notify("No tips loaded. Please run :NeovimTipsLoad first to load tips, then try again.", vim.log.levels.WARN)
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
