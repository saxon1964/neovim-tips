# Title: Custom completion function basics
# Category: Completion
# Tags: completion, completefunc, custom, omnifunc
---
Create custom completion functions using `completefunc` or `omnifunc` for domain-specific completions.

```lua
-- Basic completion function signature
function MyCompleteFunc(findstart, base)
  if findstart == 1 then
    -- Return the column where completion starts
    local line = vim.api.nvim_get_current_line()
    local col = vim.fn.col('.') - 1

    -- Find start of word
    while col > 0 and line:sub(col, col):match('[%w_]') do
      col = col - 1
    end

    return col
  else
    -- Return list of matches for 'base'
    local matches = {}

    local words = {'hello', 'world', 'help', 'welcome'}
    for _, word in ipairs(words) do
      if word:find('^' .. base) then
        table.insert(matches, word)
      end
    end

    return matches
  end
end

-- Set as completion function
vim.api.nvim_create_user_command('SetMyComplete', function()
  vim.opt_local.completefunc = 'v:lua.MyCompleteFunc'
end, {})

-- Use with Ctrl-X Ctrl-U in insert mode
```
***
# Title: Completion items with detailed info
# Category: Completion
# Tags: completion, items, menu, info, kind
---
Return completion items with additional metadata like menu text, info, and kind.

```lua
function DetailedComplete(findstart, base)
  if findstart == 1 then
    local line = vim.api.nvim_get_current_line()
    local col = vim.fn.col('.') - 1
    while col > 0 and line:sub(col, col):match('[%w_]') do
      col = col - 1
    end
    return col
  else
    -- Return items with metadata
    return {
      {
        word = "function",
        abbr = "func",           -- Show "func" in completion menu
        menu = "[Keyword]",       -- Category/source
        info = "Define a function", -- Preview window info
        kind = "f",              -- Single letter kind (f=function)
        icase = 1,               -- Case-insensitive matching
        dup = 1,                 -- Allow duplicates
      },
      {
        word = "variable",
        abbr = "var",
        menu = "[Keyword]",
        info = "Declare a variable",
        kind = "v",
      },
      {
        word = "return",
        abbr = "ret",
        menu = "[Keyword]",
        info = "Return from function",
        kind = "k",
      },
    }
  end
end

vim.opt.completefunc = 'v:lua.DetailedComplete'
```
***
# Title: Context-aware completion
# Category: Completion
# Tags: completion, context, smart, aware
---
Build completion that adapts based on cursor context like inside function, string, or comment.

```lua
-- Get context at cursor
local function get_context()
  local node = vim.treesitter.get_node()

  while node do
    local type = node:type()

    if type == "string" then
      return "string"
    elseif type == "comment" then
      return "comment"
    elseif type == "function_declaration" or type == "function_definition" then
      return "function"
    end

    node = node:parent()
  end

  return "normal"
end

function ContextAwareComplete(findstart, base)
  if findstart == 1 then
    local line = vim.api.nvim_get_current_line()
    local col = vim.fn.col('.') - 1
    while col > 0 and line:sub(col, col):match('[%w_]') do
      col = col - 1
    end
    return col
  else
    local context = get_context()
    local items = {}

    if context == "string" then
      -- String-specific completions
      items = {
        {word = "format", menu = "[String Method]"},
        {word = "match", menu = "[String Method]"},
        {word = "gsub", menu = "[String Method]"},
      }
    elseif context == "function" then
      -- Function-specific completions
      items = {
        {word = "return", menu = "[Keyword]"},
        {word = "local", menu = "[Keyword]"},
        {word = "end", menu = "[Keyword]"},
      }
    else
      -- General completions
      items = {
        {word = "function", menu = "[Keyword]"},
        {word = "if", menu = "[Keyword]"},
        {word = "for", menu = "[Keyword]"},
      }
    end

    -- Filter by base
    local matches = {}
    for _, item in ipairs(items) do
      if item.word:find('^' .. vim.pesc(base)) then
        table.insert(matches, item)
      end
    end

    return matches
  end
end

vim.opt.completefunc = 'v:lua.ContextAwareComplete'
```
***
# Title: Async completion with vim.schedule
# Category: Completion
# Tags: completion, async, performance, schedule
---
Use `vim.schedule()` to perform expensive completion operations without blocking the UI.

