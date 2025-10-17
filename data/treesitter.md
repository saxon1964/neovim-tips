# Title: Treesitter incremental selection
# Category: Treesitter
# Tags: treesitter, selection, incremental, expand
---
Use `Ctrl-space` to start incremental selection, then repeat to expand selection based on syntax tree.

```vim
Ctrl-space  " start/expand selection
Ctrl-x      " shrink selection (if configured)
```
***
# Title: Treesitter playground
# Category: Treesitter
# Tags: treesitter, playground, debug, explore
---
Use `:TSPlaygroundToggle` to open treesitter playground for exploring syntax tree interactively.

```vim
:TSPlaygroundToggle  " toggle treesitter playground
```
***
# Title: Treesitter folding
# Category: Treesitter
# Tags: treesitter, folding, code, structure
---
Set `foldmethod=expr` and `foldexpr=nvim_treesitter#foldexpr()` to use treesitter-based folding.

```vim
:set foldmethod=expr
:set foldexpr=nvim_treesitter#foldexpr()
```
***
# Title: Treesitter node navigation
# Category: Treesitter
# Tags: treesitter, navigation, nodes, movement
---
Use `]f` and `[f` to navigate between function nodes, or `]c` and `[c` for class nodes (if configured).

```vim
]f  " next function
[f  " previous function
]c  " next class
[c  " previous class
```
***
# Title: Treesitter swap nodes
# Category: Treesitter
# Tags: treesitter, swap, parameters, arguments
---
Use treesitter to swap function parameters or other syntax nodes using configured keymaps.

```vim
gs  " swap with next parameter/node
gS  " swap with previous parameter/node
```
***
# Title: Treesitter install parser
# Category: Treesitter
# Tags: treesitter, install, parser, language
---
Use `:TSInstall <language>` to install treesitter parser for a specific language.

```vim
:TSInstall lua        " install Lua parser
:TSInstall javascript " install JavaScript parser
:TSInstall all        " install all maintained parsers
```
***
# Title: Get treesitter node under cursor
# Category: Treesitter
# Tags: treesitter, api, node, cursor
---
Use `vim.treesitter.get_node()` to get the syntax node under the cursor. Essential for building treesitter-based features.

```lua
-- Get node under cursor
local node = vim.treesitter.get_node()

if node then
  print("Node type:", node:type())
  print("Node text:", vim.treesitter.get_node_text(node, 0))

  -- Get node range
  local start_row, start_col, end_row, end_col = node:range()
  print(string.format("Range: [%d,%d] to [%d,%d]",
    start_row, start_col, end_row, end_col))
end
```
***
# Title: Navigate treesitter tree programmatically
# Category: Treesitter
# Tags: treesitter, api, tree, navigation
---
Use treesitter node methods to traverse the syntax tree and find related nodes.

```lua
local node = vim.treesitter.get_node()

if node then
  -- Get parent node
  local parent = node:parent()

  -- Get next/previous sibling
  local next_sibling = node:next_sibling()
  local prev_sibling = node:prev_sibling()

  -- Get children
  for child in node:iter_children() do
    print("Child type:", child:type())
  end

  -- Get named children only (skip punctuation, etc.)
  for child in node:iter_children() do
    if child:named() then
      print("Named child:", child:type())
    end
  end

  -- Find parent of specific type
  while node do
    if node:type() == "function_declaration" then
      print("Found function!")
      break
    end
    node = node:parent()
  end
end
```
***
# Title: Write custom treesitter queries
# Category: Treesitter
# Tags: treesitter, queries, pattern-matching
---
Use treesitter query language to find patterns in code. Queries use S-expressions to match syntax nodes.

