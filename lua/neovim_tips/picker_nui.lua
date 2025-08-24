local M = {}

-- Import nui components
local Popup = require("nui.popup")
local Layout = require("nui.layout")
local event = require("nui.utils.autocmd").event

-- NUI-based picker class
local NuiPicker = {}
NuiPicker.__index = NuiPicker

function NuiPicker:new(opts)
  local picker = {
    opts = opts or {},
    -- Components
    layout = nil,
    search_popup = nil,
    titles_popup = nil,
    preview_popup = nil,
    -- State
    all_titles = {},
    filtered_titles = {},
    selected_index = 1,
    search_text = "",
    tmp_file = nil,
    update_timer = nil,
    -- Preserve original state
    original_cursor_pos = nil,
    original_window = nil,
    original_mode = nil,
  }
  setmetatable(picker, NuiPicker)
  return picker
end

-- Set the data source
function NuiPicker:set_titles(titles)
  self.all_titles = titles
  self.filtered_titles = titles
  if #titles > 0 and self.selected_index < 1 then
    self.selected_index = 1
  end
end

-- Filter titles based on search text (word-based search)
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

-- Update the titles list display
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
  
  -- Temporarily make modifiable to update, then restore
  vim.api.nvim_buf_set_option(self.titles_popup.bufnr, "modifiable", true)
  vim.api.nvim_buf_set_lines(self.titles_popup.bufnr, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(self.titles_popup.bufnr, "modifiable", false)
  
  -- Highlight selected line
  vim.api.nvim_buf_clear_namespace(self.titles_popup.bufnr, -1, 0, -1)
  if self.selected_index > 0 and self.selected_index <= #lines then
    vim.api.nvim_buf_add_highlight(self.titles_popup.bufnr, -1, "PmenuSel", self.selected_index - 1, 0, -1)
    vim.api.nvim_buf_add_highlight(self.titles_popup.bufnr, -1, "WarningMsg", self.selected_index - 1, 0, 2)
  end
end

-- Update preview content
function NuiPicker:update_preview()
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
  
  -- Create temp file for markdown rendering
  self:cleanup_tmp_file()
  self.tmp_file = os.tmpname() .. ".md"
  local file = io.open(self.tmp_file, "w")
  if not file then return end
  file:write(content)
  file:close()
  
  -- Debounced update
  self.update_timer = vim.defer_fn(function()
    if not vim.api.nvim_buf_is_valid(self.preview_popup.bufnr) then return end
    
    -- Update title
    self.preview_popup.border:set_text("top", " " .. selected_title .. " ", "center")
    
    -- Update content (all buffers stay editable for debugging)
    vim.api.nvim_buf_set_lines(self.preview_popup.bufnr, 0, -1, false, lines)
    vim.api.nvim_buf_set_option(self.preview_popup.bufnr, "filetype", "markdown")
    
    -- Trigger markdown rendering
    local current_win = vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(self.preview_popup.winid)
    vim.cmd("silent! doautocmd FileType markdown")
    vim.cmd("silent! doautocmd BufWinEnter")
    vim.api.nvim_set_current_win(current_win)
    
    self.update_timer = nil
  end, 100)
end

-- Immediate preview update for mouse clicks
function NuiPicker:update_preview_immediate()
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
  
  -- Create temp file
  self:cleanup_tmp_file()
  self.tmp_file = os.tmpname() .. ".md"
  local file = io.open(self.tmp_file, "w")
  if not file then return end
  file:write(content)
  file:close()
  
  -- Immediate update
  if vim.api.nvim_buf_is_valid(self.preview_popup.bufnr) then
    -- Update title
    self.preview_popup.border:set_text("top", " " .. selected_title .. " ", "center")
    
    -- Update content (all buffers stay editable for debugging)
    vim.api.nvim_buf_set_lines(self.preview_popup.bufnr, 0, -1, false, lines)
    vim.api.nvim_buf_set_option(self.preview_popup.bufnr, "filetype", "markdown")
    
    -- Trigger markdown rendering
    local current_win = vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(self.preview_popup.winid)
    vim.cmd("silent! doautocmd FileType markdown")
    vim.cmd("silent! doautocmd BufWinEnter")
    vim.api.nvim_set_current_win(current_win)
  end
end

-- Clean up temporary file
function NuiPicker:cleanup_tmp_file()
  if self.tmp_file and vim.fn.filereadable(self.tmp_file) == 1 then
    local ok, err = pcall(os.remove, self.tmp_file)
    if not ok then
      vim.notify("Failed to remove temporary file: " .. err, vim.log.levels.WARN)
    end
    self.tmp_file = nil
  end
end

-- Create the layout with nui components
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
    },
    win_options = {
      wrap = false,
      number = false,
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
    },
  })

  self.preview_popup = Popup({
    enter = false,
    focusable = false,
    border = {
      style = "rounded",
      text = {
        top = " Preview ",
        top_align = "center",
      },
    },
    buf_options = {
      buftype = "nofile",
      modifiable = true,
      readonly = false,
    },
    win_options = {
      wrap = true,
      number = false,
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
      }, { dir = "row", size = "90%" }),
    }, { dir = "col" })
  )
