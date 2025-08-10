local M = {}

local items = {}
local descriptions = {}
local all_tips = {}

function M.set(tips)
  all_tips = tips
  items = {}
  descriptions = {}
  for _, tip in ipairs(tips) do
    local line = tip.title
    if tip.category and #tip.category > 0 then
      line = string.format("%s [%s]", line, tip.category)
    end
    if tip.tags and #tip.tags > 0 then
      line = string.format("%s (%s)", line, table.concat(tip.tags, ","))
    end
    table.insert(items, line)
    descriptions[line] = tip.description
  end
  table.sort(items)
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

