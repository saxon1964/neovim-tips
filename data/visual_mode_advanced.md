# Title: Visual block column insertion
# Category: Visual Mode Advanced
# Tags: visual, block, column, insert, prepend
---
Use visual block mode with `I` to insert text at the beginning of each selected line.

```vim
Ctrl+v          " start visual block mode
jjj             " select multiple lines  
I               " insert at beginning of each line
text            " type text to insert
<Esc>           " apply to all selected lines
```
***
# Title: Visual block column editing
# Category: Visual Mode Advanced
# Tags: visual, block, column, edit, replace
---
Use visual block mode with `c` to change the same column range on multiple lines.

```vim
Ctrl+v          " start visual block mode
jjj             " select lines vertically
lll             " extend selection horizontally  
c               " change selected block
new_text        " replacement text
<Esc>           " apply to all lines
```
***
# Title: Visual block append to varying line lengths
# Category: Visual Mode Advanced  
# Tags: visual, block, append, variable, length
---
Use `$` in visual block mode to select to end of lines, then `A` to append despite varying lengths.

```vim
Ctrl+v          " start visual block mode
jjj             " select multiple lines
$               " extend to end of longest line
A               " append to end of each line
text            " text to append
<Esc>           " apply to all lines
```
***
# Title: Visual selection with text objects
# Category: Visual Mode Advanced
# Tags: visual, text, object, combine, selection
---
Combine visual mode with text objects for precise selections.

```vim
vaw             " visually select a word
vap             " visually select a paragraph  
vi(             " visually select inside parentheses
va{             " visually select around braces
vit             " visually select inside HTML/XML tags
```
***
# Title: Visual mode indentation and alignment
# Category: Visual Mode Advanced
# Tags: visual, indent, align, format, block
---
Use visual mode for precise indentation and alignment operations.

```vim
" After visual selection:
>               " indent selected text right
<               " indent selected text left  
=               " auto-format selected text
gq              " format text to textwidth
```
***
# Title: Visual mode sorting and filtering
# Category: Visual Mode Advanced
# Tags: visual, sort, filter, lines, unique
---
Apply sorting and filtering operations to visual selections.

```vim
" After visual selection:
:sort           " sort selected lines alphabetically
:sort n         " sort selected lines numerically
:sort u         " sort and remove duplicates
:sort!          " sort in reverse order
```
***
# Title: Visual mode search and replace
# Category: Visual Mode Advanced
# Tags: visual, search, replace, substitute, scope
---
Perform search and replace operations within visual selections.

```vim
" After visual selection:
:s/old/new/g    " replace in selection
:s/\%Vold/new/g " replace only within selection bounds
:g/pattern/d    " delete lines matching pattern in selection
:v/pattern/d    " delete lines NOT matching pattern
```
***
# Title: Visual mode with external filters
# Category: Visual Mode Advanced
# Tags: visual, filter, external, command, process
---
Filter visual selections through external commands.

```vim
" After visual selection:
!sort           " sort through external sort command
!uniq           " remove duplicates with uniq
!wc -l          " replace selection with line count
!column -t      " format as table with column command
```
***
# Title: Visual mode macro application
# Category: Visual Mode Advanced  
# Tags: visual, macro, apply, lines, batch
---
Apply macros to each line of a visual selection.

```vim
" First record a macro (e.g., in register 'a')
qa              " start recording
... commands ...
q               " stop recording

" Then apply to visual selection:
V               " select lines
jjj             " extend selection
:normal @a      " apply macro 'a' to each line
```
***
# Title: Visual mode text transformation
# Category: Visual Mode Advanced
# Tags: visual, transform, text, case, format
---
Apply various text transformations to visual selections.

```vim
" After visual selection:
u               " convert to lowercase
U               " convert to uppercase
~               " toggle case
g?              " ROT13 encoding
Ctrl+a          " increment numbers in selection
Ctrl+x          " decrement numbers in selection
```
***
# Title: Visual line operations
# Category: Visual Mode Advanced
# Tags: visual, line, operation, move, duplicate
---
Perform line-level operations on visual line selections.

```vim
" After visual line selection (V):
J               " join selected lines with spaces
gJ              " join selected lines without spaces  
:m +3           " move selected lines 3 positions down
:t .            " duplicate selected lines after current
```
***
# Title: Visual mode with marks
# Category: Visual Mode Advanced
# Tags: visual, mark, position, range, selection
---
Use marks to create precise visual selections.

