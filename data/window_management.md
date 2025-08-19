# Title: Equalize window sizes
# Category: Window Management
# Tags: window, resize, equalize
---
Use `Ctrl+w =` to make all windows equal in size.

#### Example

```vim
Ctrl+w =  " equalize window sizes
```
===
# Title: Maximize window dimensions
# Category: Window Management
# Tags: window, maximize, resize
---
Use `Ctrl+w _` to maximize current window height and `Ctrl+w |` to maximize current window width.

#### Example

```vim
Ctrl+w _  " maximize window height
Ctrl+w |  " maximize window width
```
===
# Title: Resize windows incrementally
# Category: Window Management
# Tags: window, resize, increment
---
Use `Ctrl+w +` to increase height, `Ctrl+w -` to decrease height, `Ctrl+w >` to increase width, `Ctrl+w <` to decrease width.

#### Example

```vim
Ctrl+w +  " increase window height
Ctrl+w -  " decrease window height
Ctrl+w >  " increase window width
Ctrl+w <  " decrease window width
```
===
# Title: Rotate windows
# Category: Window Management
# Tags: window, rotate, move
---
Use `Ctrl+w r` to rotate windows clockwise and `Ctrl+w R` to rotate windows counter-clockwise.

#### Example

```vim
Ctrl+w r  " rotate windows clockwise
Ctrl+w R  " rotate windows counter-clockwise
```
===
# Title: Move windows
# Category: Window Management
# Tags: window, move, position
---
Use `Ctrl+w H/J/K/L` to move current window to far left/bottom/top/right.

#### Example

```vim
Ctrl+w H  " move window to far left
Ctrl+w J  " move window to bottom
Ctrl+w K  " move window to top  
Ctrl+w L  " move window to far right
```
===
# Title: Fast window resizing
# Category: Window Management
# Tags: resize, window, keys, mapping
---
Use mapped keys for fast window resizing without complex key combinations.

#### Example

```vim
" Map + and - for easy window resizing
if bufwinnr(1)
  map + <C-W>+
  map - <C-W>-
endif
```
===
# Title: Better gm command
# Category: Window Management
# Tags: cursor, middle, navigation, movement
---
Improved gm command that moves cursor to the middle of the physical line, ignoring whitespace.

#### Example

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
===
# Title: Open file under cursor
# Category: Window Management
# Tags: file, open, cursor, gf
---
Open files referenced under cursor in different ways (current window, new tab, new split).

#### Example

```vim
gf          " open file under cursor in current window
<C-w>f      " open file under cursor in new horizontal split
<C-w>gf     " open file under cursor in new tab
<C-w>vgf    " open file under cursor in new vertical split
```
===
# Title: Keep cursor centered
# Category: Window Management
# Tags: cursor, center, scroll, display
---
Keep cursor centered vertically on screen for better visibility while editing.

#### Example

```vim
" Keep cursor centered when scrolling
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzz
nnoremap N Nzz

" Or automatic centering
set scrolloff=999
```
===
# Title: Change cursor shape in modes
# Category: Window Management
# Tags: cursor, shape, mode, visual
---
Configure different cursor shapes for different modes to provide visual feedback.

#### Example

```vim
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
" Block in normal, vertical bar in insert, horizontal in replace
```
===
# Title: Keep window when closing buffer
# Category: Window Management
# Tags: buffer, close, window, preserve
---
Use `:bp|bd #` to close buffer without closing the window layout.

#### Example

```vim
:bp|bd #        " go to previous buffer, delete current
:enew|bd #      " create new buffer, delete previous
```
===
# Title: Buffer navigation shortcuts
# Category: Window Management
# Tags: buffer, navigation, switch, cycle
---
Navigate between buffers efficiently using built-in commands and mappings.

#### Example

```vim
:bn             " next buffer
:bp             " previous buffer
:b#             " alternate buffer (last visited)
:b5             " go to buffer 5
:b name<Tab>    " go to buffer by name (with completion)
Ctrl+^          " toggle between current and alternate buffer
```
===
# Title: Window splitting strategies
# Category: Window Management
# Tags: split, window, layout, organize
---
Create and organize window splits for efficient multi-file editing.

#### Example

```vim
:split          " horizontal split
:vsplit         " vertical split
:new            " new horizontal split with empty buffer
:vnew           " new vertical split with empty buffer
:sp filename    " split and open specific file
:vsp filename   " vertical split and open specific file
```
===
# Title: Tab management
# Category: Window Management
# Tags: tabs, navigation, workspace, organize
---
Use tabs as workspaces to organize different projects or contexts.

#### Example

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
===
# Title: Window navigation without prefix
# Category: Window Management
# Tags: navigation, window, mapping, efficient
---
Map window navigation to single keys for faster movement between splits.

#### Example

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
===
# Title: Focus mode for writing
# Category: Window Management
# Tags: focus, writing, distraction, zen
---
Create a distraction-free environment for writing and focused editing.

#### Example

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
===
# Title: Diff mode for file comparison
# Category: Window Management
# Tags: diff, compare, vimdiff, merge
---
Use Vim's diff mode to compare and merge files effectively.

#### Example

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
===
# Title: Session management
# Category: Window Management
# Tags: session, workspace, save, restore
---
Save and restore entire editing sessions including windows, tabs, and buffers.

#### Example

```vim
:mksession! ~/session.vim    " save current session
:source ~/session.vim        " load session
vim -S session.vim           " start vim with session

" Automatic session saving
autocmd VimLeave * mksession! ~/.vim/session.vim
autocmd VimEnter * if argc() == 0 | source ~/.vim/session.vim | endif
```
===
# Title: Quick file explorer
# Category: Window Management
# Tags: explorer, netrw, files, browse
---
Use built-in file explorer (netrw) for quick file navigation and management.

#### Example

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
===