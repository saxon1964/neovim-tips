# Title: Lowercase/uppercase current line
# Category: Text Manipulation
# Tags: case, line, transform
---
Use `guu` to lowercase current line or `gUU` to uppercase current line.

#### Example

```vim
guu  " lowercase current line
gUU  " uppercase current line
```
===
# Title: Uppercase current word
# Category: Text Manipulation
# Tags: case, word, uppercase
---
Use `gUw` to uppercase current word.

#### Example

```vim
gUw  " uppercase current word
```
===
# Title: Format paragraph
# Category: Text Manipulation
# Tags: format, paragraph, wrap
---
Use `gqap` to format/wrap a paragraph according to textwidth.

#### Example

```vim
gqap  " format around paragraph
```
===
# Title: Remove trailing whitespace
# Category: Text Manipulation
# Tags: whitespace, trailing, clean
---
Use `:%s/\s\+$//` to remove trailing whitespace from all lines.

#### Example

```vim
:%s/\s\+$//  " remove trailing whitespace
```
===
# Title: Delete blank lines
# Category: Text Manipulation
# Tags: delete, blank, lines
---
Use `:g/^$/d` to delete all blank/empty lines in the buffer.

#### Example

```vim
:g/^$/d  " delete blank lines
```
===
# Title: Delete non-matching lines
# Category: Text Manipulation
# Tags: delete, pattern, inverse
---
Use `:v/pattern/d` to delete all lines that do NOT match the pattern.

#### Example

```vim
:v/TODO/d  " delete lines that don't contain 'TODO'
```
===
# Title: Insert numbering
# Category: Text Manipulation
# Tags: numbering, sequence, insert, auto
---
Use `:put =range(1,10)` to insert numbers 1-10, or select lines and use `:s/^/\=line('.')-line("'<")+1.'. '/` for relative numbering.

#### Example

```vim
:put =range(1,10)  " insert numbers 1-10
" Or for selected lines:
:'<,'>s/^/\=line('.')-line("'<")+1.'. '/
```
===
# Title: Convert tabs to spaces
# Category: Text Manipulation
# Tags: tabs, spaces, convert, whitespace
---
Use `:retab` to convert tabs to spaces using current tabstop setting, or `:set expandtab | retab` to convert and set future tabs as spaces.

#### Example

```vim
:retab              " convert tabs to spaces
:set expandtab | retab  " convert and set expandtab
```
===
# Title: Join lines with custom separator
# Category: Text Manipulation
# Tags: join, separator, custom, lines
---
Use `:'<,'>s/\n/, /g` to join selected lines with custom separator (comma-space in example).

#### Example

```vim
:'<,'>s/\n/, /g     " join lines with ", "
:'<,'>s/\n/ | /g    " join lines with " | "
```
===
# Title: Reverse lines
# Category: Text Manipulation
# Tags: reverse, lines, order, flip
---
Use `:g/^/m0` to reverse all lines in buffer, or select lines and use `:'<,'>g/^/m '<-1` for selection.

#### Example

```vim
:g/^/m0             " reverse all lines
:'<,'>g/^/m'<-1     " reverse selected lines
```
===
# Title: Insert column of text
# Category: Text Manipulation
# Tags: column, insert, visual, block
---
Use visual block mode (`Ctrl+V`), select column, press `I` to insert, type text, then `Esc` to apply to all lines.

#### Example

```vim
Ctrl+V  " start visual block
I       " insert at beginning of block
text    " type text to insert
Esc     " apply to all selected lines
```
===
# Title: Insert line numbers
# Category: Text Manipulation  
# Tags: numbers, lines, automatic, sequence
---
Use `:put =range(1,10)` to insert numbers 1-10, or use visual block with `g<C-a>` to create sequences.

#### Example

```vim
:put =range(1,10)        " insert numbers 1 through 10
" Or select column with Ctrl+V, then:
g<C-a>                   " increment each line by 1 more than previous
```
===
# Title: Align numbers at decimal point
# Category: Text Manipulation
# Tags: align, numbers, decimal, format
---
Use visual selection and substitute to align decimal numbers at their decimal points.

#### Example

