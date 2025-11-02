# Title: Health diagnostics
# Category: Diagnostics
# Tags: health, check, diagnostics
---
Use `:checkhealth` to run health diagnostics for your Neovim setup.

```vim
:checkhealth  " run health diagnostics
```
***
# Title: View messages
# Category: Diagnostics
# Tags: messages, log, history
---
Use `:messages` to view past messages and notifications.

```vim
:messages  " view past messages
```
***
# Title: Find mapping source
# Category: Diagnostics
# Tags: mapping, verbose, source
---
Use `:verbose map <key>` to see where a specific mapping was defined.

```vim
:verbose map <leader>f  " see where <leader>f was mapped
```
***
# Title: Find option source
# Category: Diagnostics
# Tags: option, verbose, source
---
Use `:verbose set option?` to see where a specific option was last set.

```vim
:verbose set number?  " see where 'number' option was set
```
***
# Title: Configure diagnostic display with virtual text
# Category: Diagnostics
# Tags: lsp, diagnostic, virtual-text, configuration, display
---
Configure how LSP diagnostics are displayed using virtual text, virtual lines, or floating windows.

```lua
-- In init.lua, configure diagnostic display:
vim.diagnostic.config({
  virtual_text = {
    prefix = '●',  -- Could be '■', '▎', etc.
    source = "if_many",  -- Show source if multiple sources
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

-- Disable virtual text, use virtual lines instead:
vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = { only_current_line = true }
})

-- Toggle diagnostics on/off:
vim.keymap.set('n', '<leader>dt', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = 'Toggle diagnostics' })
```
***