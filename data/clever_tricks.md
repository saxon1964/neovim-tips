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
# Title: G-commands - search variations
# Category: Clever Tricks  
# Tags: search, variations, boundaries
---
Use `g*` and `g#` to search for word under cursor without word boundaries (matches partial words).

#### Example

```vim
g*  " search forward for word without boundaries
g#  " search backward for word without boundaries
```
===
# Title: G-commands - undo branches
# Category: Clever Tricks
# Tags: undo, branch, time, state
---
Use `g-` and `g+` to navigate through undo branches by time.

#### Example

```vim
g-  " go to older text state
g+  " go to newer text state
```
===
# Title: G-commands - screen line movement
# Category: Clever Tricks
# Tags: screen, line, wrap, movement
---
Use `gj` and `gk` to move by screen lines when text is wrapped, `g0` and `g$` for screen line start/end.

#### Example

```vim
gj  " move down by screen line (with wrap)
gk  " move up by screen line (with wrap)
g0  " go to start of screen line
g$  " go to end of screen line
```
===
# Title: G-commands - middle of line
# Category: Clever Tricks
# Tags: middle, line, screen, text
---
Use `gm` to go to middle of screen line and `gM` to go to middle of text line.

#### Example

```vim
gm  " go to middle of screen line
gM  " go to middle of text line
```
===
# Title: G-commands - case conversion
# Category: Clever Tricks
# Tags: case, convert, upper, lower
---
Use `gU{motion}` for uppercase, `gu{motion}` for lowercase, and `g~{motion}` to toggle case.

#### Example

```vim
gUw   " uppercase word
guu   " lowercase current line
g~iw  " toggle case of word under cursor
```
===
# Title: G-commands - join without space
# Category: Clever Tricks
# Tags: join, line, space
---
Use `gJ` to join lines without inserting a space between them.

#### Example

```vim
gJ  " join lines without adding space
```
===
# Title: G-commands - search and select
# Category: Clever Tricks
# Tags: search, select, visual, pattern
---
Use `gn` to find and visually select next search match, `gN` for previous match.

#### Example

```vim
/pattern<Enter>  " search for pattern first
gn               " select next match
gN               " select previous match
```
===
# Title: G-commands - put and leave cursor
# Category: Clever Tricks
# Tags: put, paste, cursor, position
---
Use `gp` and `gP` to put text and leave cursor after the pasted text.

#### Example

```vim
gp  " put after and leave cursor at end
gP  " put before and leave cursor at end
```
===
# Title: G-commands - format keeping cursor
# Category: Clever Tricks
# Tags: format, cursor, position, text
---
Use `gw{motion}` to format text while keeping cursor position unchanged.

#### Example

```vim
gwap  " format paragraph, keep cursor position
```
===
# Title: G-commands - sleep
# Category: Clever Tricks
# Tags: sleep, delay, pause
---
Use `gs` to make Neovim sleep for specified seconds (useful in scripts).

#### Example

```vim
3gs  " sleep for 3 seconds
gs   " sleep for 1 second (default)
```
===
# Title: G-commands - execute application
# Category: Clever Tricks
# Tags: execute, application, file, system
---
Use `gx` to execute the default application for the file/URL under cursor.

#### Example

```vim
gx  " open file/URL under cursor with default app
```
===
# Title: G-commands - virtual replace
# Category: Clever Tricks
# Tags: virtual, replace, mode, character
---
Use `gR` to enter virtual replace mode, `gr{char}` to replace character without affecting layout.

#### Example

```vim
gR    " enter virtual replace mode
grx   " replace character with 'x' virtually
```
===
# Title: G-commands - select modes
# Category: Clever Tricks
# Tags: select, mode, visual, block
---
Use `gh` for select mode, `gH` for select line mode, `g Ctrl+h` for select block mode.

#### Example

```vim
gh       " start select mode
gH       " start select line mode
g Ctrl+h " start select block mode
```
===
# Title: G-commands - Rot13 encoding
# Category: Clever Tricks
# Tags: rot13, encode, cipher, text
---
Use `g?{motion}` to apply Rot13 encoding to text (shifts letters by 13).

#### Example

```vim
g?iw  " apply Rot13 to word under cursor
g??   " apply Rot13 to current line
```
===
# Title: G-commands - repeat substitute
# Category: Clever Tricks
# Tags: substitute, repeat, global, command
---
Use `g&` to repeat the last `:substitute` command on all lines.

#### Example

```vim
:s/old/new/   " substitute on current line
g&            " repeat substitute on all lines
```
===
# Title: G-commands - display command output
# Category: Clever Tricks
# Tags: display, command, output, history
---
Use `g<` to display the output of the previous command.

#### Example

```vim
g<  " display previous command output
```
===
# Title: G-commands - mark navigation without jumplist
# Category: Clever Tricks
# Tags: mark, navigation, jumplist
---
Use `g'` and `` g` `` to jump to marks without changing the jumplist.

#### Example

```vim
g'a  " jump to mark 'a' without affecting jumplist
g`a  " jump to exact position of mark 'a' without jumplist
```
===
# Title: Repeat last Ex command with @:
# Category: Clever Tricks
# Tags: repeat, ex, command, macro, colon
---
Use `@:` to repeat the last Ex command, similar to how `@@` repeats macros.

#### Example

