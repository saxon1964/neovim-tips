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
