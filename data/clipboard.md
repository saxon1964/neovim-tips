# Title: System clipboard sync
# Category: Clipboard
# Tags: clipboard, system, sync
---
Use `vim.opt.clipboard="unnamedplus"` to sync yank/paste with system clipboard automatically.

#### Example

```vim
:lua vim.opt.clipboard = "unnamedplus"
```
***
# Title: Set system clipboard from Lua
# Category: Clipboard
# Tags: clipboard, lua, register
---
Use `vim.fn.setreg("+", "text")` to set system clipboard content from Lua.

#### Example

```vim
:lua vim.fn.setreg("+", "hello world")
```
***
# Title: System clipboard access with registers
# Category: Clipboard
# Tags: clipboard, system, copy, paste, register
---
Access system clipboard using `+` and `*` registers for seamless integration with other applications.

#### Example

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

#### Example

```vim
" macOS clipboard integration
vnoremap <C-c> :w !pbcopy<CR><CR>
nnoremap <C-v> :r !pbpaste<CR>

" Use system clipboard by default
set clipboard=unnamed
```
***
# Title: GNU/Linux clipboard with xclip
# Category: Clipboard
# Tags: linux, clipboard, xclip, copy, paste
---
Use xclip utility for clipboard integration on GNU/Linux systems.

#### Example

```vim
" Copy/paste with xclip
vnoremap <C-c> :w !xclip -selection clipboard<CR><CR>
nnoremap <C-v> :r !xclip -selection clipboard -o<CR>

" Function-based approach
function! ClipboardYank()
  call system('xclip -i -selection clipboard', @@)
endfunction
```
***
# Title: System clipboard: handling yank and delete motions differently
# Category: Clipboard
# Tags: clipboard, copy, paste
---
Suppose that you want yank and delete motions to behave differently with respect to system clipboard. For example, you want all yanked text to be copied to system clipboard as well to unnamed internal register. But in case of delete motions, you don't want to affect system clipboard. The setup is fairly easy. Just add the following lines to your `init.lua` configuration file

```lua
-- Avoid global clipboard hijacking
vim.opt.clipboard = {}
-- NOTE: Yank should copy to unnamed register AND system clipboard
-- Deleted text goes to unnamed register only without changing system clipboard
vim.keymap.set({ "n", "x" }, "y", '"+y', { desc = "Yank to clipboard", noremap = true })
vim.keymap.set("n", "yy", '"+yy', { desc = "Yank to clipboard", noremap = true })
```
***