```lua
local cached_items = nil
local cache_time = 0
local CACHE_DURATION = 5000  -- 5 seconds

function AsyncComplete(findstart, base)
  if findstart == 1 then
    local line = vim.api.nvim_get_current_line()
    local col = vim.fn.col('.') - 1
    while col > 0 and line:sub(col, col):match('[%w_]') do
      col = col - 1
    end
    return col
  else
    local now = vim.loop.now()

    -- Use cache if fresh
    if cached_items and (now - cache_time) < CACHE_DURATION then
      return vim.tbl_filter(function(item)
        return item.word:find('^' .. vim.pesc(base))
      end, cached_items)
    end

    -- Schedule async update
    vim.schedule(function()
      -- Expensive operation (e.g., file system search, API call)
      local items = {}

      -- Example: Get all Lua functions in runtime path
      local lua_files = vim.api.nvim_get_runtime_file('**/*.lua', true)

      for _, file in ipairs(lua_files) do
        local basename = vim.fn.fnamemodify(file, ':t:r')
        table.insert(items, {
          word = basename,
          menu = '[Module]',
        })
      end

      -- Update cache
      cached_items = items
      cache_time = now
    end)

    -- Return empty or cached for now
    return cached_items or {}
  end
end

vim.opt.completefunc = 'v:lua.AsyncComplete'
```
***
# Title: Fuzzy matching completion
# Category: Completion
# Tags: completion, fuzzy, matching, filter
---
Implement fuzzy matching for completion items for more flexible matching.

```lua
-- Simple fuzzy match function
local function fuzzy_match(str, pattern)
  local pattern_idx = 1
  local str_idx = 1

  while pattern_idx <= #pattern and str_idx <= #str do
    if str:sub(str_idx, str_idx):lower() == pattern:sub(pattern_idx, pattern_idx):lower() then
      pattern_idx = pattern_idx + 1
    end
    str_idx = str_idx + 1
  end

  return pattern_idx > #pattern
end

-- Score fuzzy match (consecutive chars score higher)
local function fuzzy_score(str, pattern)
  if not fuzzy_match(str, pattern) then
    return 0
  end

  local score = 0
  local consecutive = 0

  local pattern_idx = 1
  for str_idx = 1, #str do
    if str:sub(str_idx, str_idx):lower() == pattern:sub(pattern_idx, pattern_idx):lower() then
      score = score + 1 + consecutive
      consecutive = consecutive + 1
      pattern_idx = pattern_idx + 1

      if pattern_idx > #pattern then
        break
      end
    else
      consecutive = 0
    end
  end

  return score
end

function FuzzyComplete(findstart, base)
  if findstart == 1 then
    local line = vim.api.nvim_get_current_line()
    local col = vim.fn.col('.') - 1
    while col > 0 and line:sub(col, col):match('[%w_]') do
      col = col - 1
    end
    return col
  else
    local all_items = {
      'apple', 'application', 'apply',
      'banana', 'band', 'background',
      'cherry', 'check', 'character',
    }

    -- Fuzzy match and score
    local matches = {}
    for _, word in ipairs(all_items) do
      local score = fuzzy_score(word, base)
      if score > 0 then
        table.insert(matches, {
          word = word,
          score = score,
        })
      end
    end

    -- Sort by score (highest first)
    table.sort(matches, function(a, b)
      return a.score > b.score
    end)

    return matches
  end
end

vim.opt.completefunc = 'v:lua.FuzzyComplete'
```
***
# Title: File path completion
# Category: Completion
# Tags: completion, files, paths, filesystem
---
Create custom file path completion that works in specific contexts.

