local M = {}

local config = require("neovim_tips.config")
local tips = require("neovim_tips.tips")
local utils = require("neovim_tips.utils")

local builtin_dir = config.options.builtin_dir
local user_file = config.options.user_file

local titles_seen = {}

local function parse_tip_blocks(content, is_user_tips)
  local parsed_tips = {}
  local current = {}
  local body_lines = {}
  local prefix = is_user_tips and config.options.user_tip_prefix or ""

  for line in content:gmatch("([^\r\n]*)\r?\n?") do
    local title = line:match("^#%s*Title:%s*(.+)")
    local category = line:match("^#%s*Category:%s*(.+)")
    local tags = line:match("^#%s*Tags:%s*(.+)")

    if title then
      title = utils.trim(title)
      -- Add prefix for user tips if it doesn't already have one
      if is_user_tips and prefix ~= "" and title:sub(1, #prefix) ~= prefix then
        title = prefix .. title
      end
      if titles_seen[title] then
        if config.options.warn_on_conflicts then
          vim.notify("Duplicate tip title found: " .. title, vim.log.levels.WARN)
        end
        current = {} -- Skip adding this duplicate tip
      else
        current.title = title
        current.is_user_tip = is_user_tips or false
        titles_seen[title] = true
      end
    elseif category then
      current.category = utils.trim(category)
    elseif tags then
      local tags_table = vim.split(tags, ",%s*")
      local tags_table_trimmed = vim.tbl_map(utils.trim, tags_table)
      current.tags = vim.tbl_filter(function(tg) return tg ~= "" end, tags_table_trimmed)
      -- Add 'user' tag for user tips
      if is_user_tips then
        table.insert(current.tags, config.options.user_tips_tag)
      end
    elseif line == "---" then
      body_lines = {}
    elseif line == "===" then
      current.description = utils.trim(table.concat(body_lines, "\n"))
      if current.title then -- Ensure tip has a title and wasn't skipped
        table.insert(parsed_tips, current)
      end
      current = {}
      body_lines = {}
    elseif current.title then
      table.insert(body_lines, line)
    end
  end

  return parsed_tips
end

local function read_tip_file(path, is_user_tips)
  local fd = io.open(path, "r")
  if not fd then return {} end
  local content = fd:read("*a")
  fd:close()
  return parse_tip_blocks(content, is_user_tips)
end

local function read_tips_from_directory(dir_path, is_user_tips)
  local all_tips = {}
  ---@diagnostic disable-next-line: undefined-field
  local handle = vim.loop.fs_scandir(dir_path)
  if not handle then
    return all_tips
  end

  while true do
    ---@diagnostic disable-next-line: undefined-field
    local name, type = vim.loop.fs_scandir_next(handle)
    if not name then break end
    if type == "file" and name:match("%.md$") and name ~= "builtin_tips.md.backup" then
      local file_path = dir_path .. "/" .. name
      local moreTips = read_tip_file(file_path, is_user_tips)
      vim.list_extend(all_tips, moreTips)
    end
  end

  return all_tips
end

function M.load()
  titles_seen = {}

  local builtin_tips = read_tips_from_directory(builtin_dir, false)
  local user_tips = read_tip_file(user_file, true)

  local all_tips = {}
  vim.list_extend(all_tips, builtin_tips)
  vim.list_extend(all_tips, user_tips)

  tips.set(all_tips)
end

return M

