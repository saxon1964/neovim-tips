---@class NeovimTipsHelpPicker
---Help picker functionality for tag and category selection
local M = {}

local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event
local tips = require("neovim_tips.tips")
local utils = require("neovim_tips.utils")

---@class HelpPickerOptions
---@field help_type string "tag" or "category"
---@field on_select function(selected_value: string) Callback when item is selected
---@field on_cancel function() Callback when picker is cancelled
---@field parent_popup table The parent search popup to return focus to

---@class HelpPicker
---@field popup table NUI popup instance
---@field items string[] Available tags or categories
---@field options HelpPickerOptions Configuration options
local HelpPicker = {}
HelpPicker.__index = HelpPicker

---Create a new help picker instance
---@param options HelpPickerOptions Configuration options
---@return HelpPicker picker New help picker instance
function HelpPicker:new(options)
  local picker = {
    popup = nil,
    items = {},
    options = options or {}
  }
  setmetatable(picker, HelpPicker)
  return picker
end

---Show the help picker popup
---@return nil
function HelpPicker:show()
  local help_type = self.options.help_type
  local title = ""

  if help_type == "tag" then
    self.items = tips.get_tags()
    title = " Select Tag (press letter to jump) "
  elseif help_type == "category" then
    self.items = tips.get_categories()
    title = " Select Category (press letter to jump) "
  else
    utils.warn("Invalid help type: " .. tostring(help_type))
    return
  end

  if #self.items == 0 then
    utils.warn("No " .. help_type .. "s available")
    if self.options.on_cancel then
      self.options.on_cancel()
    end
    return
  end

  -- Calculate safe dimensions
  local screen_height = vim.o.lines
  local screen_width = vim.o.columns
  local popup_height = math.max(10, math.floor(screen_height * 0.7))
  local popup_width = math.max(30, math.floor(screen_width * 0.6))

  -- Create help picker popup
  self.popup = Popup({
    enter = true,
    focusable = true,
    border = {
      style = "rounded",
      text = {
        top = title,
        top_align = "center",
      },
    },
    position = {
      row = "50%",
      col = "50%",
    },
    size = {
      width = popup_width,
      height = popup_height,
    },
    buf_options = {
      modifiable = false,
      readonly = false,
      buftype = "nofile",
    },
    win_options = {
      wrap = false,
      number = false,
      cursorline = true,
    },
  })

  self.popup:mount()

  -- Ensure we're in normal mode
  vim.cmd("stopinsert")

  -- Populate with items
  local lines = {}
  for _, item in ipairs(self.items) do
    table.insert(lines, "  " .. item)
  end

  vim.bo[self.popup.bufnr].modifiable = true
  vim.api.nvim_buf_set_lines(self.popup.bufnr, 0, -1, false, lines)
  vim.bo[self.popup.bufnr].modifiable = false

  -- Position cursor at first item
  vim.api.nvim_win_set_cursor(self.popup.winid, { 1, 0 })

  -- Add explicit highlighting for the current row
  self:update_highlighting()

  -- Set up event handlers
  self:setup_keymaps()
  self:setup_autocmds()
end

---Close the help picker
---@return nil
function HelpPicker:close()
  if self.popup then
    self.popup:unmount()
    self.popup = nil
  end
end

---Get the currently selected item
---@return string|nil selected The selected item, or nil if none
function HelpPicker:get_selected()
  if not self.popup then return nil end

  local cursor = vim.api.nvim_win_get_cursor(self.popup.winid)
  local line_idx = cursor[1]
  if line_idx <= #self.items then
    return self.items[line_idx]
  end
  return nil
end

---Handle item selection
---@return nil
function HelpPicker:select_item()
  local selected = self:get_selected()
  self:close()

  if selected and self.options.on_select then
    self.options.on_select(selected)
  end

  self:return_focus()
end

---Handle picker cancellation
---@return nil
function HelpPicker:cancel()
  self:close()

  if self.options.on_cancel then
    self.options.on_cancel()
  end

  self:return_focus()
end

