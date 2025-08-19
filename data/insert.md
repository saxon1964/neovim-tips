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