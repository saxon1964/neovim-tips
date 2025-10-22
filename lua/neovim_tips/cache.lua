---@class NeovimTipsCache
---Caching system for parsed tips to avoid repeated markdown parsing
local M = {}

local utils = require("neovim_tips.utils")

---Get cache file path
---@return string path Path to cache file
local function get_cache_path()
  return vim.fn.stdpath("cache") .. "/neovim_tips/tips_cache.lua"
end

---Get cache metadata path
---@return string path Path to cache metadata file
local function get_metadata_path()
  return vim.fn.stdpath("cache") .. "/neovim_tips/cache_metadata.lua"
end

---Serialize a Lua table to string format
---@param tbl table Table to serialize
---@param indent number Current indentation level
---@return string serialized Serialized table as Lua code
local function serialize_table(tbl, indent)
  indent = indent or 0
  local spaces = string.rep("  ", indent)
  local lines = {}

  table.insert(lines, "{")

  for k, v in pairs(tbl) do
    local key_str
    if type(k) == "string" then
      -- Check if key is a valid identifier
      if k:match("^[%a_][%w_]*$") then
        key_str = k
      else
        key_str = string.format("[%q]", k)
      end
    else
      key_str = "[" .. tostring(k) .. "]"
    end

    local value_str
    if type(v) == "string" then
      value_str = string.format("%q", v)
    elseif type(v) == "number" or type(v) == "boolean" then
      value_str = tostring(v)
    elseif type(v) == "table" then
      value_str = serialize_table(v, indent + 1)
    else
      value_str = "nil"
    end

    table.insert(lines, spaces .. "  " .. key_str .. " = " .. value_str .. ",")
  end

  table.insert(lines, spaces .. "}")

  return table.concat(lines, "\n")
end

---Calculate hash of directory contents (modification times)
---@param dir_path string Directory path
---@return string hash Hash representing directory state
local function hash_directory(dir_path)
  local files = {}
  local handle = vim.loop.fs_scandir(dir_path)
  if not handle then
    return ""
  end

  while true do
    local name, type = vim.loop.fs_scandir_next(handle)
    if not name then break end

    if type == "file" and name:match("%.md$") then
      local file_path = dir_path .. "/" .. name
      local stat = vim.loop.fs_stat(file_path)
      if stat then
        table.insert(files, name .. ":" .. stat.mtime.sec)
      end
    end
  end

  table.sort(files)
  return table.concat(files, "|")
end

---Calculate hash of single file
---@param file_path string File path
---@return string hash Hash representing file state
local function hash_file(file_path)
  local stat = vim.loop.fs_stat(file_path)
  if stat then
    return tostring(stat.mtime.sec) .. ":" .. tostring(stat.size)
  end
  return ""
end

---Create cache metadata based on source directories/files
---@param builtin_dir string Path to builtin tips directory
---@param user_file string Path to user tips file
---@return table metadata Cache metadata with hashes
local function create_metadata(builtin_dir, user_file)
  return {
    version = 1,
    timestamp = os.time(),
    builtin_hash = hash_directory(builtin_dir),
    user_hash = hash_file(user_file),
    nvim_version = vim.version().minor, -- Track Neovim version
  }
end

---Check if cache is valid
---@param builtin_dir string Path to builtin tips directory
---@param user_file string Path to user tips file
---@return boolean valid True if cache is valid and up-to-date
function M.is_valid(builtin_dir, user_file)
  local metadata_path = get_metadata_path()

  -- Check if cache files exist
  if vim.fn.filereadable(get_cache_path()) == 0 or
     vim.fn.filereadable(metadata_path) == 0 then
    return false
  end

  -- Load and check metadata
  local ok, metadata = pcall(dofile, metadata_path)
  if not ok or not metadata then
    return false
  end

  -- Check version
  if metadata.version ~= 1 then
    return false
  end

  -- Check Neovim version (invalidate if major version changed)
  if metadata.nvim_version ~= vim.version().minor then
    return false
  end

  -- Check if source files changed
  local current_builtin_hash = hash_directory(builtin_dir)
  local current_user_hash = hash_file(user_file)

  if metadata.builtin_hash ~= current_builtin_hash or
     metadata.user_hash ~= current_user_hash then
    return false
  end

  return true
end

---Save tips to cache
---@param tips Tip[] Array of parsed tips
---@param builtin_dir string Path to builtin tips directory
---@param user_file string Path to user tips file
---@return boolean success True if cache was saved successfully
function M.save(tips, builtin_dir, user_file)
  local cache_path = get_cache_path()
  local metadata_path = get_metadata_path()

  -- Create cache directory
  local cache_dir = vim.fn.fnamemodify(cache_path, ":h")
  vim.fn.mkdir(cache_dir, "p")

  -- Serialize tips data
  local serialized = "return " .. serialize_table(tips, 0)

  -- Write cache file
  local cache_file = io.open(cache_path, "w")
  if not cache_file then
    utils.warn("Failed to write cache file")
    return false
  end

  cache_file:write(serialized)
  cache_file:close()

  -- Write metadata
  local metadata = create_metadata(builtin_dir, user_file)
  local metadata_serialized = "return " .. serialize_table(metadata, 0)

  local metadata_file = io.open(metadata_path, "w")
  if not metadata_file then
    utils.warn("Failed to write cache metadata")
    return false
  end

  metadata_file:write(metadata_serialized)
  metadata_file:close()

  return true
end

---Load tips from cache
---@return Tip[]|nil tips Array of cached tips, or nil if load failed
function M.load()
  local cache_path = get_cache_path()

  if vim.fn.filereadable(cache_path) == 0 then
    return nil
  end

  local ok, tips = pcall(dofile, cache_path)
  if not ok or not tips then
    utils.warn("Failed to load cache, will regenerate")
    return nil
  end

  return tips
end

---Clear cache files
---@return nil
function M.clear()
  local cache_path = get_cache_path()
  local metadata_path = get_metadata_path()

  -- Remove cache files
  vim.fn.delete(cache_path)
  vim.fn.delete(metadata_path)
end

---Get cache info for debugging
---@return table info Cache information
function M.info()
  local cache_path = get_cache_path()
  local metadata_path = get_metadata_path()

  local info = {
    cache_exists = vim.fn.filereadable(cache_path) == 1,
    metadata_exists = vim.fn.filereadable(metadata_path) == 1,
    cache_path = cache_path,
    metadata_path = metadata_path,
  }

  if info.cache_exists then
    local stat = vim.loop.fs_stat(cache_path)
    if stat then
      info.cache_size = stat.size
      info.cache_mtime = os.date("%Y-%m-%d %H:%M:%S", stat.mtime.sec)
    end
  end

  if info.metadata_exists then
    local ok, metadata = pcall(dofile, metadata_path)
    if ok and metadata then
      info.metadata = metadata
    end
  end

  return info
end

return M
