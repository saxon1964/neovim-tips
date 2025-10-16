# Title: Window navigation basics
# Category: Window Management
# Tags: window, navigation, movement
---
Use `Ctrl+w h/j/k/l` to move to left/down/up/right windows, `Ctrl+w w` to cycle through windows, `Ctrl+w p` for previous window.

```vim
Ctrl+w h  " move to left window
Ctrl+w j  " move to window below
Ctrl+w k  " move to window above
Ctrl+w l  " move to right window
Ctrl+w w  " cycle to next window
Ctrl+w p  " go to previous window
```
***
# Title: Window closing
# Category: Window Management
# Tags: window, close, quit
---
Use `Ctrl+w c` to close current window, `Ctrl+w o` to close all windows except current, `Ctrl+w q` to quit current window.

```vim
Ctrl+w c  " close current window
Ctrl+w o  " close all other windows
Ctrl+w q  " quit current window
```
***
# Title: Window position navigation
# Category: Window Management
# Tags: window, position, navigation
---
Use `Ctrl+w t` to go to top window and `Ctrl+w b` to go to bottom window.

```vim
Ctrl+w t  " go to top window
Ctrl+w b  " go to bottom window
```
***
# Title: Special window commands
# Category: Window Management
# Tags: window, special, file, tag
---
Use `Ctrl+w f` to split and open file under cursor, `Ctrl+w ]` to split and jump to tag, `Ctrl+w x` to exchange windows.

```vim
Ctrl+w f  " split and open file under cursor
Ctrl+w ]  " split and jump to tag
Ctrl+w x  " exchange current window with another
```
***
# Title: Move window to tab
# Category: Window Management
# Tags: window, tab, move
---
Use `Ctrl+w T` to move current window to a new tab page.

```vim
Ctrl+w T  " move current window to new tab
```
***
# Title: Advanced window operations
# Category: Window Management
# Tags: window, equalize, rotate, maximize, advanced
---
Use `Ctrl+w =` to equalize windows, `Ctrl+w r` to rotate windows, `Ctrl+w |` to maximize horizontally.

```vim
Ctrl+w =    " equalize window sizes
Ctrl+w r    " rotate windows clockwise
Ctrl+w R    " rotate windows counter-clockwise  
Ctrl+w |    " maximize current window horizontally
Ctrl+w _    " maximize current window vertically
```
***
# Title: Resize windows incrementally
# Category: Window Management
# Tags: window, resize, increment
---
Use `Ctrl+w +` to increase height, `Ctrl+w -` to decrease height, `Ctrl+w >` to increase width, `Ctrl+w <` to decrease width.

```vim
Ctrl+w +  " increase window height
Ctrl+w -  " decrease window height
Ctrl+w >  " increase window width
Ctrl+w <  " decrease window width
```
***
# Title: Move windows
# Category: Window Management
# Tags: window, move, position
---
Use `Ctrl+w H/J/K/L` to move current window to far left/bottom/top/right.

```vim
Ctrl+w H  " move window to far left
Ctrl+w J  " move window to bottom
Ctrl+w K  " move window to top  
Ctrl+w L  " move window to far right
```
***
# Title: Fast window resizing
# Category: Window Management
# Tags: resize, window, keys, mapping
---
Use mapped keys for fast window resizing without complex key combinations.

```vim
" Map + and - for easy window resizing
if bufwinnr(1)
  map + <C-W>+
  map - <C-W>-
endif
```
***
# Title: Better gm command
# Category: Window Management
# Tags: cursor, middle, navigation, movement
---
Improved gm command that moves cursor to the middle of the physical line, ignoring whitespace.

```vim
function! s:Gm()
  execute 'normal! ^'
  let first_col = virtcol('.')
  execute 'normal! g_'
  let last_col  = virtcol('.')
  execute 'normal! ' . (first_col + last_col) / 2 . '|'
endfunction
nnoremap <silent> gm :call <SID>Gm()<CR>
onoremap <silent> gm :call <SID>Gm()<CR>
```
***
# Title: Keep cursor centered
# Category: Window Management
# Tags: cursor, center, scroll, display
---
Keep cursor centered vertically on screen for better visibility while editing.

