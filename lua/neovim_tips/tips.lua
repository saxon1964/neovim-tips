local M = {}

local titles = {}
local descriptions = {}
local all_tips = {}

function M.set(tips)
  all_tips = tips
  titles = {}
  descriptions = {}
  for _, tip in ipairs(tips) do
    local title = tip.title
    table.insert(titles, title)
    local description = {}
    table.insert(description, "## " .. tip.title)
    if tip.category and #tip.category > 0 then
      table.insert(description, "### Category: " .. tip.category)
    end
    if tip.tags and #tip.tags > 0 then
      table.insert(description, "### Tags: " .. table.concat(tip.tags, ", "))
    end
    table.insert(description, tip.description)
    descriptions[title] = table.concat(description, "\n\n")
  end
  table.sort(titles)
end

function M.get_tips()
  return all_tips
end

function M.get_titles()
  return titles
end

function M.get_description(title)
  return descriptions[title]
end

return M

