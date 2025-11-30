# Title: System clipboard sync
# Category: Clipboard
# Tags: clipboard, system, sync
---
Use `vim.opt.clipboard="unnamedplus"` to sync yank/paste with system clipboard automatically.

```vim
:lua vim.opt.clipboard = "unnamedplus"
```
***
# Title: Set system clipboard from Lua
# Category: Clipboard
# Tags: clipboard, lua, register
---
Use `vim.fn.setreg("+", "text")` to set system clipboard content from Lua.

```vim
:lua vim.fn.setreg("+", "hello world")
```
***
# Title: System clipboard access with registers
# Category: Clipboard
# Tags: clipboard, system, copy, paste, register
---
Access system clipboard using `+` and `*` registers for seamless integration with other applications.

```vim
" Copy to system clipboard
"+y         " yank to + register (desktop clipboard)
"*y         " yank to * register (mouse selection)
gg"+yG      " copy entire buffer to system clipboard

" Paste from system clipboard
"+p         " paste from + register
"*p         " paste from * register
```
***
# Title: Mac OS clipboard sharing
# Category: Clipboard
# Tags: macos, clipboard, pbcopy, pbpaste
---
Integrate Vim with macOS clipboard using pbcopy and pbpaste utilities.

```vim
" Vimscript - macOS clipboard integration
vnoremap <C-c> :w !pbcopy<CR><CR>
nnoremap <C-v> :r !pbpaste<CR>

" Use system clipboard by default
set clipboard=unnamed
```

```lua
-- Lua - macOS clipboard integration
vim.keymap.set('v', '<C-c>', ':w !pbcopy<CR><CR>', { desc = 'Copy to macOS clipboard' })
vim.keymap.set('n', '<C-v>', ':r !pbpaste<CR>', { desc = 'Paste from macOS clipboard' })

-- Use system clipboard by default
vim.opt.clipboard = 'unnamed'
```
***
# Title: GNU/Linux clipboard with xclip
# Category: Clipboard
# Tags: linux, clipboard, xclip, copy, paste
---
Use xclip utility for clipboard integration on GNU/Linux systems.

```vim
" Vimscript - Copy/paste with xclip
vnoremap <C-c> :w !xclip -selection clipboard<CR><CR>
nnoremap <C-v> :r !xclip -selection clipboard -o<CR>

" Function-based approach
function! ClipboardYank()
  call system('xclip -i -selection clipboard', @@)
endfunction
```

```lua
-- Lua - Copy/paste with xclip
vim.keymap.set('v', '<C-c>', ':w !xclip -selection clipboard<CR><CR>', { desc = 'Copy to clipboard' })
vim.keymap.set('n', '<C-v>', ':r !xclip -selection clipboard -o<CR>', { desc = 'Paste from clipboard' })

-- Function-based approach
local function clipboard_yank()
  vim.fn.system('xclip -i -selection clipboard', vim.fn.getreg('@'))
end

-- Create a command to use it
vim.api.nvim_create_user_command('ClipboardYank', clipboard_yank, {})
```
***
# Title: System clipboard: handling yank and delete motions differently
# Category: Clipboard
# Tags: clipboard, copy, paste
---
Integrating system clipboard with Neovim is easy:

```lua
vim.o.clipboard="unnamedplus"
```

All yanked and deleted content will go to the default register and also to system clipboard. That's the most common setup.

But, suppose that you want yank and delete motions to behave slightly differently with respect to system clipboard. For example, you want all yanked text to go to the unnamed register and to system clipboard. But in case of delete motions, you don't want to affect system clipboard, only the default registry (quite popular setup). The setup is fairly easy. Just add the following lines to your `init.lua` configuration file:

```lua
-- Don't mention system clipboard,
-- it won't be affected wuthout the `TextYankPost` callback
vim.o.clipboard = ""

-- Copy yanked text to system clipboard.
-- This callback is involed after each yank/delete operation
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    -- Only trigger on yanks
    if vim.v.event.operator == "y" and vim.v.event.regname == "" then
      -- "+" stands for system clipboard
      vim.fn.setreg("+", vim.fn.getreg('"'))
      vim.fn.setreg("+", vim.fn.getreg('"', 1)) -- also yank visual selection
    end
  end,
})

```

Yanked text goes to system register AND clipboard. Deleted text goes to system register only and leaves system clipboard attached.
***
# Title: Preserve register when pasting over selection
# Category: Clipboard
# Tags: paste, register, yank, visual, black-hole
---
When pasting over a visual selection, the deleted text normally replaces the unnamed register. Use the black hole register to preserve your yanked content.

```lua
-- Paste without losing the yanked content
vim.keymap.set("x", "p", '"_dP', { desc = "Paste without yanking", noremap = true })

-- Alternative: use a specific register
vim.keymap.set("x", "<leader>p", '"0p', { desc = "Paste from yank register", noremap = true })
```

```vim
" In vimscript:
xnoremap p "_dP
" This deletes to black hole register (_) then pastes
```
***
