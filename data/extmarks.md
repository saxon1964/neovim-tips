# Title: Create basic extmark
# Category: Extmarks
# Tags: extmarks, api, decoration, namespace
---
Use `vim.api.nvim_buf_set_extmark()` to place an extmark in a buffer. Extmarks are positions that move with text edits and can have decorations.

```lua
-- Create a namespace (do this once, usually at plugin setup)
local ns_id = vim.api.nvim_create_namespace('my_plugin')

-- Place an extmark at line 0 (1st line), column 0
local mark_id = vim.api.nvim_buf_set_extmark(0, ns_id, 0, 0, {
  -- Empty options means just a position marker
})

-- Get extmark position later
local pos = vim.api.nvim_buf_get_extmark_by_id(0, ns_id, mark_id, {})
print("Extmark is at line:", pos[1], "col:", pos[2])
```
***
# Title: Add virtual text with extmarks
# Category: Extmarks
# Tags: extmarks, virtual-text, inline-hints
---
Use extmarks with `virt_text` to display text that isn't actually in the buffer. Perfect for inline hints, diagnostics, or annotations.

```lua
local ns_id = vim.api.nvim_create_namespace('hints')

-- Add virtual text at end of line
vim.api.nvim_buf_set_extmark(0, ns_id, 5, 0, {
  virt_text = {{"← This is a hint", "Comment"}},
  virt_text_pos = "eol",  -- end of line
})

-- Add virtual text inline (after specific column)
vim.api.nvim_buf_set_extmark(0, ns_id, 10, 15, {
  virt_text = {{"[TODO]", "WarningMsg"}},
  virt_text_pos = "inline",
})

-- Add virtual text as overlay (replaces text visually)
vim.api.nvim_buf_set_extmark(0, ns_id, 3, 0, {
  end_col = 6,  -- covers first 6 characters
  virt_text = {{"FIXME", "ErrorMsg"}},
  virt_text_pos = "overlay",
})
```
***
# Title: Hide text with extmark conceal
# Category: Extmarks
# Tags: extmarks, conceal, hide, text
---
Use extmarks with `conceal` to visually hide text without removing it from the buffer. Useful for hiding verbose syntax or formatting markers.

```lua
local ns_id = vim.api.nvim_create_namespace('conceal')

-- Hide the word "function" on line 5, starting at column 0
vim.api.nvim_buf_set_extmark(0, ns_id, 5, 0, {
  end_col = 8,  -- length of "function"
  conceal = "",  -- hide completely (empty string)
})

-- Replace "function" with "fn" visually
vim.api.nvim_buf_set_extmark(0, ns_id, 10, 0, {
  end_col = 8,
  conceal = "fn",  -- show "fn" instead
})

-- Note: Make sure conceallevel is set
vim.opt.conceallevel = 2
```
***
# Title: Replace keywords visually with extmarks
# Category: Extmarks
# Tags: extmarks, conceal, replace, keywords
---
Use extmarks with `conceal` and `virt_text_pos = "inline"` to visually replace text like "return" with "ret" without changing the buffer. Using `overlay` alone will overlay on top rather than replace.

```lua
local ns_id = vim.api.nvim_create_namespace('abbreviations')

-- Enable concealing (required for conceal to work)
vim.opt.conceallevel = 2

-- Find all "return" keywords and replace visually with "ret"
local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
for lnum, line in ipairs(lines) do
  local col = 0
  while true do
    local start, finish = string.find(line, "return", col, true)
    if not start then break end

    vim.api.nvim_buf_set_extmark(0, ns_id, lnum - 1, start - 1, {
      end_col = finish,
      conceal = "",  -- Hide the original text
      virt_text = {{"ret", "Keyword"}},
      virt_text_pos = "inline",  -- Insert replacement text
    })
    col = finish + 1
  end
end
```
***
# Title: Highlight text ranges with extmarks
# Category: Extmarks
# Tags: extmarks, highlight, ranges, decoration
---
Use extmarks with `hl_group` to highlight specific text ranges. More powerful than matchadd() and survives buffer edits.

```lua
local ns_id = vim.api.nvim_create_namespace('highlights')

-- Highlight a word (line 5, columns 10-15)
vim.api.nvim_buf_set_extmark(0, ns_id, 5, 10, {
  end_col = 15,
  hl_group = "Search",
})

-- Highlight entire line
vim.api.nvim_buf_set_extmark(0, ns_id, 10, 0, {
  end_line = 10,
  end_col = 0,
  hl_group = "DiffAdd",
  hl_eol = true,  -- highlight to end of line
})

-- Highlight with priority (higher = more visible)
vim.api.nvim_buf_set_extmark(0, ns_id, 3, 0, {
  end_col = 5,
  hl_group = "ErrorMsg",
  priority = 200,  -- default is 4096
})
```
***
# Title: Create virtual lines with extmarks
# Category: Extmarks
# Tags: extmarks, virtual-lines, inline-diagnostics
---
Use `virt_lines` to add entire virtual lines above or below a line without modifying the buffer. Perfect for diagnostics or documentation.