```lua
function FilePathComplete(findstart, base)
  if findstart == 1 then
    -- Find start of path
    local line = vim.api.nvim_get_current_line()
    local col = vim.fn.col('.') - 1

    -- Look for path characters
    while col > 0 and line:sub(col, col):match('[%w_/%.~-]') do
      col = col - 1
    end

    return col
  else
    local matches = {}

    -- Expand ~ and environment variables
    base = vim.fn.expand(base)

    -- Get directory part
    local dir = vim.fn.fnamemodify(base, ':h')
    local partial = vim.fn.fnamemodify(base, ':t')

    -- Default to current directory
    if dir == base then
      dir = '.'
    end

    -- List files in directory
    local ok, files = pcall(vim.fn.readdir, dir)
    if not ok then
      return {}
    end

    for _, file in ipairs(files) do
      if file:find('^' .. vim.pesc(partial)) then
        local full_path = dir .. '/' .. file

        -- Check if directory
        local is_dir = vim.fn.isdirectory(full_path) == 1

        table.insert(matches, {
          word = file .. (is_dir and '/' or ''),
          menu = is_dir and '[Dir]' or '[File]',
          kind = is_dir and 'd' or 'f',
        })
      end
    end

    return matches
  end
end

-- Use for specific filetypes
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'lua', 'vim'},
  callback = function()
    vim.opt_local.completefunc = 'v:lua.FilePathComplete'
  end,
})
```
***
# Title: API/Module completion
# Category: Completion
# Tags: completion, api, modules, vim.api
---
Build completion for Vim/Neovim API functions and modules.

```lua
-- Cache API function names
local api_cache = nil

local function get_api_functions()
  if api_cache then
    return api_cache
  end

  local functions = {}

  -- Get all vim.api functions
  for name, _ in pairs(vim.api) do
    if type(vim.api[name]) == 'function' then
      table.insert(functions, {
        word = 'vim.api.' .. name,
        abbr = name,
        menu = '[API]',
        info = 'Neovim API function',
      })
    end
  end

  -- Get vim.fn functions (limited sample)
  for name, _ in pairs(vim.fn) do
    if type(vim.fn[name]) == 'function' then
      table.insert(functions, {
        word = 'vim.fn.' .. name,
        abbr = name,
        menu = '[Func]',
        info = 'Vim function',
      })
    end
  end

  api_cache = functions
  return functions
end

function ApiComplete(findstart, base)
  if findstart == 1 then
    local line = vim.api.nvim_get_current_line()
    local col = vim.fn.col('.') - 1

    -- Find start of vim.api. or vim.fn.
    while col > 0 and line:sub(col, col):match('[%w_.]') do
      col = col - 1
    end

    return col
  else
    local functions = get_api_functions()
    local matches = {}

    for _, func in ipairs(functions) do
      if func.word:find(vim.pesc(base)) then
        table.insert(matches, func)
      end
    end

    return matches
  end
end

-- Set for Lua files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    vim.opt_local.completefunc = 'v:lua.ApiComplete'
  end,
})
```
***
# Title: Snippet-style completion
# Category: Completion
# Tags: completion, snippets, templates, user-data
---
Create completion items that insert templates using `user_data` for custom behavior.