```vim
" Select lines with numbers, then:
:'<,'>s/\(\d\+\)\.\(\d\+\)/\=printf("%6.2f", submatch(0))/
" Or use Align plugin:
:'<,'>Align \.
```
===
# Title: Handle common typos
# Category: Text Manipulation
# Tags: typos, abbreviations, correction, auto
---
Create abbreviations to automatically fix common typing mistakes.

#### Example

```vim
iab teh the
iab adn and
iab recieve receive
iab seperate separate
iab definately definitely
```
===
# Title: Filter text through external commands
# Category: Text Manipulation
# Tags: filter, external, commands, process
---
Use `!` to filter selected text through external programs for processing.

#### Example

```vim
:%!sort -u           " sort all lines, remove duplicates
!}sort               " sort from cursor to end of paragraph
" Visual mode: select lines, then:
!python script.py    " filter through Python script
!awk '{print $2}'    " extract second column
```
===
# Title: Word count methods
# Category: Text Manipulation
# Tags: count, words, statistics, analyze
---
Use `g Ctrl+g` for word count, or external commands for detailed statistics.

#### Example

```vim
g<C-g>              " show word count for buffer/selection
:w !wc              " count using external wc command
:%s/pattern//gn     " count pattern occurrences
" For live word count in statusline:
function! WordCount()
  return wordcount().words
endfunction
```
===
# Title: Work with CSV files
# Category: Text Manipulation
# Tags: csv, columns, data, tabular
---
Use CSV plugin commands to navigate and manipulate comma-separated data.

#### Example

```vim
" With CSV plugin:
:Csv 5              " highlight column 5
H, J, K, L          " navigate between cells
:Sort               " sort by column
:CC                 " copy column
:DC                 " delete column
" Convert to columns for viewing:
:%s/,/\t/g          " replace commas with tabs
```
===
# Title: Remove duplicate lines
# Category: Text Manipulation
# Tags: duplicate, unique, lines, clean
---
Use sort with unique flag or visual block operations to remove duplicate lines.

#### Example

```vim
:%!sort -u          " sort and remove duplicates
:sort u             " vim's built-in sort unique
" Or manually:
:g/^\(.*\)$\n\1$/d  " remove consecutive duplicates
```
===
# Title: Generate increasing numbers column
# Category: Text Manipulation
# Tags: numbers, increment, column, sequence, generate
---
Generate a column of increasing numbers using visual block mode and increment commands.

#### Example

```vim
" Method 1: Visual Incrementing script
Ctrl+V          " select column in visual block
:I              " replace selection with incremental numbers
:I 5            " increment by 5 instead of 1
:II             " increment with left padding

" Method 2: Manual approach
qa              " start recording macro
I1<Esc>         " insert 1 at beginning
j               " move down
<C-a>           " increment number
q               " stop recording
@a              " execute macro to continue sequence
```
===
# Title: Unique line removal
# Category: Text Manipulation
# Tags: unique, duplicate, remove, lines
---
Remove duplicate lines while keeping unique entries using sort and uniq operations.

#### Example

```vim
:%!sort | uniq       " sort and remove duplicates (external)
:sort u              " sort and remove duplicates (internal)
:%!uniq              " remove consecutive duplicates only
```
===
# Title: Transpose characters
# Category: Text Manipulation
# Tags: transpose, swap, characters, exchange
---
Swap adjacent characters or transpose text elements efficiently.

#### Example

```vim
xp              " transpose characters (delete and paste)

" For words: dawbP (delete word, back, paste)
daw             " delete a word  
b               " go back one word
P               " paste before cursor
```
===
# Title: Text alignment and padding
# Category: Text Manipulation
# Tags: align, pad, format, columns, spacing
---
Align text in columns and add padding for better formatting.

#### Example

```vim
" Align on specific character (e.g., =)
:'<,'>s/=/\t=/g         " add tab before =
:'<,'>!column -t -s $'\t'  " align columns

" Manual alignment
:%s/^/    /             " add 4 spaces to start of each line
:%s/$/    /             " add 4 spaces to end of each line
```
===
# Title: ROT13 encoding
# Category: Text Manipulation
# Tags: rot13, encoding, cipher, transform
---
Apply ROT13 cipher to selected text using `g?` operator or external command.

#### Example