```lua
local ns_id = vim.api.nvim_create_namespace('virtual_lines')

-- Add a virtual line below line 10
vim.api.nvim_buf_set_extmark(0, ns_id, 10, 0, {
  virt_lines = {
    {{"⚠ Warning: This function is deprecated", "WarningMsg"}},
    {{"  Use new_function() instead", "Comment"}},
  },
  virt_lines_above = false,  -- below the line (default)
})

-- Add virtual line above line 5
vim.api.nvim_buf_set_extmark(0, ns_id, 5, 0, {
  virt_lines = {
    {{"━━━━━━━━━━━━━━━━━━━━━━━━━━", "Comment"}},
    {{"Section: Helper Functions", "Title"}},
  },
  virt_lines_above = true,
})
```
***
# Title: Clear extmarks from buffer
# Category: Extmarks
# Tags: extmarks, clear, cleanup, namespace
---
Use `nvim_buf_clear_namespace()` to remove extmarks. Essential for cleanup and refreshing decorations.

```lua
local ns_id = vim.api.nvim_create_namespace('my_marks')

-- Clear all extmarks in namespace from current buffer
vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)

-- Clear extmarks only in line range (lines 10-20)
vim.api.nvim_buf_clear_namespace(0, ns_id, 10, 20)

-- Clear specific extmark by id
vim.api.nvim_buf_del_extmark(0, ns_id, mark_id)
```
***
# Title: Get all extmarks in range
# Category: Extmarks
# Tags: extmarks, query, list, range
---
Use `nvim_buf_get_extmarks()` to query extmarks in a buffer. Useful for finding and updating existing decorations.

```lua
local ns_id = vim.api.nvim_create_namespace('my_marks')

-- Get all extmarks in namespace
local marks = vim.api.nvim_buf_get_extmarks(0, ns_id, 0, -1, {})

for _, mark in ipairs(marks) do
  local mark_id, row, col = mark[1], mark[2], mark[3]
  print(string.format("Mark %d at line %d, col %d", mark_id, row, col))
end

-- Get extmarks with details
local marks_detailed = vim.api.nvim_buf_get_extmarks(0, ns_id, 0, -1, {
  details = true,
})

-- Get extmarks in specific range (lines 10-20)
local range_marks = vim.api.nvim_buf_get_extmarks(0, ns_id, {10, 0}, {20, -1}, {})
```
***
# Title: Add sign column signs with extmarks
# Category: Extmarks
# Tags: extmarks, signs, sign-column, gutter
---
Use extmarks with `sign_text` to place signs in the sign column. More flexible than traditional signs.

```lua
local ns_id = vim.api.nvim_create_namespace('my_signs')

-- Add a sign to line 10
vim.api.nvim_buf_set_extmark(0, ns_id, 10, 0, {
  sign_text = "⚠",
  sign_hl_group = "WarningMsg",
})

-- Add sign with number column highlight
vim.api.nvim_buf_set_extmark(0, ns_id, 5, 0, {
  sign_text = "✓",
  sign_hl_group = "DiffAdd",
  number_hl_group = "DiffAdd",  -- highlight line number too
  line_hl_group = "DiffAdd",     -- highlight entire line
})
```
***
# Title: Create inline diagnostics with extmarks
# Category: Extmarks
# Tags: extmarks, diagnostics, lsp, inline
---
Combine extmarks features to create rich inline diagnostics like modern IDEs.

```lua
local ns_id = vim.api.nvim_create_namespace('diagnostics')

-- Underline error and show virtual text
local function show_diagnostic(line, col, end_col, message, severity)
  local hl_group = severity == "error" and "DiagnosticUnderlineError"
                   or "DiagnosticUnderlineWarn"
  local virt_hl = severity == "error" and "DiagnosticVirtualTextError"
                  or "DiagnosticVirtualTextWarn"
  local sign = severity == "error" and "✗" or "⚠"

  vim.api.nvim_buf_set_extmark(0, ns_id, line, col, {
    end_col = end_col,
    hl_group = hl_group,
    virt_text = {{" " .. sign .. " " .. message, virt_hl}},
    virt_text_pos = "eol",
    sign_text = sign,
    sign_hl_group = virt_hl,
  })
end

-- Usage
show_diagnostic(10, 5, 15, "Undefined variable", "error")
show_diagnostic(15, 0, 10, "Unused import", "warn")
```
***
# Title: Make extmarks persistent across edits
# Category: Extmarks
# Tags: extmarks, persistent, tracking, right-gravity
---
Use extmark options to control how they behave during text edits. Essential for maintaining decorations.

