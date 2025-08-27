---@class NeovimTipsUtils
---Utility functions for file operations, string handling, and async execution
local M = {}

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
    vim.notify("Failed to create file user tips file: " .. filepath, vim.log.levels.ERROR)
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

return M