```lua
-- Query to find all function calls
local query = vim.treesitter.query.parse("lua", [[
  (function_call
    name: (identifier) @function.name
    arguments: (arguments) @function.args)
]])

local parser = vim.treesitter.get_parser(0, "lua")
local tree = parser:parse()[1]
local root = tree:root()

-- Execute query
for id, node, metadata in query:iter_captures(root, 0, 0, -1) do
  local name = query.captures[id]
  local text = vim.treesitter.get_node_text(node, 0)
  print(name .. ":", text)
end
```
***
# Title: Find all nodes of specific type
# Category: Treesitter
# Tags: treesitter, queries, search, nodes
---
Use queries to find all nodes matching a specific type in the buffer.

```lua
-- Find all function definitions in Lua
local function find_functions(bufnr)
  bufnr = bufnr or 0
  local parser = vim.treesitter.get_parser(bufnr, "lua")
  local tree = parser:parse()[1]
  local root = tree:root()

  local query = vim.treesitter.query.parse("lua", [[
    (function_declaration
      name: (identifier) @name) @function

    (assignment_statement
      (variable_list
        name: (identifier) @name)
      (expression_list
        value: (function_definition) @function))
  ]])

  local functions = {}
  for id, node in query:iter_captures(root, bufnr, 0, -1) do
    if query.captures[id] == "name" then
      local func_name = vim.treesitter.get_node_text(node, bufnr)
      local row, col = node:start()
      table.insert(functions, {
        name = func_name,
        line = row + 1,
        col = col
      })
    end
  end

  return functions
end

-- Usage
local funcs = find_functions()
for _, f in ipairs(funcs) do
  print(string.format("%s at line %d", f.name, f.line))
end
```
***
# Title: Create custom treesitter text objects
# Category: Treesitter
# Tags: treesitter, text-objects, custom, selection
---
Use treesitter queries to define custom text objects for inner/outer selections.

```lua
-- Define custom text object for function body
local query = vim.treesitter.query.parse("lua", [[
  (function_declaration
    body: (block) @function.inner) @function.outer

  (function_definition
    body: (block) @function.inner) @function.outer
]])

-- Select function inner (body only)
local function select_function_inner()
  local node = vim.treesitter.get_node()

  -- Find parent function
  while node do
    if node:type() == "function_declaration" or
       node:type() == "function_definition" then
      -- Find block child
      for child in node:iter_children() do
        if child:type() == "block" then
          local start_row, start_col, end_row, end_col = child:range()
          -- Select range
          vim.api.nvim_win_set_cursor(0, {start_row + 1, start_col})
          vim.cmd("normal! v")
          vim.api.nvim_win_set_cursor(0, {end_row + 1, end_col - 1})
          return
        end
      end
    end
    node = node:parent()
  end
end

-- Map to 'if' (inner function)
vim.keymap.set({"o", "x"}, "if", select_function_inner,
  {desc = "Select inner function"})
```
***
# Title: Highlight custom patterns with treesitter
# Category: Treesitter
# Tags: treesitter, highlight, queries, custom
---
Use treesitter queries to add custom syntax highlighting beyond default parsers.

```lua
-- Highlight TODO comments specially
local ns_id = vim.api.nvim_create_namespace("custom_hl")

local function highlight_todos()
  local parser = vim.treesitter.get_parser(0)
  local tree = parser:parse()[1]
  local root = tree:root()

  -- Query for comments
  local query = vim.treesitter.query.parse(parser:lang(), [[
    (comment) @comment
  ]])

  vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)

  for id, node in query:iter_captures(root, 0, 0, -1) do
    local text = vim.treesitter.get_node_text(node, 0)
    if text:match("TODO") or text:match("FIXME") or text:match("HACK") then
      local start_row, start_col, end_row, end_col = node:range()
      vim.api.nvim_buf_set_extmark(0, ns_id, start_row, start_col, {
        end_row = end_row,
        end_col = end_col,
        hl_group = "WarningMsg",
        priority = 150,
      })
    end
  end
end

-- Run on buffer enter and changes
vim.api.nvim_create_autocmd({"BufEnter", "TextChanged", "TextChangedI"}, {
  callback = highlight_todos,
})
```
***
# Title: Get treesitter parser for buffer
# Category: Treesitter
# Tags: treesitter, api, parser, buffer
---
Use `vim.treesitter.get_parser()` to access the treesitter parser and syntax tree for any buffer.

