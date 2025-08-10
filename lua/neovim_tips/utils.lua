local M = {}

-- Lua: A funny language without a string trim function
function M.trim(s)
  return s:match("^%s*(.-)%s*$")
end

-- Create a file and its parent directories and write initial content
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

return M

