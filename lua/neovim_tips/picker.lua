local M = {}

-- Custom picker class
local Picker = {}
Picker.__index = Picker

function Picker:new(opts)
  local picker = {
    opts = opts or {},
    -- Window and buffer IDs
    search_win = nil,
    search_buf = nil,
    titles_win = nil,
    titles_buf = nil,
    preview_win = nil,
    preview_buf = nil,
    -- State
    all_titles = {},
    filtered_titles = {},
    selected_index = 1,
    search_text = "",
    tmp_file = nil,
  }
  setmetatable(picker, Picker)
  return picker
end

-- Set the data source
function Picker:set_titles(titles)
  self.all_titles = titles
  self.filtered_titles = titles
end

-- Filter titles based on search text
function Picker:filter_titles()
  if self.search_text == "" then
    self.filtered_titles = self.all_titles
  else
    self.filtered_titles = {}
    local search_lower = string.lower(self.search_text)
    for _, title in ipairs(self.all_titles) do
      if string.find(string.lower(title), search_lower, 1, true) then
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
function Picker:update_titles_display()
  if not self.titles_buf then return end
  
  local lines = {}
  for i, title in ipairs(self.filtered_titles) do
    local prefix = (i == self.selected_index) and "> " or "  "
    table.insert(lines, prefix .. title)
  end
  
  vim.api.nvim_buf_set_lines(self.titles_buf, 0, -1, false, lines)
end

