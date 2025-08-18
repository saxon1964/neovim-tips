Visual selection modes
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
===

Indent text in visual mode
# Title: Indent text in visual mode
# Category: Visual
# Tags: indent, visual, editing
---
Use `>` to shift selected text right and `<` to shift selected text left in visual mode.

#### Example

```vim
>  " shift right
<  " shift left
```
===

Yank and delete in visual mode
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
===

Yank highlighting
# Title: Yank highlighting
# Category: Visual
# Tags: yank, highlight, autocmd
---
Create an autocmd to highlight yanked text briefly for visual feedback.

#### Example

```vim
:lua vim.api.nvim_create_autocmd("TextYankPost", {callback = function() vim.highlight.on_yank() end})
```
===

Visual block append
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
===

Reselect last visual selection
# Title: Reselect last visual selection
# Category: Visual
# Tags: visual, reselect, selection, repeat
---
Use `gv` to reselect the last visual selection area.

#### Example

```vim
gv  " reselect last visual selection
```
===

Sort visual selection
# Title: Sort visual selection
# Category: Visual
# Tags: visual, sort, selection, lines
---
Select lines in visual mode, then use `:sort` to sort only the selected lines.

#### Example

```vim
V         " select lines
:'<,'>sort  " sort selected lines
```
===