```lua
-- Get parser for current buffer
local parser = vim.treesitter.get_parser(0, "lua")

-- Parse and get syntax tree
local trees = parser:parse()
local tree = trees[1]
local root = tree:root()

-- Get language
print("Language:", parser:lang())

-- Get tree information
local start_row, start_col, end_row, end_col = root:range()
print(string.format("Tree spans lines %d to %d", start_row, end_row))

-- Parser for specific language (with fallback)
local ok, py_parser = pcall(vim.treesitter.get_parser, 0, "python")
if ok then
  print("Python parser available")
end
```
***
# Title: Handle treesitter injection languages
# Category: Treesitter
# Tags: treesitter, injection, embedded, languages
---
Work with embedded languages like Lua in Vimscript, SQL in strings, or markdown code blocks.

```lua
-- Get all parsers including injected languages
local parser = vim.treesitter.get_parser(0)

parser:for_each_tree(function(tree, language_tree)
  local lang = language_tree:lang()
  local root = tree:root()

  print("Found language:", lang)

  -- Process each language separately
  if lang == "lua" then
    -- Query Lua nodes
  elseif lang == "vim" then
    -- Query Vim nodes
  end
end)

-- Example: Find Lua code in Vim heredoc
local query = vim.treesitter.query.parse("vim", [[
  (let_statement
    (identifier)
    (heredoc
      (heredoc_body) @lua.code))
]])
```
***
# Title: Build a treesitter-based code outline
# Category: Treesitter
# Tags: treesitter, outline, navigation, structure
---
Create a code outline viewer using treesitter to extract document structure.

```lua
local function get_code_outline(bufnr)
  bufnr = bufnr or 0
  local parser = vim.treesitter.get_parser(bufnr)
  local tree = parser:parse()[1]
  local root = tree:root()
  local lang = parser:lang()

  -- Different queries for different languages
  local queries = {
    lua = [[
      (function_declaration name: (identifier) @name) @definition
      (assignment_statement
        (variable_list name: (identifier) @name)
        (expression_list value: (function_definition))) @definition
    ]],
    python = [[
      (function_definition name: (identifier) @name) @definition
      (class_definition name: (identifier) @name) @definition
    ]],
    javascript = [[
      (function_declaration name: (identifier) @name) @definition
      (class_declaration name: (identifier) @name) @definition
      (method_definition name: (property_identifier) @name) @definition
    ]],
  }

  local query_str = queries[lang]
  if not query_str then return {} end

  local query = vim.treesitter.query.parse(lang, query_str)
  local outline = {}

  for id, node in query:iter_captures(root, bufnr, 0, -1) do
    if query.captures[id] == "name" then
      local name = vim.treesitter.get_node_text(node, bufnr)
      local row = node:start()
      local parent = node:parent()
      local kind = parent and parent:type() or "unknown"

      table.insert(outline, {
        name = name,
        line = row + 1,
        kind = kind,
      })
    end
  end

  return outline
end

-- Display outline
local function show_outline()
  local outline = get_code_outline()
  local lines = {}

  for _, item in ipairs(outline) do
    table.insert(lines, string.format("%4d: %s (%s)",
      item.line, item.name, item.kind))
  end

  -- Show in floating window or quickfix
  vim.fn.setqflist({}, "r", {
    title = "Code Outline",
    lines = lines,
  })
  vim.cmd("copen")
end

vim.api.nvim_create_user_command("Outline", show_outline, {})
```
***
# Title: Check if treesitter is available for filetype
# Category: Treesitter
# Tags: treesitter, check, available, parser
---
Check if treesitter parser is installed and available for current buffer.