```vim
:substitute/old/new/g
@:  " repeat the last substitute command
```
===
# Title: Enhanced repeat with cursor positioning
# Category: Clever Tricks
# Tags: repeat, cursor, position, change, dot
---
Map `.` followed by `` ` `` to repeat last command and return cursor to start of change.

#### Example

```vim
" Add this mapping:
nnoremap <leader>. .`[

" Now after making a change:
<leader>.  " repeat change and go to start position
```
===
# Title: List lines matching last search
# Category: Clever Tricks
# Tags: search, list, global, pattern, last
---
Use `:g//` to list all lines containing the last search pattern without specifying the pattern again.

#### Example

```vim
/function   " search for 'function'
:g//        " list all lines containing 'function'
:g//p       " same as above (print is default)
```
===
# Title: Save each line to separate files
# Category: Clever Tricks
# Tags: file, save, line, separate, export
---
Use `:g/^/exe` to save each line to a separate file with incremental names.

#### Example

```vim
:let i = 1 | g/^/exe 'w! line' . i . '.txt' | let i = i + 1
" Saves each line to line1.txt, line2.txt, etc.
```
===
# Title: Alternative substitute delimiters
# Category: Clever Tricks
# Tags: substitute, delimiter, slash, alternative
---
Use any character as delimiter in substitute commands to avoid escaping slashes in paths.

#### Example

```vim
:s#/path/to/old#/path/to/new#g  " using # as delimiter
:s|/usr/bin|/usr/local/bin|g    " using | as delimiter
:s@old@new@g                    " using @ as delimiter
```
===
# Title: Calculation with expression register
# Category: Clever Tricks
# Tags: calculation, expression, register, math, evaluate
---
Use `=` register to evaluate mathematical expressions and insert results.

#### Example

```vim
" In insert mode:
Ctrl+r =2+3*4<Enter>    " inserts 14
Ctrl+r =sqrt(16)<Enter> " inserts 4.0
Ctrl+r =strftime("%Y")<Enter>  " inserts current year
```
===
# Title: Word count in selection or file
# Category: Clever Tricks
# Tags: word, count, selection, statistics, file
---
Use `g Ctrl+g` to show word count, or `:!wc -w %` for file word count.

#### Example

```vim
" Select text in visual mode, then:
g Ctrl+g     " show character, word, line count of selection

" For entire file:
:!wc -w %    " show word count of current file
```
===
# Title: Scroll windows together
# Category: Clever Tricks
# Tags: scroll, window, together, bind, sync
---
Use `:set scrollbind` in multiple windows to scroll them together synchronously.

#### Example

```vim
" In first window:
:set scrollbind

" In second window:
:set scrollbind

" Now both windows scroll together
" To disable:
:set noscrollbind
```
===
# Title: Change directory to current file
# Category: Clever Tricks
# Tags: directory, current, file, cd, path
---
Use `:cd %:h` to change directory to the directory of the current file.

#### Example

```vim
:cd %:h     " change to current file's directory
:pwd        " verify current directory
:lcd %:h    " change local directory for current window only
```
===
# Title: Open URL from current line
# Category: Clever Tricks
# Tags: url, open, browser, web, link
---
Use `gx` to open URL under cursor, or create mapping to open entire line as URL.

#### Example

```vim
gx  " open URL under cursor with default browser

" Custom mapping for entire line:
nnoremap <leader>o :!open <cWORD><CR>
```
===
# Title: File encoding in status line
# Category: Clever Tricks
# Tags: encoding, status, line, file, format
---
Add file encoding to status line to see current file's character encoding.

#### Example

```vim
:set statusline=%f\ [%{&fileencoding?&fileencoding:&encoding}]\ %y
" Shows filename, encoding, and filetype
```
===
# Title: Create word frequency table
# Category: Clever Tricks
# Tags: word, frequency, table, count, analysis
---
Create a word frequency analysis using Vim commands and external tools.

#### Example

```vim
" Create word frequency table:
:%s/\W\+/\r/g | sort | uniq -c | sort -nr
" Or using Vim's internal commands:
:g/./normal 0"ay$
```
===
# Title: Search for lines NOT matching pattern
# Category: Clever Tricks
# Tags: search, not, matching, invert, negative
---
Use `:v/pattern/` or `:g!/pattern/` to work with lines that do NOT match a pattern.

#### Example

```vim
:v/TODO/d       " delete lines NOT containing TODO
:g!/function/p  " print lines NOT containing 'function'
:v/^$/d         " delete non-empty lines (keep only empty lines)
```
===
# Title: Swap assignment statement sides
# Category: Clever Tricks
# Tags: swap, assignment, left, right, substitute
---
Use substitute with groups to swap left and right sides of assignment statements.

#### Example

```vim
" Swap variable assignment (a = b becomes b = a):
:%s/\(\w\+\)\s*=\s*\(\w\+\)/\2 = \1/g

" Swap in selected region:
:'<,'>s/\(\w\+\)\s*=\s*\(\w\+\)/\2 = \1/g
```
===
# Title: Z-commands - spelling corrections
# Category: Clever Tricks
# Tags: spelling, correction, dictionary
---
Use `z=` for spelling suggestions, `zg` to add word to dictionary, `zw` to mark as misspelled, `zG`/`zW` for temporary marks.

#### Example

```vim
z=  " show spelling suggestions for word under cursor
zg  " add word to personal dictionary (good)
zw  " mark word as misspelled (wrong)
zG  " temporarily mark word as correct
zW  " temporarily mark word as incorrect
```
===
