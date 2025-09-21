# Title: Create floating windows with Neovim API
# Category: Advanced Neovim
# Tags: floating, window, api, modern, popup
---
Use `vim.api.nvim_open_win()` to create floating windows programmatically for custom interfaces and popups.

#### Example

```lua
-- Create a floating window
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

-- Add content
vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
  'Hello from floating window!',
  'Press q to close'
})

-- Close on q
vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf })
```
***
# Title: Custom user commands with completion
# Category: Advanced Neovim
# Tags: command, completion, api, custom, user
---
Use `vim.api.nvim_create_user_command()` to create custom commands with intelligent completion and argument handling.

#### Example

```lua
-- Command with file completion
vim.api.nvim_create_user_command('EditConfig', function(opts)
  vim.cmd('edit ' .. vim.fn.stdpath('config') .. '/' .. opts.args)
end, {
  nargs = 1,
  complete = 'file',
  desc = 'Edit config file'
})

-- Command with custom completion
vim.api.nvim_create_user_command('LogLevel', function(opts)
  vim.log.level = vim.log.levels[opts.args:upper()]
end, {
  nargs = 1,
  complete = function() return {'debug', 'info', 'warn', 'error'} end
})

-- Usage: :EditConfig init.lua  or  :LogLevel debug
```
***
# Title: Buffer-local configurations and mappings
# Category: Configuration
# Tags: buffer, local, mapping, option, scope
---
Use `vim.opt_local` and buffer-specific keymaps to create settings that only apply to specific buffers.

#### Example

```lua
-- Buffer-local options (reset when switching buffers)
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

-- Buffer-local keymaps (only work in this buffer)
vim.keymap.set('n', '<leader>r', ':!node %<CR>', {
  buffer = 0,
  desc = 'Run current JS file'
})

-- Autocommand for filetype-specific buffer settings
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.opt_local.textwidth = 79
    vim.keymap.set('n', '<F5>', ':!python %<CR>', { buffer = true })
  end
})
```
***
# Title: Advanced autocommand patterns and groups
# Category: Autocommands
# Tags: autocmd, pattern, group, multiple, events
---
Use advanced patterns and groups with `vim.api.nvim_create_autocmd()` for sophisticated event handling.

#### Example

```lua
-- Create autocommand group for organization
local group = vim.api.nvim_create_augroup('MyCustomGroup', { clear = true })

-- Multiple events and patterns
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  group = group,
  pattern = {'*.md', '*.txt', '*.rst'},
  callback = function(event)
    vim.opt_local.spell = true
    vim.opt_local.wrap = true
    print('Text file opened: ' .. event.file)
  end
})

-- Conditional logic in callback
vim.api.nvim_create_autocmd('BufWritePre', {
  group = group,
  pattern = '*',
  callback = function()
    -- Only format if LSP client is attached
    if next(vim.lsp.get_active_clients({bufnr = 0})) then
      vim.lsp.buf.format({ timeout_ms = 2000 })
    end
  end
})
```
***
# Title: Custom diagnostic configuration
# Category: Diagnostics
# Tags: diagnostic, lsp, configuration, signs, virtual
---
Use `vim.diagnostic.config()` to customize how diagnostics are displayed and behave.

#### Example

```lua
-- Configure diagnostic display
vim.diagnostic.config({
  virtual_text = {
    prefix = '*',
    spacing = 2,
    severity = { min = vim.diagnostic.severity.WARN }
  },
  signs = {
    severity = { min = vim.diagnostic.severity.INFO }
  },
  underline = {
    severity = { min = vim.diagnostic.severity.ERROR }
  },
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
  update_in_insert = false,
  severity_sort = true,
})

-- Custom diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
```
***