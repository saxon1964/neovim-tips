# Title: Visual selection modes
# Category: Visual
# Tags: visual, selection, mode
---
Use `v` for character-wise visual mode, `V` for line-wise visual mode, and `Ctrl+v` for block-wise visual mode.

#### Example

```vim
v      " character visual
V      " line visual
Ctrl+v " block visual
```
***
# Title: Yank and delete in visual mode
# Category: Visual
# Tags: yank, delete, visual
---
Use `y` to yank (copy) selected text and `d` to delete selected text in visual mode.

#### Example

```vim
y  " yank selected text
d  " delete selected text
```
***
# Title: Yank highlighting
# Category: Visual
# Tags: yank, highlight, autocmd
---
Create an autocmd to highlight yanked text briefly for visual feedback.

#### Example

```vim
:lua vim.api.nvim_create_autocmd("TextYankPost", {callback = function() vim.highlight.on_yank() end})
```
***
# Title: Visual block append
# Category: Visual
# Tags: visual, block, append, column
---
Use `Ctrl+v` to select visual block, then `A` to append text to end of each selected line.

#### Example

```vim
Ctrl+v  " select visual block
A       " append to end of all lines
text    " type text to append
Esc     " apply to all lines
```
***
# Title: Reselect last visual selection
# Category: Visual
# Tags: visual, reselect, selection, repeat
---
Use `gv` to reselect the last visual selection area.

#### Example

```vim
gv  " reselect last visual selection
```
***
# Title: Visual mode - corner and edge movement
# Category: Visual
# Tags: visual, corner, block, movement
---
Use `o` to move cursor to opposite corner of selection, `O` to move to other corner in block mode.

#### Example

```vim
" In visual mode:
o   " move cursor to opposite corner of selection
O   " move to other corner (block mode only)
```
***
# Title: Visual mode - toggle and change types
# Category: Visual
# Tags: visual, toggle, change, type
---
Use `v`, `V`, `Ctrl+v` in visual mode to change selection type or exit. Use `Ctrl+g` to toggle between Visual and Select mode.

#### Example

```vim
" In visual mode:
v       " change to character-wise or exit visual
V       " change to line-wise or exit visual  
Ctrl+v  " change to block-wise or exit visual
Ctrl+g  " toggle Visual/Select mode
```
***
# Title: Visual mode - operators and transformations
# Category: Visual
# Tags: visual, operator, transform, case
---
Apply operators to visual selections: `c` (change), `d` (delete), `y` (yank), `~` (toggle case), `u` (lowercase), `U` (uppercase).

#### Example

```vim
" After making visual selection:
c   " change selected text
d   " delete selected text
y   " yank selected text
~   " toggle case of selection
u   " make selection lowercase
U   " make selection uppercase
```
***
# Title: Visual mode - joining and substitution
# Category: Visual
# Tags: visual, join, substitute, replace
---
Use `J` to join selected lines with spaces, `gJ` to join without spaces, `s` to substitute selection, `r` to replace each character.

#### Example

```vim
" After making visual selection:
J    " join lines with spaces
gJ   " join lines without spaces
s    " substitute selected text
rx   " replace each character with 'x'
```
***
# Title: Visual mode - paste and replace
# Category: Visual
# Tags: visual, paste, replace, register
---
Use `p` or `P` to replace visual selection with register contents. This is useful for swapping text.

#### Example

```vim
" Copy text first, then select other text:
p   " replace selection with register contents
P   " same as p in visual mode
```
***
# Title: Visual mode - Ex commands
# Category: Visual
# Tags: visual, ex, command, range
---
Press `:` in visual mode to run Ex commands on the selected range. The range `'<,'>` is automatically inserted.

#### Example

```vim
" After making visual selection:
:               " enters :'<,'> for range
:s/old/new/g    " substitute in selection
:sort           " sort selected lines
:w newfile.txt  " write selection to file
```
***
# Title: Visual mode - tag and keyword operations
# Category: Visual
# Tags: visual, tag, keyword, jump
---
Use `Ctrl+]` to jump to tag of selected text, `K` to run keywordprg on selection.

#### Example

```vim
" After selecting text:
Ctrl+]  " jump to tag of selected text
K       " run help/man on selected keyword
```
***
