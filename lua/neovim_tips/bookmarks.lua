---@class NeovimTipsBookmarks
---Bookmark management functionality for saving and retrieving favorite tips
local M = {}

---@class BookmarkData
---@field bookmarks string[] Array of bookmarked tip titles

---Get the path to the bookmarks file
---@return string path Path to bookmarks JSON file
local function get_bookmarks_file()
  return vim.fn.stdpath("data") .. "/neovim_tips/bookmarks.json"
end

---Read bookmarks from persistent storage
---@return string[] bookmarks Array of bookmarked tip titles
local function read_bookmarks()
  local bookmarks_file = get_bookmarks_file()
  local file = io.open(bookmarks_file, "r")
  if not file then
    return {}
  end

  local content = file:read("*all")
  file:close()

  local ok, data = pcall(vim.json.decode, content)
  if ok and data and data.bookmarks then
    return data.bookmarks
  end

  return {}
end

---Write bookmarks to persistent storage
---@param bookmarks string[] Array of tip titles to save
---@return nil
local function write_bookmarks(bookmarks)
  local bookmarks_file = get_bookmarks_file()
  local data = { bookmarks = bookmarks }

  -- Ensure directory exists
  local dir = vim.fn.fnamemodify(bookmarks_file, ":h")
  vim.fn.mkdir(dir, "p")

  local file = io.open(bookmarks_file, "w")
  if file then
    file:write(vim.json.encode(data))
    file:close()
  end
end

-- Cache for bookmarks to avoid file I/O on every check
local bookmarks_cache = nil

---Load bookmarks into cache
---@return nil
local function load_bookmarks_cache()
  if not bookmarks_cache then
    bookmarks_cache = {}
    local bookmarks = read_bookmarks()
    for _, title in ipairs(bookmarks) do
      bookmarks_cache[title] = true
    end
  end
end

---Save bookmarks cache to file
---@return nil
local function save_bookmarks_cache()
  if bookmarks_cache then
    local bookmarks = {}
    for title, _ in pairs(bookmarks_cache) do
      table.insert(bookmarks, title)
    end
    table.sort(bookmarks)
    write_bookmarks(bookmarks)
  end
end

---Check if a tip is bookmarked
---@param title string The tip title to check
---@return boolean is_bookmarked True if tip is bookmarked
function M.is_bookmarked(title)
  load_bookmarks_cache()
  return bookmarks_cache[title] == true
end

---Add a tip to bookmarks
---@param title string The tip title to bookmark
---@return nil
function M.add_bookmark(title)
  if not title or title == "" then
    return
  end
  
  load_bookmarks_cache()
  bookmarks_cache[title] = true
  save_bookmarks_cache()
end

---Remove a tip from bookmarks
---@param title string The tip title to unbookmark
---@return nil
function M.remove_bookmark(title)
  if not title or title == "" then
    return
  end
  
  load_bookmarks_cache()
  bookmarks_cache[title] = nil
  save_bookmarks_cache()
end

---Toggle bookmark status for a tip
---@param title string The tip title to toggle
---@return boolean new_status New bookmark status after toggle
function M.toggle_bookmark(title)
  if M.is_bookmarked(title) then
    M.remove_bookmark(title)
    return false
  else
    M.add_bookmark(title)
    return true
  end
end

---Get all bookmarked tip titles
---@return string[] bookmarks Array of bookmarked tip titles
function M.get_bookmarks()
  load_bookmarks_cache()
  local bookmarks = {}
  for title, _ in pairs(bookmarks_cache) do
    table.insert(bookmarks, title)
  end
  table.sort(bookmarks)
  return bookmarks
end

---Clear all bookmarks
---@return nil
function M.clear_all_bookmarks()
  bookmarks_cache = {}
  save_bookmarks_cache()
end

---Get count of bookmarked tips
---@return integer count Number of bookmarked tips
function M.get_bookmark_count()
  load_bookmarks_cache()
  local count = 0
  for _, _ in pairs(bookmarks_cache) do
    count = count + 1
  end
  return count
end

return M