```vim
ma              " set mark 'a'
... move cursor ...
v'a             " visual select from current to mark 'a'
V`a             " visual line select from current to mark 'a'
```
***
# Title: Visual mode text wrapping
# Category: Visual Mode Advanced
# Tags: visual, wrap, text, format, width
---
Control text wrapping and formatting in visual selections.

```vim
" After visual selection:
gw              " wrap lines to textwidth  
gwap            " wrap around paragraph
gqq             " format current line
gqap            " format around paragraph
```
***
# Title: Visual mode register operations
# Category: Visual Mode Advanced
# Tags: visual, register, yank, paste, specific
---
Work with specific registers in visual mode.

```vim
" After visual selection:
"ay             " yank selection to register 'a'
"Ay             " append selection to register 'a'
"+y             " yank to system clipboard
"*y             " yank to X11 selection
"0p             " paste from yank register (over selection)
```
***
# Title: Visual mode pattern matching
# Category: Visual Mode Advanced
# Tags: visual, pattern, select, match, extend
---
Select text based on patterns and extend selections intelligently.

```vim
/pattern        " search for pattern
n               " go to next match
v               " start visual selection
n               " extend selection to next match
//e             " extend selection to end of current match
```
***
# Title: Visual mode column operations
# Category: Visual Mode Advanced
# Tags: visual, column, arithmetic, calculation, block
---
Perform arithmetic operations on columns of numbers.

```vim
Ctrl+v          " visual block mode
jjj             " select column of numbers
g Ctrl+a        " increment each number by 1, 2, 3...
g Ctrl+x        " decrement each number by 1, 2, 3...
```
***
# Title: Visual mode with folds
# Category: Visual Mode Advanced
# Tags: visual, fold, unfold, selection, code
---
Work with code folds in visual mode.

```vim
" After visual selection:
zf              " create fold from selection
:fold           " create fold from selected lines
zo              " open fold under cursor
zc              " close fold under cursor
```
***
# Title: Visual mode word selection shortcuts
# Category: Visual Mode Advanced
# Tags: visual, word, select, expand, quick
---
Quick methods to visually select words and expand selections.

```vim
viw             " select inner word
vaw             " select a word (with spaces)
viW             " select inner WORD (space-separated)  
vaW             " select a WORD
gv              " reselect last visual selection
```
***
# Title: Visual mode line manipulation
# Category: Visual Mode Advanced
# Tags: visual, line, manipulate, duplicate, move
---
Advanced line manipulation techniques in visual mode.

```vim
" After visual line selection:
:co +5          " copy selected lines 5 lines down
:m -2           " move selected lines 2 lines up  
:t $            " copy selected lines to end of file
:d              " delete selected lines
```
***
# Title: Visual mode smart selection
# Category: Visual Mode Advanced
# Tags: visual, smart, selection, expand, contract
---
Smart selection expansion and contraction techniques.

```vim
" In visual mode:
aw              " expand to select a word
ap              " expand to select a paragraph
a(              " expand to select around parentheses
i{              " contract to select inside braces
```
***
# Title: Visual mode with global commands
# Category: Visual Mode Advanced
# Tags: visual, global, command, pattern, execute
---
Execute global commands on visual selections.

```vim
" After visual selection:
:g/pattern/normal @a    " run macro 'a' on matching lines
:g/TODO/s/old/new/g     " replace in TODO lines only
:v/important/d          " delete lines not containing 'important'
```
***
# Title: Visual mode incremental selection
# Category: Visual Mode Advanced
# Tags: visual, incremental, selection, extend, treesitter
---
Use incremental selection for smart code selection (with treesitter).

```vim
" In normal mode (with treesitter):
gnn             " start incremental selection
grn             " increment selection to next node
grm             " increment selection to scope
grc             " increment selection to clause
```
***
# Title: Visual mode with jumps and changes
# Category: Visual Mode Advanced
# Tags: visual, jump, change, navigate, selection
---
Create visual selections based on jump and change lists.

```vim
Ctrl+o          " go to previous jump position
v               " start visual selection  
Ctrl+i          " extend selection to next jump position
g;              " go to previous change
V               " line visual from previous change  
g,              " extend to next change
```
***
# Title: Visual mode rectangle operations
# Category: Visual Mode Advanced
# Tags: visual, rectangle, block, operation, column
---
Advanced rectangle/block operations for precise editing.

```vim
Ctrl+v          " start visual block
G               " select to end of file (column)
I//             " insert // at beginning of each line
<Esc>           " apply to create comment block

Ctrl+v          " visual block
$               " to end of lines
A;              " append semicolon to each line
<Esc>           " apply to all lines
```
***
