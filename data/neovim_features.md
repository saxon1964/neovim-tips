# Title: Multiple cursors simulation
# Category: Neovim Features
# Tags: cursor, multiple, editing
---
Use `cgn` after searching to change next match, then press `.` to repeat on subsequent matches.

#### Example

```vim
/word   " search for 'word'
cgn     " change next match
.       " repeat change on next match
```
===
# Title: Tree-sitter text objects
# Category: Neovim Features
# Tags: treesitter, textobject, modern
---
Use `vaf` to select around function, `vif` for inside function, `vac` for around class (requires treesitter text objects).

#### Example

```vim
vaf  " select around function
vif  " select inside function
vac  " select around class
```
===
# Title: Quick fix navigation
# Category: Neovim Features
# Tags: quickfix, navigation, errors
---
Use `:cn` to go to next error/item in quickfix list, `:cp` for previous, `:copen` to open quickfix window.

#### Example

```vim
:cn     " next quickfix item
:cp     " previous quickfix item
:copen  " open quickfix window
```
===
# Title: Built-in terminal
# Category: Neovim Features
# Tags: terminal, integrated, modern
---
Use `:term` to open terminal, `Ctrl+\` followed by `Ctrl+n` to exit terminal mode to normal mode.

#### Example

```vim
:term           " open terminal
Ctrl+\ Ctrl+n   " exit terminal mode
```
===
# Title: Window splitting shortcuts
# Category: Neovim Features
# Tags: window, split, navigation
---
Use `Ctrl+w s` for horizontal split, `Ctrl+w v` for vertical split, `Ctrl+w w` to cycle windows.

#### Example

```vim
Ctrl+w s  " horizontal split
Ctrl+w v  " vertical split
Ctrl+w w  " cycle windows
```
===
# Title: Lua configuration
# Category: Neovim Features
# Tags: lua, configuration, modern, scripting
---
Use Lua for configuration instead of Vimscript for better performance and modern syntax.

#### Example

```lua
-- ~/.config/nvim/init.lua
vim.opt.number = true
vim.opt.relativenumber = true
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
```
===
# Title: Built-in snippet support
# Category: Neovim Features
# Tags: snippets, completion, modern
---
Neovim 0.10+ has built-in snippet support for LSP and completion engines.

#### Example

```lua
-- Expand snippet
vim.snippet.expand("for i in range(${1:10}):\n\t${0}")

-- Jump to next placeholder
vim.snippet.jump(1)

-- Jump to previous placeholder
vim.snippet.jump(-1)
```
===
# Title: Floating windows API
# Category: Neovim Features
# Tags: floating, windows, api, modern
---
Create floating windows for custom UI elements using Neovim's floating window API.

#### Example

```lua
local buf = vim.api.nvim_create_buf(false, true)
local win = vim.api.nvim_open_win(buf, true, {
  relative = 'cursor',
  width = 50,
  height = 10,
  row = 1,
  col = 0,
  style = 'minimal',
  border = 'rounded'
})
```
===
# Title: Extended marks
# Category: Neovim Features
# Tags: marks, extmarks, api, highlighting
---
Use extmarks for advanced text annotations and virtual text that persists across edits.

#### Example

```lua
local ns = vim.api.nvim_create_namespace('my_namespace')
vim.api.nvim_buf_set_extmark(0, ns, 0, 0, {
  virt_text = {{'Virtual text', 'Comment'}},
  virt_text_pos = 'eol'
})
```
===
# Title: Diagnostic API
# Category: Neovim Features
# Tags: diagnostics, api, lsp, modern
---
Use Neovim's built-in diagnostic API for showing errors, warnings, and info messages.

#### Example

```lua
-- Set diagnostics
vim.diagnostic.set(ns_id, buf, {
  {
    lnum = 0,
    col = 0,
    message = "Error message",
    severity = vim.diagnostic.severity.ERROR
  }
})

-- Show diagnostics in floating window
vim.diagnostic.open_float()
```
===
# Title: Auto commands with Lua
# Category: Neovim Features
# Tags: autocmd, lua, events, modern
---
Create auto commands using Lua API for better organization and type safety.

#### Example

```lua
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.lua',
  callback = function()
    vim.lsp.buf.format()
  end,
  desc = 'Format Lua files on save'
})
```
===
# Title: User commands
# Category: Neovim Features
# Tags: commands, user, custom, lua
---
Create custom user commands with Lua for better functionality and completion.

#### Example

```lua
vim.api.nvim_create_user_command('Hello', function(opts)
  print('Hello ' .. (opts.args or 'World'))
end, {
  nargs = '?',
  desc = 'Say hello to someone'
})
```
===
# Title: Virtual text
# Category: Neovim Features
# Tags: virtual, text, inline, diagnostics
---
Display virtual text inline for diagnostics, git blame, or other contextual information.

#### Example

```lua
local ns = vim.api.nvim_create_namespace('virtual_text')
vim.api.nvim_buf_set_extmark(0, ns, 0, -1, {
  virt_text = {{'  → This is virtual text', 'Comment'}},
  virt_text_pos = 'eol'
})
```
===
# Title: Statusline and tabline API
# Category: Neovim Features
# Tags: statusline, tabline, ui, customization
---
Customize statusline and tabline using Lua functions for dynamic content.

#### Example

```lua
function _G.custom_statusline()
  return '%f %m %r%=%l,%c %p%%'
end

vim.opt.statusline = '%!v:lua.custom_statusline()'
```
===
# Title: RPC and job control
# Category: Neovim Features
# Tags: rpc, jobs, async, communication
---
Use Neovim's job control and RPC capabilities for asynchronous operations.

#### Example

```lua
local job_id = vim.fn.jobstart({'ls', '-la'}, {
  on_stdout = function(_, data)
    for _, line in ipairs(data) do
      if line ~= '' then
        print(line)
      end
    end
  end
})
```
===
# Title: Health checks
# Category: Neovim Features
# Tags: health, check, diagnostics, system
---
Use `:checkhealth` to diagnose Neovim installation and plugin issues.

#### Example

```vim
:checkhealth           " check all health
:checkhealth nvim      " check Neovim core
:checkhealth telescope " check specific plugin
```
===