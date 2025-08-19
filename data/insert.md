# Title: Insert modes
# Category: Insert
# Tags: insert, mode, editing
---
Use `i` to insert before cursor, `I` to insert at line start, `a` to append after cursor, and `A` to append at line end.

#### Example

```vim
i  " insert before cursor
I  " insert at line start
a  " append after cursor
A  " append at line end
```
===
# Title: New line insertion
# Category: Insert
# Tags: insert, line, editing
---
Use `o` to open new line below current line and `O` to open new line above current line.

#### Example

```vim
o  " new line below
O  " new line above
```
===
# Title: Insert mode deletion
# Category: Insert
# Tags: delete, insert, editing
---
Use `Ctrl+h` to delete character before cursor and `Ctrl+w` to delete word before cursor while in insert mode.

#### Example

```vim
Ctrl+h  " delete character
Ctrl+w  " delete word
```
===
# Title: Insert mode movement
# Category: Insert
# Tags: movement, insert, cursor, navigation
---
Use `Ctrl+o` in insert mode to execute one normal mode command, then return to insert mode.

#### Example

```vim
" In insert mode:
Ctrl+o w     " move to next word and return to insert
Ctrl+o dw    " delete word and return to insert
```
===
# Title: Paste in insert mode
# Category: Insert
# Tags: paste, insert, register, clipboard
---
Use `Ctrl+r "` to paste from default register, or `Ctrl+r a` to paste from register 'a' while in insert mode.

#### Example

```vim
" In insert mode:
Ctrl+r "     " paste from default register
Ctrl+r a     " paste from register 'a'
```
===
# Title: Insert literal character
# Category: Insert
# Tags: literal, character, special, escape
---
Use `Ctrl+v` followed by character to insert literal/special characters in insert mode.

#### Example

```vim
" In insert mode:
Ctrl+v Tab   " insert literal tab character
Ctrl+v Esc   " insert literal escape character
```
===
# Title: Insert mode completion
# Category: Insert
# Tags: completion, autocomplete, popup
---
Use `Ctrl+n` for next completion match and `Ctrl+p` for previous completion match. Use `Ctrl+x Ctrl+f` for filename completion.

#### Example

```vim
" In insert mode:
Ctrl+n        " next completion
Ctrl+p        " previous completion
Ctrl+x Ctrl+f " filename completion
```
===
# Title: Insert digraphs
# Category: Insert
# Tags: digraph, special, characters, unicode
---
Use `Ctrl+k` followed by two characters to insert digraphs (special characters). Use `:digraphs` to see available combinations.

#### Example

```vim
" In insert mode:
Ctrl+k a:    " insert ä
Ctrl+k <<    " insert «
:digraphs    " show all digraphs
```
===
# Title: Insert mode undo
# Category: Insert
# Tags: undo, insert, editing
---
Use `Ctrl+u` to delete all characters from cursor to start of line and `Ctrl+w` to delete word before cursor while in insert mode.

#### Example

```vim
" In insert mode:
Ctrl+u  " delete to line start
Ctrl+w  " delete previous word
```
===
# Title: Insert calculation result
# Category: Insert
# Tags: calculation, expression, register
---
Use `Ctrl+r =` to insert the result of an expression calculation in insert mode.

#### Example

```vim
" In insert mode:
Ctrl+r =2+3<Enter>  " inserts 5
Ctrl+r =strftime("%Y-%m-%d")<Enter>  " inserts current date
```
===
# Title: Replace mode
# Category: Insert
# Tags: replace, overwrite, mode
---
Use `R` to enter replace mode where typed characters overwrite existing text. Use `gR` for virtual replace mode.

#### Example

```vim
R   " enter replace mode
gR  " enter virtual replace mode
```
===
# Title: Insert mode line break
# Category: Insert
# Tags: line, break, split
---
Use `Ctrl+j` or `Ctrl+m` to create a new line in insert mode (equivalent to pressing Enter).

#### Example