```vim
g??         " ROT13 current line
g?ap        " ROT13 around paragraph
:'<,'>!tr 'A-Za-z' 'N-ZA-Mn-za-m'  " ROT13 using external tr
```
===
# Title: Binary number operations
# Category: Text Manipulation
# Tags: binary, numbers, conversion, base
---
Convert and manipulate binary numbers using expressions and external tools.

#### Example

```vim
" In insert mode, convert decimal to binary:
Ctrl+r =printf("%b", 42)<Enter>   " inserts 101010

" Convert binary to decimal:
Ctrl+r =str2nr("101010", 2)<Enter>  " inserts 42

" Format as hex:
Ctrl+r =printf("0x%x", 42)<Enter>   " inserts 0x2a
```
===
# Title: Text statistics
# Category: Text Manipulation
# Tags: statistics, analysis, count, metrics
---
Get detailed text statistics including character, word, and line counts.

#### Example

```vim
g<C-g>              " detailed stats for selection/buffer
:%s/word//gn        " count occurrences of 'word'
:%s/\w\+//gn        " count total words
:%s/.//gn           " count total characters
:%s/\n//gn          " count total lines
```
===
# Title: Increment/decrement numbers
# Category: Text Manipulation
# Tags: increment, decrement, numbers, math
---
Modify numbers in text using increment and decrement operations.

#### Example

```vim
Ctrl+a              " increment number under cursor
Ctrl+x              " decrement number under cursor
10<C-a>             " increment by 10
" In visual block mode:
g<C-a>              " increment each selected number progressively
g<C-x>              " decrement each selected number progressively
```
===
# Title: Comment and uncomment blocks
# Category: Text Manipulation
# Tags: comment, uncomment, code, blocks
---
Add or remove comment markers from blocks of code.

#### Example

```vim
" For line comments (e.g., //):
:'<,'>s/^/\/\/ /    " add comment
:'<,'>s/^\/\/ //    " remove comment

" For block comments:
:'<,'>s/^/\/* /     " add start comment
:'<,'>s/$/ *\//     " add end comment

" Using substitute with confirmation:
:%s/^/# /gc         " add # comments with confirmation
```
===
# Title: Duplicate lines or selections
# Category: Text Manipulation
# Tags: duplicate, copy, lines, repeat
---
Duplicate current line or selected text efficiently.

#### Example

```vim
yyp                 " duplicate current line (yank and paste)
"ayy"ap             " duplicate line using register a
:'<,'>co'<-1        " duplicate selected lines above
:'<,'>co'>          " duplicate selected lines below
:.,.+5co$           " copy lines to end of file
```
===
# Title: Undo and redo operations
# Category: Text Manipulation
# Tags: undo, redo, history
---
Use `u` to undo changes, `Ctrl+r` to redo undone changes, and `U` to undo all changes on current line.

#### Example

```vim
u      " undo last change
Ctrl+r " redo (undo the undo)
U      " undo all changes on current line
```
===
# Title: Put text from register
# Category: Text Manipulation
# Tags: put, paste, register
---
Use `p` to put (paste) text after cursor and `P` to put text before cursor.

#### Example

```vim
p  " put text after cursor
P  " put text before cursor
"ap " put from register 'a' after cursor
```
===
# Title: Replace mode operations
# Category: Text Manipulation
# Tags: replace, mode, overwrite
---
Use `R` to enter Replace mode where typed characters overwrite existing text. Use `r{char}` to replace single character.

#### Example

```vim
R    " enter Replace mode
ra   " replace character under cursor with 'a'
3rx  " replace 3 characters with 'x'
```
===
# Title: Delete character operations
# Category: Text Manipulation
# Tags: delete, character, cursor
---
Use `x` to delete character under cursor and `X` to delete character before cursor.

#### Example

```vim
x   " delete character under cursor
X   " delete character before cursor
5x  " delete 5 characters forward
```
===
# Title: Create incremental sequence with g Ctrl+a
# Category: Text Manipulation
# Tags: increment, sequence, numbers, visual, ctrl-a
---
Use `g Ctrl+a` in visual block mode to create incremental number sequences instead of incrementing all numbers by the same amount.

#### Example

```vim
" Select multiple lines with numbers, then:
g<C-a>    " creates 1,2,3,4... sequence
<C-a>     " would increment all by 1
```
===