-- Update preview with selected tip content
function Picker:update_preview()
  if not self.preview_buf or #self.filtered_titles == 0 then return end
  
  local selected_title = self.filtered_titles[self.selected_index]
  if not selected_title then return end
  
  -- Get tip content (placeholder - will be provided by caller)
  local content = self.opts.get_content and self.opts.get_content(selected_title) or "No content available"
  
  -- Create temporary file for markdown rendering
  self:cleanup_tmp_file()
  self.tmp_file = os.tmpname() .. ".md"
  local file = io.open(self.tmp_file, "w")
  if file then
    file:write(content)
    file:close()
  end
  
  -- Read file content into preview buffer
  local lines = {}
  if vim.fn.filereadable(self.tmp_file) == 1 then
    lines = vim.fn.readfile(self.tmp_file)
  else
    lines = {"No content available"}
  end
  
  vim.api.nvim_buf_set_lines(self.preview_buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(self.preview_buf, "filetype", "markdown")
end

-- Clean up temporary file
function Picker:cleanup_tmp_file()
  if self.tmp_file and vim.fn.filereadable(self.tmp_file) == 1 then
    local ok, err = pcall(os.remove, self.tmp_file)
    if not ok then
      vim.notify("Failed to remove temporary file: " .. err, vim.log.levels.WARN)
    end
    self.tmp_file = nil
  end
end

-- Create the floating windows
function Picker:create_windows()
  local width = vim.o.columns
  local height = vim.o.lines
  
  -- Calculate dimensions
  local win_width = math.floor(width * 0.9)
  local win_height = math.floor(height * 0.8)
  local row = math.floor((height - win_height) / 2)
  local col = math.floor((width - win_width) / 2)
  
  -- Search input (top)
  local search_height = 1
  self.search_buf = vim.api.nvim_create_buf(false, true)
  self.search_win = vim.api.nvim_open_win(self.search_buf, true, {
    relative = "editor",
    width = win_width,
    height = search_height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " Search Tips ",
    title_pos = "center",
  })
  
  -- Titles list (bottom left)
  local content_height = win_height - search_height - 1
  local titles_width = math.floor(win_width * 0.4)
  self.titles_buf = vim.api.nvim_create_buf(false, true)
  self.titles_win = vim.api.nvim_open_win(self.titles_buf, false, {
    relative = "editor",
    width = titles_width,
    height = content_height,
    row = row + search_height + 1,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " Tips ",
    title_pos = "center",
  })
  
  -- Preview (bottom right)
  local preview_width = win_width - titles_width - 1
  self.preview_buf = vim.api.nvim_create_buf(false, true)
  self.preview_win = vim.api.nvim_open_win(self.preview_buf, false, {
    relative = "editor",
    width = preview_width,
    height = content_height,
    row = row + search_height + 1,
    col = col + titles_width + 1,
    style = "minimal",
    border = "rounded",
    title = " Preview ",
    title_pos = "center",
  })
  
  -- Set buffer options
  vim.api.nvim_buf_set_option(self.search_buf, "buftype", "prompt")
  vim.api.nvim_buf_set_option(self.titles_buf, "modifiable", false)
  vim.api.nvim_buf_set_option(self.preview_buf, "modifiable", false)
  
  -- Set window options
  vim.api.nvim_win_set_option(self.preview_win, "wrap", true)
  vim.api.nvim_win_set_option(self.preview_win, "number", false)
  vim.api.nvim_win_set_option(self.titles_win, "number", false)
end

-- Set up key mappings
function Picker:setup_keymaps()
  local function close_picker()
    self:close()
  end
  
  local function move_down()
    if self.selected_index < #self.filtered_titles then
      self.selected_index = self.selected_index + 1
      self:update_titles_display()
      self:update_preview()
    end
  end
  
  local function move_up()
    if self.selected_index > 1 then
      self.selected_index = self.selected_index - 1
      self:update_titles_display()
      self:update_preview()
    end
  end
  
  local function select_item()
    if self.opts.on_select and #self.filtered_titles > 0 then
      local selected = self.filtered_titles[self.selected_index]
      self.opts.on_select(selected)
    end
    self:close()
  end
  
  -- Key mappings for search buffer
  local opts = { buffer = self.search_buf, nowait = true, silent = true }
  vim.keymap.set("i", "<Esc>", close_picker, opts)
  vim.keymap.set("i", "<C-c>", close_picker, opts)
  vim.keymap.set("i", "<CR>", select_item, opts)
  vim.keymap.set("i", "<Down>", move_down, opts)
  vim.keymap.set("i", "<Up>", move_up, opts)
  vim.keymap.set("i", "<C-j>", move_down, opts)
  vim.keymap.set("i", "<C-k>", move_up, opts)
  
  -- Normal mode mappings
  vim.keymap.set("n", "<Esc>", close_picker, opts)
  vim.keymap.set("n", "q", close_picker, opts)
  vim.keymap.set("n", "<CR>", select_item, opts)
end

-- Set up autocmds for real-time filtering
function Picker:setup_autocmds()
  local group = vim.api.nvim_create_augroup("NeovimTipsPicker", { clear = true })
  
  -- Real-time search filtering
  vim.api.nvim_create_autocmd({ "TextChangedI", "TextChanged" }, {
    group = group,
    buffer = self.search_buf,
    callback = function()
      -- Get current search text
      local lines = vim.api.nvim_buf_get_lines(self.search_buf, 0, 1, false)
      self.search_text = lines[1] or ""
      
      -- Filter and update display
      self:filter_titles()
      self:update_titles_display()
      self:update_preview()
    end,
  })
  
  -- Cleanup on buffer delete
  vim.api.nvim_create_autocmd("BufDelete", {
    group = group,
    buffer = self.search_buf,
    callback = function()
      self:close()
    end,
  })
end

-- Show the picker
function Picker:show()
  if not self.all_titles or #self.all_titles == 0 then
    vim.notify("No titles available", vim.log.levels.INFO)
    return
  end
  
  self:create_windows()
  self:setup_keymaps()
  self:setup_autocmds()
  
  -- Initial display
  self:filter_titles()
  self:update_titles_display()
  self:update_preview()
  
  -- Focus search window and enter insert mode
  vim.api.nvim_set_current_win(self.search_win)
  vim.cmd("startinsert")
end

-- Close the picker
function Picker:close()
  self:cleanup_tmp_file()
  
  -- Close windows
  if self.search_win and vim.api.nvim_win_is_valid(self.search_win) then
    vim.api.nvim_win_close(self.search_win, true)
  end
  if self.titles_win and vim.api.nvim_win_is_valid(self.titles_win) then
    vim.api.nvim_win_close(self.titles_win, true)
  end
  if self.preview_win and vim.api.nvim_win_is_valid(self.preview_win) then
    vim.api.nvim_win_close(self.preview_win, true)
  end
  
  -- Delete buffers
  if self.search_buf and vim.api.nvim_buf_is_valid(self.search_buf) then
    vim.api.nvim_buf_delete(self.search_buf, { force = true })
  end
  if self.titles_buf and vim.api.nvim_buf_is_valid(self.titles_buf) then
    vim.api.nvim_buf_delete(self.titles_buf, { force = true })
  end
  if self.preview_buf and vim.api.nvim_buf_is_valid(self.preview_buf) then
    vim.api.nvim_buf_delete(self.preview_buf, { force = true })
  end
  
  -- Clear autocmds
  vim.api.nvim_create_augroup("NeovimTipsPicker", { clear = true })
end

-- Factory function
function M.new(opts)
  return Picker:new(opts)
end

return M