```vim
" In insert mode:
Ctrl+j  " new line
Ctrl+m  " new line (alternative)
```
===
# Title: Insert above cursor
# Category: Insert
# Tags: insert, above, cursor
---
Use `gO` to insert a line above current line without moving cursor position, useful for adding code above current line.

#### Example

```vim
gO  " insert line above without moving cursor
```
===
# Title: Repeat last inserted text
# Category: Insert
# Tags: repeat, insert, text, previous
---
Use `Ctrl+a` to insert previously inserted text, or `Ctrl+@` to insert previously inserted text and immediately exit insert mode.

#### Example

```vim
" In insert mode:
Ctrl+a  " insert previously typed text
Ctrl+@  " insert previous text and exit insert mode
```
===
# Title: Copy character from line above/below
# Category: Insert
# Tags: copy, character, above, below
---
Use `Ctrl+y` to copy the character above the cursor and `Ctrl+e` to copy the character below the cursor while in insert mode.

#### Example

```vim
" In insert mode:
Ctrl+y  " copy character from line above
Ctrl+e  " copy character from line below
```
===
# Title: Adjust indentation in insert mode
# Category: Insert
# Tags: indent, indentation, shift
---
Use `Ctrl+t` to add one shiftwidth of indentation and `Ctrl+d` to remove one shiftwidth of indentation while in insert mode.

#### Example

```vim
" In insert mode:
Ctrl+t  " increase indent
Ctrl+d  " decrease indent
```
===
# Title: Exit insert mode alternatives
# Category: Insert
# Tags: exit, escape, mode
---
Use `Ctrl+c` to quit insert mode without checking abbreviations, or `Ctrl+[` as an alternative to Escape key.

#### Example

```vim
" In insert mode:
Ctrl+c  " quit insert mode (no abbreviation check)
Ctrl+[  " same as Escape key
```
===
# Title: Insert mode cursor movement with insertion point
# Category: Insert
# Tags: cursor, movement, insertion, point
---
Use `Ctrl+g j` to move cursor down to the column where insertion started and `Ctrl+g k` to move cursor up to that column.

#### Example

```vim
" In insert mode:
Ctrl+g j  " move down to insertion start column
Ctrl+g k  " move up to insertion start column
```
===
# Title: Control undo granularity in insert mode
# Category: Insert
# Tags: undo, granularity, control
---
Use `Ctrl+g u` to start a new undoable edit and `Ctrl+g U` to prevent the next cursor movement from breaking the undo sequence.

#### Example

```vim
" In insert mode:
Ctrl+g u  " start new undo block
Ctrl+g U  " don't break undo with next movement
```
===
# Title: Trigger abbreviation manually
# Category: Insert
# Tags: abbreviation, trigger, expand
---
Use `Ctrl+]` to manually trigger abbreviation expansion in insert mode.

#### Example

```vim
" In insert mode (after setting abbreviation):
:iab teh the
teh<Ctrl+]>  " expands to 'the'
```
===
# Title: Insert mode completion subcommands
# Category: Insert
# Tags: completion, submode, advanced
---
After `Ctrl+x`, use `Ctrl+d` for defined identifiers, `Ctrl+f` for filenames, `Ctrl+e` to scroll up in completion menu, `Ctrl+y` to scroll down.

#### Example

```vim
" In insert mode:
Ctrl+x Ctrl+d  " complete defined identifiers  
Ctrl+x Ctrl+f  " complete filenames
Ctrl+x Ctrl+e  " scroll up in completion
Ctrl+x Ctrl+y  " scroll down in completion
```
===
# Title: Insert tab character alternatives
# Category: Insert
# Tags: tab, character, indent
---
Use `Ctrl+i` as an alternative to the Tab key for inserting tab characters in insert mode.

#### Example

```vim
" In insert mode:
Ctrl+i  " insert tab character (same as Tab key)
```
===
# Title: Insert newline alternatives
# Category: Insert
# Tags: newline, line, break, enter
---
Use `Ctrl+m` or `Ctrl+j` as alternatives to the Enter key for creating new lines in insert mode.

#### Example

```vim
" In insert mode:
Ctrl+m  " new line (same as Enter)
Ctrl+j  " new line (alternative)
```
===