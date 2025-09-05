---@class NeovimTipsTips
---Tips data management and formatting
local M = {}

---@class Tip
---@field title string The tip title
---@field category string|nil The tip category  
---@field tags string[]|nil List of tags for the tip
---@field description string The tip description/content

local titles = {}
local descriptions = {}
local all_tips = {}

---Set the tips data and build internal indexes
---Processes tips into searchable titles and formatted descriptions
---@param tips Tip[] Array of tip objects to process
---@return nil
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


---Get all tip titles for search and selection
---@return string[] titles Sorted array of tip titles
function M.get_titles()
  return titles
end

---Get formatted description for a specific tip
---@param title string The tip title to get description for
---@return string|nil description Formatted markdown description, or nil if not found
function M.get_description(title)
  return descriptions[title]
end

return M