```lua
local ns_id = vim.api.nvim_create_namespace('persistent')

-- Extmark stays at start of edit (left gravity - default)
vim.api.nvim_buf_set_extmark(0, ns_id, 10, 5, {
  right_gravity = false,  -- default
})

-- Extmark moves to end of inserted text (right gravity)
vim.api.nvim_buf_set_extmark(0, ns_id, 10, 5, {
  right_gravity = true,
})

-- Extmark spans a range and updates with edits
vim.api.nvim_buf_set_extmark(0, ns_id, 10, 5, {
  end_row = 10,
  end_col = 20,
  -- Range automatically adjusts as text is edited
})

-- Disable automatic updates (static position)
vim.api.nvim_buf_set_extmark(0, ns_id, 10, 5, {
  invalidate = true,  -- mark becomes invalid on edit
})
```
***
# Title: Create line number decorations with extmarks
# Category: Extmarks
# Tags: extmarks, line-numbers, number-column
---
Use extmarks to customize line number appearance for specific lines.

```lua
local ns_id = vim.api.nvim_create_namespace('line_numbers')

-- Highlight line number for important lines
vim.api.nvim_buf_set_extmark(0, ns_id, 10, 0, {
  number_hl_group = "ErrorMsg",  -- red line number
  line_hl_group = "CursorLine",  -- subtle line highlight
})

-- Combine with sign for visual emphasis
vim.api.nvim_buf_set_extmark(0, ns_id, 15, 0, {
  sign_text = "►",
  sign_hl_group = "Search",
  number_hl_group = "Search",
  line_hl_group = "Visual",
})
```
***
# Title: Build a simple word abbreviation system
# Category: Extmarks
# Tags: extmarks, abbreviations, conceal, practical
---
Create a complete system to visually abbreviate long keywords using extmarks with conceal and inline virtual text.

```lua
-- Abbreviation system
local M = {}
local ns_id = vim.api.nvim_create_namespace('abbreviations')

local abbreviations = {
  ["function"] = "fn",
  ["return"] = "ret",
  ["require"] = "req",
  ["local"] = "lcl",
}

function M.apply_abbreviations(bufnr)
  bufnr = bufnr or 0

  -- Enable concealing (required)
  vim.opt.conceallevel = 2

  -- Clear old abbreviations
  vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for lnum, line in ipairs(lines) do
    for word, abbrev in pairs(abbreviations) do
      local col = 0
      while true do
        local start, finish = string.find(line, word, col, true)
        if not start then break end

        -- Check if it's a whole word (not part of another word)
        local before = start > 1 and line:sub(start - 1, start - 1) or " "
        local after = finish < #line and line:sub(finish + 1, finish + 1) or " "

        if before:match("[%W_]") and after:match("[%W_]") then
          vim.api.nvim_buf_set_extmark(bufnr, ns_id, lnum - 1, start - 1, {
            end_col = finish,
            conceal = "",  -- Hide original text
            virt_text = {{abbrev, "Keyword"}},
            virt_text_pos = "inline",  -- Insert replacement
          })
        end

        col = finish + 1
      end
    end
  end
end

function M.toggle()
  local bufnr = vim.api.nvim_get_current_buf()
  local marks = vim.api.nvim_buf_get_extmarks(bufnr, ns_id, 0, -1, {})

  if #marks > 0 then
    -- Remove abbreviations
    vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
    print("Abbreviations disabled")
  else
    -- Apply abbreviations
    M.apply_abbreviations(bufnr)
    print("Abbreviations enabled")
  end
end

-- Setup
vim.api.nvim_create_user_command('ToggleAbbrev', M.toggle, {})

-- Auto-apply on buffer changes (optional)
vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI"}, {
  callback = function()
    M.apply_abbreviations()
  end,
})

return M
```
***
# Title: Create custom highlighting with extmark priorities
# Category: Extmarks
# Tags: extmarks, priorities, highlight, layering
---
Use extmark priorities to control which highlights are visible when they overlap.

```lua
local ns_id = vim.api.nvim_create_namespace('highlights')

-- Low priority background highlight
vim.api.nvim_buf_set_extmark(0, ns_id, 10, 0, {
  end_col = 50,
  hl_group = "CursorLine",
  priority = 100,
})

-- Medium priority for syntax
vim.api.nvim_buf_set_extmark(0, ns_id, 10, 10, {
  end_col = 20,
  hl_group = "String",
  priority = 150,
})

-- High priority for errors (will show on top)
vim.api.nvim_buf_set_extmark(0, ns_id, 10, 15, {
  end_col = 18,
  hl_group = "ErrorMsg",
  priority = 200,
})

-- Note: Default priority is 4096
-- Treesitter uses priority 100
-- LSP semantic tokens use priority 125
```
***
# Title: Monitor extmark changes with events
# Category: Extmarks
# Tags: extmarks, events, autocmd, tracking
---
Use the `nvim_buf_attach` API to watch for extmark changes in real-time.

```lua
local ns_id = vim.api.nvim_create_namespace('watched')

-- Attach to buffer to watch changes
vim.api.nvim_buf_attach(0, false, {
  on_lines = function(_, bufnr, _, first_line, last_line_old, last_line_new)
    print(string.format(
      "Lines changed: %d to %d (was %d lines, now %d)",
      first_line, last_line_new,
      last_line_old - first_line,
      last_line_new - first_line
    ))

    -- Refresh extmarks in changed range
    -- ... update logic here

    return false  -- don't detach
  end,

  on_detach = function()
    print("Buffer detached")
  end,
})
```
***
