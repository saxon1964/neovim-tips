Equalize window sizes
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

Maximize window dimensions
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

Resize windows incrementally
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

Rotate windows
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

Move windows
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

Fast window resizing
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

Better gm command
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

Open file under cursor
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

Keep cursor centered
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

Change cursor shape in modes
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

Keep window when closing buffer
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
