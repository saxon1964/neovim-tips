# Title: Toggle fold
# Category: Folding
# Tags: fold, toggle, code
---
Use `za` to toggle fold under cursor open/closed.

```vim
za  " toggle fold under cursor
```
***
# Title: Open and close all folds
# Category: Folding
# Tags: fold, all, global
---
Use `zR` to open all folds in buffer and `zM` to close all folds in buffer.

```vim
zR  " open all folds
zM  " close all folds
```
***
# Title: Create fold from selection
# Category: Folding
# Tags: fold, create, selection
---
Use `zf` to create a fold from visual selection or with motion (e.g., `zf5j` to fold 5 lines down).

```vim
zf5j  " create fold 5 lines down
zf    " create fold from visual selection
```
***
# Title: Fold levels
# Category: Folding
# Tags: fold, level, depth
---
Use `zm` to increase fold level (close more folds) and `zr` to reduce fold level (open more folds).

```vim
zm  " increase fold level
zr  " reduce fold level
```
***
# Title: Fold by indentation
# Category: Folding
# Tags: fold, indent, automatic, method
---
Automatically fold code based on indentation levels using foldmethod=indent.

```vim
" Vimscript:
set foldmethod=indent   " fold based on indentation
set foldlevelstart=1    " start with some folds open
set foldnestmax=3       " limit nested fold depth
```

```lua
-- Lua:
vim.opt.foldmethod = 'indent'  -- fold based on indentation
vim.opt.foldlevelstart = 1     -- start with some folds open
vim.opt.foldnestmax = 3        -- limit nested fold depth
```
***
# Title: Syntax-based folding
# Category: Folding
# Tags: fold, syntax, automatic, language
---
Use syntax-aware folding for programming languages that support fold markers in syntax files.

```vim
" Vimscript:
set foldmethod=syntax   " fold based on file syntax
set foldlevel=2         " set initial fold level
```

```lua
-- Lua:
vim.opt.foldmethod = 'syntax'  -- fold based on file syntax
vim.opt.foldlevel = 2          -- set initial fold level
```
***
# Title: Keep folds when inserting
# Category: Folding
# Tags: fold, insert, preserve, maintain
---
Configure Vim to maintain fold state when entering insert mode.

```vim
" Vimscript:
" Prevent folds from opening when inserting
set foldopen-=insert

" Mapping to toggle fold with F9
nnoremap <F9> za
vnoremap <F9> zf
```

```lua
-- Lua:
-- Prevent folds from opening when inserting
vim.opt.foldopen:remove('insert')

-- Mapping to toggle fold with F9
vim.keymap.set('n', '<F9>', 'za', { desc = 'Toggle fold' })
vim.keymap.set('v', '<F9>', 'zf', { desc = 'Create fold from selection' })
```
***
# Title: Z-commands - create folds
# Category: Folding
# Tags: fold, create, lines
---
Use `zF` to create fold for N lines or `zf{motion}` to create fold with motion.

```vim
5zF   " create fold for 5 lines
zf3j  " create fold from cursor down 3 lines
zfip  " create fold for inner paragraph
```
***