```lua
function SnippetComplete(findstart, base)
  if findstart == 1 then
    local line = vim.api.nvim_get_current_line()
    local col = vim.fn.col('.') - 1
    while col > 0 and line:sub(col, col):match('[%w_]') do
      col = col - 1
    end
    return col
  else
    return {
      {
        word = "function",
        abbr = "func",
        menu = "[Snippet]",
        info = "Function template",
        user_data = {
          snippet = "function ${1:name}(${2:args})\n\t${0}\nend"
        }
      },
      {
        word = "if",
        abbr = "if",
        menu = "[Snippet]",
        info = "If statement",
        user_data = {
          snippet = "if ${1:condition} then\n\t${0}\nend"
        }
      },
      {
        word = "for",
        abbr = "for",
        menu = "[Snippet]",
        info = "For loop",
        user_data = {
          snippet = "for ${1:i}, ${2:v} in ipairs(${3:table}) do\n\t${0}\nend"
        }
      },
    }
  end
end

-- Handle completion selection
vim.api.nvim_create_autocmd('CompleteDone', {
  callback = function()
    local completed_item = vim.v.completed_item

    if completed_item.user_data and
       type(completed_item.user_data) == 'table' and
       completed_item.user_data.snippet then

      -- Simple snippet expansion (replace ${n:text} with text)
      local snippet = completed_item.user_data.snippet
      local text = snippet:gsub('%${%d+:([^}]+)}', '%1')
      text = text:gsub('%${%d+}', '')

      -- Delete the completion word
      vim.cmd('normal! diw')

      -- Insert snippet
      local lines = vim.split(text, '\n')
      vim.api.nvim_put(lines, 'c', true, true)
    end
  end,
})

vim.opt.completefunc = 'v:lua.SnippetComplete'
```
***
# Title: Multi-source completion chaining
# Category: Completion
# Tags: completion, chaining, multiple-sources, aggregation
---
Combine multiple completion sources into a single completion function.

```lua
-- Define multiple completion sources
local sources = {}

sources.keywords = function(base)
  local keywords = {'function', 'if', 'then', 'else', 'end', 'return', 'local'}
  local matches = {}

  for _, kw in ipairs(keywords) do
    if kw:find('^' .. vim.pesc(base)) then
      table.insert(matches, {
        word = kw,
        menu = '[Keyword]',
        priority = 10,
      })
    end
  end

  return matches
end

sources.buffer_words = function(base)
  -- Get words from current buffer
  local words = {}
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local text = table.concat(lines, '\n')

  for word in text:gmatch('[%w_]+') do
    if word:find('^' .. vim.pesc(base)) and #word > 3 then
      words[word] = true
    end
  end

  local matches = {}
  for word in pairs(words) do
    table.insert(matches, {
      word = word,
      menu = '[Buffer]',
      priority = 5,
    })
  end

  return matches
end

sources.api = function(base)
  if not base:match('^vim%.') then
    return {}
  end

  local matches = {}
  for name in pairs(vim.api) do
    local full = 'vim.api.' .. name
    if full:find(vim.pesc(base)) then
      table.insert(matches, {
        word = full,
        menu = '[API]',
        priority = 15,
      })
    end
  end

  return matches
end

function ChainedComplete(findstart, base)
  if findstart == 1 then
    local line = vim.api.nvim_get_current_line()
    local col = vim.fn.col('.') - 1
    while col > 0 and line:sub(col, col):match('[%w_.]') do
      col = col - 1
    end
    return col
  else
    local all_matches = {}

    -- Gather from all sources
    for name, source_func in pairs(sources) do
      local items = source_func(base)
      for _, item in ipairs(items) do
        table.insert(all_matches, item)
      end
    end

    -- Sort by priority (higher first)
    table.sort(all_matches, function(a, b)
      return (a.priority or 0) > (b.priority or 0)
    end)

    return all_matches
  end
end

vim.opt.completefunc = 'v:lua.ChainedComplete'
```
***
# Title: LSP-style completion with documentation
# Category: Completion
# Tags: completion, lsp, documentation, preview
---
Create rich completion items with documentation preview like LSP.

