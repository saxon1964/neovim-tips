---@class NeovimTipsSearchParser
---Search query parsing functionality for the tips picker
local M = {}

---@class SearchQuery
---@field categories string[] Array of category filters
---@field tags string[] Array of tag filters
---@field title_words string[] Array of title word filters

---Parse search query to extract categories, tags, and title words
---Supports syntax: t:tag c:category and quoted multi-word values
---@param search_text string The search query to parse
---@return SearchQuery query Parsed query with categories, tags, and title_words arrays
function M.parse_search_query(search_text)
  local query = {
    categories = {},
    tags = {},
    title_words = {}
  }

  if not search_text or search_text == "" then
    return query
  end

  local search_lower = string.lower(search_text)
  local i = 1

  while i <= #search_lower do
    -- Skip whitespace
    while i <= #search_lower and search_lower:sub(i, i):match("%s") do
      i = i + 1
    end

    if i > #search_lower then break end

    local token_start = i
    local token = ""
    local is_prefix_token = false
    local prefix = ""

    -- Check if this starts with a prefix pattern (t: or c:)
    if i + 1 <= #search_lower and search_lower:sub(i + 1, i + 1) == ":" then
      local potential_prefix = search_lower:sub(i, i)
      if potential_prefix == "t" or potential_prefix == "c" then
        is_prefix_token = true
        prefix = potential_prefix
        i = i + 2 -- Skip past prefix:
      end
    end

    -- Now parse the value (could be quoted or unquoted)
    if i <= #search_lower then
      if search_lower:sub(i, i) == '"' then
        -- Quoted value
        i = i + 1 -- Skip opening quote
        local value_start = i
        -- Find closing quote
        while i <= #search_lower and search_lower:sub(i, i) ~= '"' do
          i = i + 1
        end
        token = search_lower:sub(value_start, i - 1)
        if i <= #search_lower then i = i + 1 end -- Skip closing quote
      else
        -- Unquoted value
        local value_start = i
        -- Find end of word
        while i <= #search_lower and not search_lower:sub(i, i):match("%s") do
          i = i + 1
        end
        token = search_lower:sub(value_start, i - 1)
      end
    end

    -- Only process tokens that are at least 2 characters or are quoted
    if #token >= 2 or (search_lower:sub(token_start, token_start) == '"') then
      if is_prefix_token then
        if prefix == "t" and #token > 0 then
          table.insert(query.tags, token)
        elseif prefix == "c" and #token > 0 then
          table.insert(query.categories, token)
        end
      else
        -- Regular title word
        if #token > 0 then
          table.insert(query.title_words, token)
        end
      end
    end

    -- If no prefix was detected, still need to advance past the token
    if not is_prefix_token then
      -- Token was already parsed above, continue
    end
  end

  return query
end

---Check if a tip's category matches any of the category filters
---@param tip_category string|nil The tip's category
---@param category_filters string[] Array of category filters to match
---@return boolean matches True if tip category matches any filter
function M.category_matches(tip_category, category_filters)
  if not tip_category or #category_filters == 0 then
    return #category_filters == 0
  end

  local category_lower = string.lower(tip_category)
  for _, filter in ipairs(category_filters) do
    if string.find(category_lower, filter, 1, true) then
      return true
    end
  end
  return false
end

---Check if a tip's tags match any of the tag filters
---@param tip_tags string[]|nil The tip's tags array
---@param tag_filters string[] Array of tag filters to match
---@return boolean matches True if tip has any matching tag
function M.tag_matches(tip_tags, tag_filters)
  if not tip_tags or #tag_filters == 0 then
    return #tag_filters == 0
  end

  for _, tip_tag in ipairs(tip_tags) do
    local tag_lower = string.lower(tip_tag)
    for _, filter in ipairs(tag_filters) do
      if string.find(tag_lower, filter, 1, true) then
        return true
      end
    end
  end
  return false
end

---Check if a title matches all title word filters
---@param title string The tip title
---@param title_word_filters string[] Array of words that must all be found in title
---@return boolean matches True if title contains all filter words
function M.title_matches(title, title_word_filters)
  if #title_word_filters == 0 then
    return true
  end

  local title_lower = string.lower(title)
  for _, word in ipairs(title_word_filters) do
    if not string.find(title_lower, word, 1, true) then
      return false
    end
  end
  return true
end

---Check if search text has help triggers (t:? or c:?)
---@param search_text string The search text to check
---@return string|nil trigger_type Returns "tag" or "category" if trigger found, nil otherwise
function M.check_help_triggers(search_text)
  if not search_text then return nil end

  if search_text:match("t:%?$") then
    return "tag"
  elseif search_text:match("c:%?$") then
    return "category"
  end
  return nil
end

return M