---Return focus to parent popup
---@return nil
function HelpPicker:return_focus()
  if self.options.parent_popup then
    vim.api.nvim_set_current_win(self.options.parent_popup.winid)
    vim.cmd("startinsert!")
  end
end

---Jump to first item starting with the given character
---@param char string The character to jump to
---@return nil
function HelpPicker:jump_to_char(char)
  if not self.popup or not self.items then return end

  local char_lower = string.lower(char)

  -- Find first item starting with the character
  for i, item in ipairs(self.items) do
    if string.lower(item:sub(1, 1)) == char_lower then
      vim.api.nvim_win_set_cursor(self.popup.winid, { i, 0 })
      self:update_highlighting()
      return
    end
  end
end

---Set up keyboard mappings for the help picker
---@return nil
function HelpPicker:setup_keymaps()
  if not self.popup then return end

  -- Close/cancel mappings
  self.popup:map("n", "<Esc>", function() self:cancel() end, { noremap = true })
  self.popup:map("n", "q", function() self:cancel() end, { noremap = true })

  -- Selection mapping
  self.popup:map("n", "<CR>", function() self:select_item() end, { noremap = true })

  -- Navigation mappings
  self.popup:map("n", "j", function() self:move_cursor(1) end, { noremap = true })
  self.popup:map("n", "k", function() self:move_cursor(-1) end, { noremap = true })
  self.popup:map("n", "<Down>", function() self:move_cursor(1) end, { noremap = true })
  self.popup:map("n", "<Up>", function() self:move_cursor(-1) end, { noremap = true })

  -- Character jump mappings (a-z, A-Z, 0-9)
  local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  for i = 1, #chars do
    local char = chars:sub(i, i)
    self.popup:map("n", char, function() self:jump_to_char(char) end, { noremap = true })
  end
end

---Update highlighting for the current row
---@return nil
function HelpPicker:update_highlighting()
  if not self.popup then return end

  local cursor = vim.api.nvim_win_get_cursor(self.popup.winid)
  local current_line = cursor[1]

  -- Clear previous highlighting
  local ns_id = vim.api.nvim_create_namespace("neovim_tips_help_picker")
  vim.api.nvim_buf_clear_namespace(self.popup.bufnr, ns_id, 0, -1)

  -- Highlight current line
  if current_line > 0 and current_line <= #self.items then
    -- Get the actual line content to determine length
    local lines = vim.api.nvim_buf_get_lines(self.popup.bufnr, current_line - 1, current_line, false)
    local line_content = lines[1] or ""
    local line_length = #line_content

    vim.api.nvim_buf_set_extmark(self.popup.bufnr, ns_id, current_line - 1, 0, {
      end_col = line_length,  -- Highlight to end of actual content
      hl_group = "Visual",
      priority = 100
    })
  end
end

---Set up autocmds for the help picker
---@return nil
function HelpPicker:setup_autocmds()
  if not self.popup then return end

  -- Update highlighting on cursor movement
  self.popup:on(event.CursorMoved, function()
    self:update_highlighting()
  end)
end

---Move cursor up or down
---@param direction number 1 for down, -1 for up
---@return nil
function HelpPicker:move_cursor(direction)
  if not self.popup then return end

  local cursor = vim.api.nvim_win_get_cursor(self.popup.winid)
  local new_line = cursor[1] + direction

  -- Clamp to valid range
  if new_line < 1 then
    new_line = 1
  elseif new_line > #self.items then
    new_line = #self.items
  end

  vim.api.nvim_win_set_cursor(self.popup.winid, { new_line, 0 })
  self:update_highlighting()
end

---Create and show a help picker
---@param help_type string "tag" or "category"
---@param on_select function(selected: string) Callback when item is selected
---@param on_cancel function() Callback when picker is cancelled
---@param parent_popup table The parent popup to return focus to
---@return HelpPicker picker The created help picker instance
function M.show(help_type, on_select, on_cancel, parent_popup)
  local picker = HelpPicker:new({
    help_type = help_type,
    on_select = on_select,
    on_cancel = on_cancel,
    parent_popup = parent_popup
  })

  picker:show()
  return picker
end

return M