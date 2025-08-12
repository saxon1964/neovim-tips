Move line down
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

Move line up
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

Duplicate line
# Title: Duplicate line
# Category: Clever Tricks
# Tags: line, duplicate, copy
---
Use `yyp` to duplicate current line below, or `yyP` to duplicate above.

#### Example

```vim
yyp  " duplicate line below
yyP  " duplicate line above
```
===

Swap two characters
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

Quick substitute word
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

Quick fix typo
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

Split line at cursor
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

Quick number increment
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

Visual line selection shortcut
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

Change until character
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

Jump to matching quote
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

Quick paragraph navigation
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

Smart word boundaries
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

Reselect last selection
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

Center line after jump
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