end

-- Set up key mappings
function NuiPicker:setup_keymaps()
  local function close_picker()
    self:close()
  end
  
  local function move_down()
    if self.selected_index < #self.filtered_titles then
      self.selected_index = self.selected_index + 1
      self:update_titles_display()
      self:update_preview()  -- Back to debounced updates for smooth navigation
      -- Keep cursor synced in titles window
      vim.api.nvim_win_set_cursor(self.titles_popup.winid, {self.selected_index, 0})
    end
  end
  
  local function move_up()
    if self.selected_index > 1 then
      self.selected_index = self.selected_index - 1
      self:update_titles_display()
      self:update_preview()  -- Back to debounced updates for smooth navigation
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

  -- Search popup keymaps
  self.search_popup:map("i", "<Esc>", close_picker, { noremap = true })
  self.search_popup:map("i", "<C-c>", close_picker, { noremap = true })
  self.search_popup:map("i", "<CR>", select_item, { noremap = true })
  self.search_popup:map("i", "<Down>", move_down, { noremap = true })
  self.search_popup:map("i", "<Up>", move_up, { noremap = true })
  self.search_popup:map("i", "<C-j>", move_down, { noremap = true })
  self.search_popup:map("i", "<C-k>", move_up, { noremap = true })
  
  self.search_popup:map("n", "<Esc>", close_picker, { noremap = true })
  self.search_popup:map("n", "q", close_picker, { noremap = true })
  self.search_popup:map("n", "<CR>", select_item, { noremap = true })
  self.search_popup:map("n", "j", move_down, { noremap = true })
  self.search_popup:map("n", "k", move_up, { noremap = true })

  -- Titles popup keymaps
  self.titles_popup:map("n", "<Esc>", close_picker, { noremap = true })
  self.titles_popup:map("n", "q", close_picker, { noremap = true })
  self.titles_popup:map("n", "<CR>", select_item, { noremap = true })
  self.titles_popup:map("n", "j", move_down, { noremap = true })
  self.titles_popup:map("n", "k", move_up, { noremap = true })
  self.titles_popup:map("n", "<Down>", move_down, { noremap = true })
  self.titles_popup:map("n", "<Up>", move_up, { noremap = true })
end

-- Set up autocmds
function NuiPicker:setup_autocmds()
  -- Real-time search filtering
  self.search_popup:on(event.TextChangedI, function()
    local lines = vim.api.nvim_buf_get_lines(self.search_popup.bufnr, 0, 1, false)
    self.search_text = lines[1] or ""
    self:filter_titles()
    self:update_titles_display()
    self:update_preview()
  end)
  
  self.search_popup:on(event.TextChanged, function()
    local lines = vim.api.nvim_buf_get_lines(self.search_popup.bufnr, 0, 1, false)
    self.search_text = lines[1] or ""
    self:filter_titles()
    self:update_titles_display()
    self:update_preview()
  end)
  
  -- Mouse click support in titles
  self.titles_popup:on(event.CursorMoved, function()
    local cursor = vim.api.nvim_win_get_cursor(self.titles_popup.winid)
    local new_index = cursor[1]
    if new_index ~= self.selected_index and new_index <= #self.filtered_titles and new_index > 0 then
      self.selected_index = new_index
      self:update_titles_display()
      self:update_preview_immediate()
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
    vim.cmd("startinsert!")
  end)
end

-- Show the picker
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
  self:update_preview()
  
  -- Focus search and enter insert mode
  vim.api.nvim_set_current_win(self.search_popup.winid)
  vim.cmd("startinsert!")
end

-- Close the picker
function NuiPicker:close()
  self:cleanup_tmp_file()
  
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

-- Factory function
function M.new(opts)
  return NuiPicker:new(opts)
end

-- Main entry point
function M.show()
  local tips_module = require("neovim_tips.tips")
  local titles = tips_module.get_titles()
  
  if not titles or vim.tbl_isempty(titles) then
    vim.notify("No tips loaded. Please run :NeovimTipsLoad first to load tips, then try again.", vim.log.levels.WARN)
    return
  end
  
  -- Create picker instance
  local picker = M.new({
    get_content = function(title)
      return tips_module.get_description(title) or "Description not available"
    end,
    on_select = function(title)
      vim.notify("Selected: " .. title, vim.log.levels.INFO)
    end
  })
  
  picker:set_titles(titles)
  picker:show()
end

return M