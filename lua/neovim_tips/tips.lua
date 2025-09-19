---@class NeovimTipsTips
---Tips data management and formatting
local M = {}

local md_supported = require("neovim_tips.renderer").renderer_available()

---@class Tip
---@field title string The tip title
---@field category string|nil The tip category
---@field tags string[]|nil List of tags for the tip
---@field description string The tip description/content

local tips = {}
local titles = {}
local tips_map = {}
local descriptions_map = {}

---Set the tips data and build internal indexes
---Processes tips into searchable titles and formatted descriptions
---@param all_tips Tip[] Array of tip objects to process
---@return nil
function M.set_tips(all_tips)
  tips = all_tips
  titles = {}
  tips_map = {}
  descriptions_map = {}
  for _, tip in ipairs(tips) do
    local title = tip.title
    table.insert(titles, title)
    tips_map[title] = tip
  end
  table.sort(titles, function(t1, t2) return t1:lower() < t2:lower() end)
end

---Get all tip data
---@return Tip[] tips Array of tip objects
function M.get_tips()
  return tips
end

---Get all tip titles for search and selection
---@return string[] titles Sorted array of tip titles
function M.get_titles()
  return titles
end

---Get tip object by title
---@param title string The tip title to get
---@return Tip|nil tip The tip object, or nil if not found
function M.get_tip_by_title(title)
  return tips_map[title]
end

---Get all unique categories from tips
---@return string[] categories Array of unique categories
function M.get_categories()
  local categories = {}
  local seen = {}
  for _, tip in ipairs(tips) do
    if tip.category and not seen[tip.category] then
      table.insert(categories, tip.category)
      seen[tip.category] = true
    end
  end
  table.sort(categories, function(a, b) return a:lower() < b:lower() end)
  return categories
end

---Get all unique tags from tips
---@return string[] tags Array of unique tags
function M.get_tags()
  local tags = {}
  local seen = {}
  for _, tip in ipairs(tips) do
    if tip.tags then
      for _, tag in ipairs(tip.tags) do
        if not seen[tag] then
          table.insert(tags, tag)
          seen[tag] = true
        end
      end
    end
  end
  table.sort(tags, function(a, b) return a:lower() < b:lower() end)
  return tags
end

---Get formatted description for a specific tip
---@param title string The tip title to get description for
---@return string|nil description Formatted markdown description, or nil if not found
function M.get_description(title)
  if (not descriptions_map[title]) then
    local tip = tips_map[title]
    local description = {}
    table.insert(description, "## " .. tip.title)
    if tip.category and #tip.category > 0 then
      table.insert(description, "### Category: " .. tip.category)
    end
    if tip.tags and #tip.tags > 0 then
      table.insert(description, "### Tags: " .. table.concat(tip.tags, ", "))
    end
    table.insert(description, tip.description)
    if not md_supported then
      table.insert(description, "NOTE: Consider installing render-markdown plugin for proper formatting.")
    end
    descriptions_map[title] = table.concat(description, "\n\n")
  end
  return descriptions_map[title]
end

return M
