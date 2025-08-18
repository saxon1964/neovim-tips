Insert modes
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

New line insertion
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

Insert mode deletion
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

Insert mode movement
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

Paste in insert mode
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

Insert literal character
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
