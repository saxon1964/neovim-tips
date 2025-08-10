local M = {}

local config = require("neovim_tips.config")
local tips = require("neovim_tips.tips")

local builtin_file = config.options.builtin_file
local user_file = config.options.user_file

local function parse_tip_blocks(content)
  local parsed_tips = {}
  local current = {}
  local body_lines = {}
  local titles_seen = {}

  for line in content:gmatch("([^\r\n]*)\r?\n?") do
    local title = line:match("^#%s*Title:%s*(.+)")
    local category = line:match("^#%s*Category:%s*(.+)")
    local tags = line:match("^#%s*Tags:%s*(.+)")

    if title then
      if titles_seen[title] then
        vim.notify("Duplicate tip title found: " .. title, vim.log.levels.WARN)
        current = {} -- Skip adding this duplicate tip
      else
        current.title = title
        titles_seen[title] = true
      end
    elseif category then
      current.category = category
    elseif tags then
      current.tags = vim.split(tags, ",%s*")
    elseif line == "---" then
      body_lines = {}
    elseif line == "===" then
      current.description = table.concat(body_lines, "\n")
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

local function read_tip_file(path)
  local fd = io.open(path, "r")
  if not fd then return {} end
  local content = fd:read("*a")
  fd:close()
  return parse_tip_blocks(content)
end

local function ensure_user_file()
  local fd = io.open(user_file, "r")
  if not fd then
    local wf = io.open(user_file, "w")
    if wf then
      wf:write("# Your personal Neovim tips\n\n")
      wf:close()
    end
  else
    fd:close()
  end
end

function M.load()
  local builtin_tips = read_tip_file(builtin_file)
  ensure_user_file()
  local user_tips = read_tip_file(user_file)
  local all_tips = {}
  vim.list_extend(all_tips, builtin_tips)
  vim.list_extend(all_tips, user_tips)
  tips.set(all_tips)
end

return M
