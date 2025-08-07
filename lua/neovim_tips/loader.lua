local M = {}
local config = require("neovim_tips.config")
local tips = require("neovim_tips.tips")

local function parse_tip_blocks(content)
  local parsed_tips = {}
  local current = {}
  local body_lines = {}
  local titles_seen = {}

  for line in content:gmatch("[^\r\n]+") do
    if line:match("^#%s*Title:%s*(.+)") then
      local title = line:match("^#%s*Title:%s*(.+)")
      if titles_seen[title] then
        vim.notify("Duplicate tip title found: " .. title, vim.log.levels.WARN)
        current = {} -- Skip adding this duplicate tip
      else
        current.title = title
        titles_seen[title] = true
      end
    elseif line:match("^#%s*Category:%s*(.+)") then
      current.category = line:match("^#%s*Category:%s*(.+)")
    elseif line:match("^#%s*Tags:%s*(.+)") then
      local tags = line:match("^#%s*Tags:%s*(.+)")
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
    else
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

local function ensure_user_file(path)
  local fd = io.open(path, "r")
  if not fd then
    local wf = io.open(path, "w")
    if wf then
      wf:write("-- Your personal Neovim tips\n")
      wf:close()
    end
  else
    fd:close()
  end
end

function M.load()
  local builtin_path = debug.getinfo(1, "S").source:sub(2):gsub("loader.lua", "../../data/builtin_tips.txt")
  local builtin = read_tip_file(builtin_path)
  ensure_user_file(config.options.user_file)
  local user = read_tip_file(config.options.user_file)
  local all_tips = {}
  vim.list_extend(all_tips, builtin)
  vim.list_extend(all_tips, user)
  tips.set(all_tips)
end

return M

