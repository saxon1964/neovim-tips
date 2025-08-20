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
===
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
===
# Title: Visual mode - text objects
# Category: Visual
# Tags: visual, text, object, selection
---
Use text objects in visual mode to select structured text: `aw` (word), `ap` (paragraph), `a(` (parentheses), `a"` (quotes).

#### Example

```vim
" In visual mode:
aw   " select around word
ip   " select inside paragraph
a(   " select around parentheses
i"   " select inside double quotes
at   " select around HTML/XML tag
```
===
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
===
# Title: Visual mode - indentation and formatting
# Category: Visual
# Tags: visual, indent, format, shift
---
Use `>` and `<` to indent/unindent selection, `=` to format, `gq` to format text, `gw` to format keeping cursor position.

#### Example

```vim
" After making visual selection:
>    " indent selection right
<    " indent selection left
=    " auto-format selection
gq   " format text lines
gw   " format text, keep cursor position
```
===
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
===
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
===
# Title: Visual mode - encoding and filtering
# Category: Visual
# Tags: visual, encode, filter, external
---
Use `g?` for Rot13 encoding, `!{command}` to filter selection through external command.

#### Example

```vim
" After making visual selection:
g?           " apply Rot13 encoding
!sort        " sort selected lines
!uniq        " remove duplicate lines
!wc -w       " count words in selection
```
===
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
===
# Title: Visual mode - number operations
# Category: Visual
# Tags: visual, number, increment, decrement
---
Use `Ctrl+a` and `Ctrl+x` to increment/decrement numbers in visual selection, `g Ctrl+a` for sequential increment.

#### Example

```vim
" Select numbers, then:
Ctrl+a    " increment all numbers by same amount
Ctrl+x    " decrement all numbers by same amount
g Ctrl+a  " increment sequentially (1, 2, 3...)
```
===
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
===
# Title: Visual mode - exit and cancel
# Category: Visual
# Tags: visual, exit, cancel, escape
---
Use `Esc`, `Ctrl+c`, or the same mode key to exit visual mode.

#### Example

```vim
" In visual mode:
Esc     " exit visual mode
Ctrl+c  " exit visual mode
v       " exit character visual mode
V       " exit line visual mode
Ctrl+v  " exit block visual mode
```
===
# Title: Reselect last visual selection
# Category: Visual
# Tags: reselect, selection, previous, visual
---
Use `gv` to reselect the last visual selection, useful for applying multiple operations to the same text.

#### Example

```vim
" After making a visual selection and returning to normal mode:
gv  " reselect the previous visual selection
```
===