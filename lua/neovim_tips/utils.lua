---@class NeovimTipsUtils
---Utility functions for file operations, string handling, and async execution
local M = {}

---Display a message in a notification
---@param message string Message to display
function M.info(message)
  vim.notify(message, vim.log.levels.INFO, { title = "Neovim Tips" })
end

---Display a warning message in a notification
---@param message string Message to display
function M.warn(message)
  vim.notify(message, vim.log.levels.WARN, { title = "Neovim Tips" })
end

---Display an error message in a notification
---@param message string Message to display
function M.error(message)
  vim.notify(message, vim.log.levels.ERROR, { title = "Neovim Tips" })
end

---Trim whitespace from both ends of a string
---@param s string String to trim
---@return string trimmed Trimmed string
function M.trim(s)
  return s:match("^%s*(.-)%s*$")
end

---Create a file and its parent directories with initial content
---Only creates the file if it doesn't already exist
---@param filepath string Full path to the file to create
---@param content string Initial content to write to the file
---@return nil
function M.create_file_and_dirs(filepath, content)
  -- Check if the file already exists
  if vim.fn.filereadable(filepath) == 1 then return end

  -- Get the directory path from the full file path
  local dirpath = vim.fn.fnamemodify(filepath, ":h")

  -- Check if the directory exists, if not, create it
  -- The 'p' flag makes mkdir create parent directories as needed
  if vim.fn.isdirectory(dirpath) == 0 then
    vim.fn.mkdir(dirpath, "p")
  end

  -- Create the empty file
  local file = io.open(filepath, "w")
  if file then
    file:write(content)
    io.close(file)
  else
    M.error("Failed to create file user tips file: " .. filepath)
  end
end

---Execute a function asynchronously with callback
---Uses vim.loop timer to run function in background and schedule callback
---@param fn function Function to execute asynchronously
---@param callback function Callback function called with (ok, result) parameters
---@return nil
function M.run_async(fn, callback)
  local timer = vim.loop.new_timer()
  timer:start(0, 0, function()
    timer:stop()
    timer:close()
    local ok, result = pcall(fn)
    vim.schedule(function()
      callback(ok, result)
    end)
  end)
end

---Close plugin-related floating windows to prevent layering issues
---Closes daily tip and picker windows by detecting their buffer names/filetypes
---@return nil
function M.close_plugin_windows()
  local wins = vim.api.nvim_list_wins()
  for _, win in ipairs(wins) do
    local ok, win_config = pcall(vim.api.nvim_win_get_config, win)
    if ok and win_config.relative ~= "" then -- It's a floating window
      local buf = vim.api.nvim_win_get_buf(win)
      local buf_name = vim.api.nvim_buf_get_name(buf)
      local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })

      -- Close daily tip or picker-related windows
      if buf_name:match("daily_tip") or
          buf_name:match("neovim%-tips") or
          filetype == "markdown" or
          filetype == "neovim-tips-search" then
        vim.api.nvim_win_close(win, false)
      end
    end
  end
end

return M