```vim
" Keep cursor centered when scrolling
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzz
nnoremap N Nzz

" Or automatic centering
set scrolloff=999
```
***
# Title: Change cursor shape in modes
# Category: Window Management
# Tags: cursor, shape, mode, visual
---
Configure different cursor shapes for different modes to provide visual feedback.

```vim
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
" Block in normal, vertical bar in insert, horizontal in replace
```
***
# Title: Keep window when closing buffer
# Category: Window Management
# Tags: buffer, close, window, preserve
---
Use `:bp|bd #` to close buffer without closing the window layout.

```vim
:bp|bd #        " go to previous buffer, delete current
:enew|bd #      " create new buffer, delete previous
```
***
# Title: Window splitting strategies
# Category: Window Management
# Tags: split, window, layout, organize
---
Create and organize window splits for efficient multi-file editing.

```vim
:split          " horizontal split
:vsplit         " vertical split
:new            " new horizontal split with empty buffer
:vnew           " new vertical split with empty buffer
:sp filename    " split and open specific file
:vsp filename   " vertical split and open specific file
```
***
# Title: Tab management
# Category: Window Management
# Tags: tabs, navigation, workspace, organize
---
Use tabs as workspaces to organize different projects or contexts.

```vim
:tabnew         " create new tab
:tabclose       " close current tab
:tabonly        " close all other tabs
:tabn           " next tab
:tabp           " previous tab
gt              " next tab (normal mode)
gT              " previous tab (normal mode)
:tab split      " open current buffer in new tab
```
***
# Title: Window navigation without prefix
# Category: Window Management
# Tags: navigation, window, mapping, efficient
---
Map window navigation to single keys for faster movement between splits.

```vim
" Map Alt+hjkl for window navigation
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Or use leader key combinations
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
```
***
# Title: Focus mode for writing
# Category: Window Management
# Tags: focus, writing, distraction, zen
---
Create a distraction-free environment for writing and focused editing.

```vim
" Simple focus mode
:set laststatus=0     " hide statusline
:set nonumber         " hide line numbers
:set norelativenumber " hide relative numbers
:set signcolumn=no    " hide sign column

" Toggle function
function! ToggleFocusMode()
  if &laststatus == 2
    set laststatus=0 nonumber norelativenumber signcolumn=no
  else
    set laststatus=2 number relativenumber signcolumn=yes
  endif
endfunction
nnoremap <F12> :call ToggleFocusMode()<CR>
```
***
# Title: Diff mode for file comparison
# Category: Window Management
# Tags: diff, compare, vimdiff, merge
---
Use Vim's diff mode to compare and merge files effectively.

```vim
:vimdiff file1 file2    " start vimdiff from command line
:diffthis               " make current window part of diff
:diffoff                " turn off diff mode
]c                      " next difference
[c                      " previous difference
do                      " diff obtain (get change from other)
dp                      " diff put (put change to other)
:diffget                " get changes from other buffer
:diffput                " put changes to other buffer
```
***
# Title: Quick file explorer
# Category: Window Management
# Tags: explorer, netrw, files, browse
---
Use built-in file explorer (netrw) for quick file navigation and management.

```vim
:Explore            " open file explorer in current window
:Sexplore           " open file explorer in horizontal split
:Vexplore           " open file explorer in vertical split
:Texplore           " open file explorer in new tab
:e.                 " edit current directory

" In netrw:
" <Enter> - open file/directory
" - - go up one directory
" D - delete file
" R - rename file
" % - create new file
```
***
# Title: Close all other windows
# Category: Window Management
# Tags: window, close, only, single
---
Use `:only` or `:on` to close all windows except the current one, making it take up the full screen.

```vim
:only   " close all other windows (keep current)
:on     " short form of :only
Ctrl+w o " normal mode shortcut for :only
```
***
# Title: Window commands from Ex mode
# Category: Window Management
# Tags: wincmd, window, command, ex, mode
---
Use `:wincmd {key}` to execute window commands from Ex mode, useful in scripts and mappings.

```vim
:wincmd j     " same as Ctrl+w j (move to window below)
:wincmd =     " same as Ctrl+w = (equalize windows)
:wincmd o     " same as Ctrl+w o (close other windows)
:wincmd v     " same as Ctrl+w v (vertical split)
:wincmd s     " same as Ctrl+w s (horizontal split)
```
***