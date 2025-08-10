local M = {}

local items = {}
local descriptions = {}
local all_tips = {}

function M.set(tips)
  all_tips = tips
  items = {}
  descriptions = {}
  for _, tip in ipairs(tips) do
    local line = string.format("%s [%s] (%s)", tip.title, tip.category, table.concat(tip.tags, ","))
    table.insert(items, line)
    descriptions[line] = tip.description
  end
  table.sort(items)
  vim.notify("Tips sorted " .. #items .. " tips", vim.log.levels.INFO)
end

function M.get_tips()
  return all_tips
end

function M.get_items()
  return items
end

function M.get_description(item)
  return descriptions[item]
end

return M