```lua
local completion_items = {
  {
    label = "print",
    kind = "Function",
    detail = "print(...)",
    documentation = {
      kind = "markdown",
      value = [[
Print arguments to stdout.

**Parameters:**
- `...` - Values to print

**Example:**
```lua
print("Hello", "World")
-- Output: Hello World
```
      ]],
    },
  },
  {
    label = "require",
    kind = "Function",
    detail = "require(modname)",
    documentation = {
      kind = "markdown",
      value = [[
Load and return a module.

**Parameters:**
- `modname` (string) - Module name

**Returns:**
- Module table

**Example:**
```lua
local mymod = require('mymodule')
```
      ]],
    },
  },
}

function LspStyleComplete(findstart, base)
  if findstart == 1 then
    local line = vim.api.nvim_get_current_line()
    local col = vim.fn.col('.') - 1
    while col > 0 and line:sub(col, col):match('[%w_]') do
      col = col - 1
    end
    return col
  else
    local matches = {}

    for _, item in ipairs(completion_items) do
      if item.label:find('^' .. vim.pesc(base)) then
        table.insert(matches, {
          word = item.label,
          abbr = item.label,
          menu = string.format('[%s]', item.kind),
          info = item.documentation.value,
          kind = item.kind:sub(1, 1):lower(),
        })
      end
    end

    return matches
  end
end

vim.opt.completefunc = 'v:lua.LspStyleComplete'

-- Enable preview window for completion
vim.opt.completeopt = {'menu', 'menuone', 'preview'}
```
***
# Title: Completion with external command
# Category: Completion
# Tags: completion, external, command, integration
---
Integrate external tools or commands into completion sources.

```lua
function ExternalComplete(findstart, base)
  if findstart == 1 then
    local line = vim.api.nvim_get_current_line()
    local col = vim.fn.col('.') - 1
    while col > 0 and line:sub(col, col):match('[%w_-]') do
      col = col - 1
    end
    return col
  else
    -- Example: Git branch completion
    local handle = io.popen('git branch --list 2>/dev/null')
    if not handle then
      return {}
    end

    local result = handle:read('*a')
    handle:close()

    local matches = {}
    for branch in result:gmatch('[^\n]+') do
      -- Remove * and whitespace
      branch = branch:gsub('^%s*%*?%s*', '')

      if branch:find(vim.pesc(base)) then
        table.insert(matches, {
          word = branch,
          menu = '[Git Branch]',
        })
      end
    end

    return matches
  end
end

-- Use for git commit messages
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'gitcommit',
  callback = function()
    vim.opt_local.completefunc = 'v:lua.ExternalComplete'
  end,
})
```
***
# Title: Cached completion for performance
# Category: Completion
# Tags: completion, cache, performance, optimization
---
Implement smart caching to avoid expensive re-computation on every keystroke.

```lua
local completion_cache = {}

local function get_cache_key(context)
  return string.format('%s:%s:%d',
    vim.bo.filetype,
    context,
    vim.b.changedtick or 0
  )
end

function CachedComplete(findstart, base)
  if findstart == 1 then
    local line = vim.api.nvim_get_current_line()
    local col = vim.fn.col('.') - 1
    while col > 0 and line:sub(col, col):match('[%w_]') do
      col = col - 1
    end
    return col
  else
    local cache_key = get_cache_key('complete')

    -- Check cache
    if completion_cache[cache_key] then
      local cached = completion_cache[cache_key]

      -- Filter cached results by current base
      return vim.tbl_filter(function(item)
        return item.word:find('^' .. vim.pesc(base))
      end, cached)
    end

    -- Generate fresh completion items (expensive operation)
    local items = {}

    -- ... expensive computation here ...
    local all_words = {}
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) then
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        for _, line in ipairs(lines) do
          for word in line:gmatch('[%w_]+') do
            if #word > 3 then
              all_words[word] = true
            end
          end
        end
      end
    end

    for word in pairs(all_words) do
      table.insert(items, {word = word, menu = '[Cached]'})
    end

    -- Store in cache
    completion_cache[cache_key] = items

    -- Filter by base
    return vim.tbl_filter(function(item)
      return item.word:find('^' .. vim.pesc(base))
    end, items)
  end
end

-- Clear cache on significant changes
vim.api.nvim_create_autocmd({'BufWritePost', 'BufEnter'}, {
  callback = function()
    completion_cache = {}
  end,
})

vim.opt.completefunc = 'v:lua.CachedComplete'
```
***
