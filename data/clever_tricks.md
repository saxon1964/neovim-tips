# Title: Move line down
# Category: Clever Tricks
# Tags: line, move, transpose
---
Use `ddp` to move current line down one position. This deletes the line and pastes it below.

#### Example

```vim
ddp  " move line down
```
===
# Title: Move line up
# Category: Clever Tricks
# Tags: line, move, transpose
---
Use `ddkP` to move current line up one position. This deletes the line, moves up, and pastes above.

#### Example

```vim
ddkP  " move line up
```
===
# Title: Swap two characters
# Category: Clever Tricks
# Tags: character, swap, transpose
---
Use `xp` to swap current character with next character.

#### Example

```vim
xp  " swap characters
```
===
# Title: Display character information
# Category: Clever Tricks
# Tags: character, ascii, hex, info
---
Use `ga` to display ASCII/hex value of character under cursor, or `g8` to display UTF-8 bytes.

#### Example

```vim
ga  " show ASCII/hex value
g8  " show UTF-8 byte sequence
```
===
# Title: Auto-indent entire document
# Category: Clever Tricks
# Tags: indent, format, document, auto
---
Use `gg=G` to auto-indent entire document from top to bottom.

#### Example

```vim
gg=G  " auto-indent entire file
```
===
# Title: Auto-indent current block
# Category: Clever Tricks
# Tags: indent, block, braces, auto
---
Use `=%` when cursor is on opening brace to auto-indent entire block.

#### Example

```vim
=%  " auto-indent current block/braces
```
===
# Title: Open file under cursor
# Category: Clever Tricks
# Tags: file, open, cursor, path
---
Use `gf` to open file whose name is under cursor. Use `gF` to go to specific line number.

#### Example

```vim
gf   " open file under cursor
gF   " open file and go to line number
```
===
# Title: Line completion in insert mode
# Category: Clever Tricks
# Tags: completion, line, insert, auto
---
Use `Ctrl+X Ctrl+L` in insert mode to complete entire lines from current buffer.

#### Example

```vim
" In insert mode:
Ctrl+X Ctrl+L  " complete entire line
```
===
# Title: Quick substitute word
# Category: Clever Tricks
# Tags: substitute, word, replace
---
Use `ciw{newword}` to change inner word. Position cursor anywhere in word and type replacement.

#### Example

```vim
ciwfoo  " change word to 'foo'
```
===
# Title: Quick fix typo
# Category: Clever Tricks
# Tags: typo, fix, undo
---
Use `~` to toggle case of character under cursor, or `g~iw` to toggle case of entire word.

#### Example

```vim
~     " toggle character case
g~iw  " toggle word case
```
===
# Title: Split line at cursor
# Category: Clever Tricks
# Tags: split, line, break
---
Use `i` followed by `Enter` then `Esc`, or more efficiently `r` followed by `Enter` to break line at cursor.

#### Example

```vim
i<Enter><Esc>  " split line at cursor
```
===
# Title: Quick number increment
# Category: Clever Tricks
# Tags: number, increment, math
---
Use `Ctrl+a` to increment number under cursor, `Ctrl+x` to decrement. Works with decimals and hex.

#### Example

```vim
Ctrl+a  " increment number
Ctrl+x  " decrement number
```
===
# Title: Visual line selection shortcut
# Category: Clever Tricks
# Tags: visual, line, selection
---
Use `V` to select entire line immediately, then `j`/`k` to extend selection.

#### Example

```vim
Vjjj  " select current line + 3 below
```
===
# Title: Change until character
# Category: Clever Tricks
# Tags: change, until, character
---
Use `ct{char}` to change text up to but not including character, or `cf{char}` to include the character.

#### Example

```vim
ct;  " change until semicolon
cf;  " change including semicolon
```
===
# Title: Jump to matching quote
# Category: Clever Tricks
# Tags: quote, matching, jump
---
Use `ci'` or `ci"` to change inside quotes, `ca'` or `ca"` to change including quotes.

#### Example

```vim
ci'  " change inside single quotes
ca"  " change including double quotes
```
===
# Title: Quick paragraph navigation
# Category: Clever Tricks
# Tags: paragraph, navigation, block
---
Use `{` to jump to previous paragraph/block, `}` to jump to next paragraph/block.

#### Example

```vim
{  " previous paragraph
}  " next paragraph
```
===
# Title: Smart word boundaries
# Category: Clever Tricks
# Tags: word, boundary, navigation
---
Use `W` for WORD (space-separated) vs `w` for word (punctuation-separated). Same with `B` vs `b` and `E` vs `e`.

#### Example

```vim
W  " next WORD (space-separated)
w  " next word (punctuation-separated)
```
===
# Title: Reselect last selection
# Category: Clever Tricks
# Tags: visual, reselect, selection
---
Use `gv` to reselect the last visual selection.

#### Example

```vim
gv  " reselect last visual selection
```
===
# Title: Center line after jump
# Category: Clever Tricks
# Tags: center, jump, navigation
---
Append `zz` after navigation commands to center the line. Works with searches, line jumps, etc.

#### Example

```vim
42Gzz   " jump to line 42 and center
/foozz  " search for 'foo' and center
```
===