```lua
-- Check if parser exists for language
local function has_parser(lang)
  local ok = pcall(vim.treesitter.get_parser, 0, lang)
  return ok
end

-- Check current buffer
local function check_treesitter()
  local ft = vim.bo.filetype

  if has_parser(ft) then
    print("Treesitter available for " .. ft)

    -- Get parser info
    local parser = vim.treesitter.get_parser(0, ft)
    print("Language:", parser:lang())

    return true
  else
    print("No treesitter parser for " .. ft)
    print("Install with: :TSInstall " .. ft)

    return false
  end
end

vim.api.nvim_create_user_command("TSCheck", check_treesitter, {})
```
***
# Title: Treesitter query predicates and directives
# Category: Treesitter
# Tags: treesitter, queries, predicates, advanced
---
Use query predicates to add conditions to treesitter pattern matching.

```lua
-- Query with predicates
local query = vim.treesitter.query.parse("lua", [[
  ; Find function calls named "require"
  (function_call
    name: (identifier) @func
    (#eq? @func "require"))

  ; Find strings longer than 10 characters
  (string
    content: (string_content) @str
    (#lua-match? @str "^.{10,}$"))

  ; Match only in comments
  (comment) @comment
    (#match? @comment "TODO")
]])

-- Available predicates:
-- #eq? - exact match
-- #match? - Lua pattern match
-- #lua-match? - Lua string.match
-- #contains? - contains substring
-- #any-of? - matches any of given values

-- Example: Find long variable names
local long_var_query = vim.treesitter.query.parse("lua", [[
  (identifier) @var
    (#lua-match? @var "^.{15,}$")
]])

local parser = vim.treesitter.get_parser(0, "lua")
local tree = parser:parse()[1]
local root = tree:root()

for id, node in long_var_query:iter_captures(root, 0, 0, -1) do
  local name = vim.treesitter.get_node_text(node, 0)
  local row = node:start()
  print(string.format("Long variable '%s' at line %d", name, row + 1))
end
```
***
# Title: Use treesitter for smart text editing
# Category: Treesitter
# Tags: treesitter, editing, smart, refactoring
---
Leverage treesitter for intelligent code refactoring and editing operations.

```lua
-- Rename variable in current scope
local function rename_variable()
  local node = vim.treesitter.get_node()

  -- Find identifier under cursor
  while node and node:type() ~= "identifier" do
    node = node:parent()
  end

  if not node then
    print("Not on an identifier")
    return
  end

  local old_name = vim.treesitter.get_node_text(node, 0)

  -- Get new name from user
  local new_name = vim.fn.input("Rename to: ", old_name)
  if new_name == "" or new_name == old_name then return end

  -- Find scope (function or file)
  local scope = node
  while scope do
    if scope:type() == "function_declaration" or
       scope:type() == "function_definition" then
      break
    end
    scope = scope:parent()
  end

  if not scope then
    -- Use root as scope
    local parser = vim.treesitter.get_parser(0)
    scope = parser:parse()[1]:root()
  end

  -- Find all identifiers with same name in scope
  local query = vim.treesitter.query.parse("lua", [[
    (identifier) @id
  ]])

  local changes = {}
  for id, found_node in query:iter_captures(scope, 0) do
    if vim.treesitter.get_node_text(found_node, 0) == old_name then
      local start_row, start_col, end_row, end_col = found_node:range()
      table.insert(changes, {
        start_row = start_row,
        start_col = start_col,
        end_row = end_row,
        end_col = end_col,
      })
    end
  end

  -- Apply changes in reverse order to maintain positions
  table.sort(changes, function(a, b)
    return a.start_row > b.start_row or
           (a.start_row == b.start_row and a.start_col > b.start_col)
  end)

  for _, change in ipairs(changes) do
    vim.api.nvim_buf_set_text(0,
      change.start_row, change.start_col,
      change.end_row, change.end_col,
      {new_name})
  end

  print(string.format("Renamed %d occurrences", #changes))
end

vim.keymap.set("n", "<leader>rn", rename_variable,
  {desc = "Rename variable in scope"})
```
***
