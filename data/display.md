# Title: Toggle invisible characters
# Category: Display
# Tags: invisible, characters, toggle
---
Use `:set list!` to toggle display of invisible characters (tabs, spaces, etc.).

```vim
" Vimscript:
:set list!  " toggle invisible characters
```

```lua
-- Lua:
vim.opt.list = not vim.opt.list:get()  -- toggle invisible characters
```
***
# Title: Toggle cursor line highlight
# Category: Display
# Tags: cursorline, highlight, toggle
---
Use `:set cursorline!` to toggle highlighting of the current cursor line.

```vim
" Vimscript:
:set cursorline!  " toggle cursor line highlight
```

```lua
-- Lua:
vim.opt.cursorline = not vim.opt.cursorline:get()  -- toggle cursor line highlight
```
***
# Title: Ex commands - display and UI settings
# Category: Display
# Tags: ex, display, ui, show, list
---
Use `:set list` to show whitespace, `:set wrap` for line wrapping, `:set ruler` for cursor position, `:set showcmd` for command display.

```vim
" Vimscript:
:set list         " show whitespace characters
:set listchars=tab:>-,trail:·  " customize whitespace display
:set wrap         " enable line wrapping
:set nowrap       " disable line wrapping
:set ruler        " show cursor position
:set showcmd      " show partial commands
```

```lua
-- Lua:
vim.opt.list = true   -- show whitespace characters
vim.opt.listchars = { tab = '>-', trail = '·' }  -- customize whitespace display
vim.opt.wrap = true   -- enable line wrapping
vim.opt.wrap = false  -- disable line wrapping
vim.opt.ruler = true  -- show cursor position
vim.opt.showcmd = true  -- show partial commands
```
***
# Title: Ex commands - line numbers and columns
# Category: Display
# Tags: ex, line, number, column, relative
---
Use `:set number` for line numbers, `:set relativenumber` for relative numbers, `:set colorcolumn` for guide column.

```vim
" Vimscript:
:set number           " show line numbers
:set relativenumber   " show relative line numbers
:set number relativenumber  " show both
:set colorcolumn=80   " highlight column 80
:set textwidth=72     " set text width
```

```lua
-- Lua:
vim.opt.number = true  -- show line numbers
vim.opt.relativenumber = true  -- show relative line numbers
-- Both:
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = '80'  -- highlight column 80
vim.opt.textwidth = 72  -- set text width
```
***
# Title: Ex commands - scrolling and viewport
# Category: Display
# Tags: ex, scroll, viewport, offset, bind
---
Use `:set scrolloff` for scroll offset, `:set sidescrolloff` for horizontal offset, `:set scrollbind` to bind scrolling.

```vim
" Vimscript:
:set scrolloff=5      " keep 5 lines above/below cursor
:set sidescrolloff=8  " keep 8 columns left/right of cursor
:set scrollbind       " bind scrolling between windows
:set noscrollbind     " unbind scrolling
```

```lua
-- Lua:
vim.opt.scrolloff = 5  -- keep 5 lines above/below cursor
vim.opt.sidescrolloff = 8  -- keep 8 columns left/right of cursor
vim.opt.scrollbind = true  -- bind scrolling between windows
vim.opt.scrollbind = false  -- unbind scrolling
```
***
# Title: Ex commands - folding display
# Category: Display
# Tags: ex, fold, display, column, text
---
Use `:set foldcolumn` to show fold column, `:set foldtext` for custom fold text, `:set fillchars` for fill characters.

```vim
" Vimscript:
:set foldcolumn=4     " show fold indicators in 4-char column
:set fillchars=fold:.,vert:|  " customize fill characters
:set foldtext=MyFoldText()    " custom fold text function
```

```lua
-- Lua:
vim.opt.foldcolumn = '4'  -- show fold indicators in 4-char column
vim.opt.fillchars = { fold = '.', vert = '|' }  -- customize fill characters
vim.opt.foldtext = 'v:lua.MyFoldText()'  -- custom fold text function
```
***
# Title: Ex commands - status line and tabs
# Category: Display
# Tags: ex, status, line, tab, label
---
Use `:set laststatus` for status line, `:set showtabline` for tab line, `:set statusline` for custom status.

```vim
" Vimscript:
:set laststatus=2     " always show status line
:set showtabline=2    " always show tab line
:set statusline=%f\ %m%r%h%w\ [%Y]\ [%{&ff}]\ %=%l,%c\ %p%%
```

```lua
-- Lua:
vim.opt.laststatus = 2  -- always show status line
vim.opt.showtabline = 2  -- always show tab line
vim.opt.statusline = '%f %m%r%h%w [%Y] [%{&ff}] %=%l,%c %p%%'
```
***
# Title: Conceal text with syntax highlighting
# Category: Display
# Tags: conceal, hide, text, syntax, conceallevel
---
Use `:set conceallevel=2` to hide concealed text and `:syntax match` with `conceal` to define what to hide.

```vim
" Vimscript:
:set conceallevel=2       " hide concealed text completely
:set conceallevel=0       " show all text normally
:syntax match htmlTag '<[^>]*>' conceal  " hide HTML tags
" Toggle conceal on/off
nnoremap <leader>c :let &conceallevel = (&conceallevel == 2) ? 0 : 2<CR>
```

```lua
-- Lua:
vim.opt.conceallevel = 2  -- hide concealed text completely
vim.opt.conceallevel = 0  -- show all text normally
vim.cmd('syntax match htmlTag \'<[^>]*>\' conceal')  -- hide HTML tags

-- Toggle conceal on/off
vim.keymap.set('n', '<leader>c', function()
  vim.opt.conceallevel = vim.opt.conceallevel:get() == 2 and 0 or 2
end, { desc = 'Toggle conceal' })
```
***
