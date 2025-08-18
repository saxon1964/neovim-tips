Toggle case of character
# Title: Toggle case of character
# Category: Text Manipulation
# Tags: case, toggle, character
---
Use `~` to toggle case of character under cursor.

#### Example

```vim
~  " toggle character case
```
===

Lowercase/uppercase current line
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

Uppercase current word
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

Sort paragraph
# Title: Sort paragraph
# Category: Text Manipulation
# Tags: sort, paragraph, formatting
---
Use `!}sort` to sort the next paragraph.

#### Example

```vim
!}sort  " sort next paragraph
```
===

Sort with remove duplicates
# Title: Sort with remove duplicates
# Category: Text Manipulation
# Tags: sort, duplicates, unique
---
Use `:sort u` to sort selected lines and remove duplicates.

#### Example

```vim
:sort u  " sort and remove duplicates
```
===

Format paragraph
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

Replace newlines with spaces
# Title: Replace newlines with spaces
# Category: Text Manipulation
# Tags: newlines, replace, spaces
---
Use `:%s/\n/ /g` to replace all newlines with spaces.

#### Example

```vim
:%s/\n/ /g  " replace newlines with spaces
```
===

Remove trailing whitespace
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

Delete blank lines
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

Delete non-matching lines
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

Insert numbering
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

Convert tabs to spaces
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

Join lines with custom separator
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

Reverse lines
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

Insert column of text
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

Generate increasing numbers
# Title: Generate increasing numbers
# Category: Text Manipulation
# Tags: numbers, sequence, increment, column
---
Use visual block to select numbers, then `:I` to increment by 1, or `:I #` to increment by specified amount with visincr plugin.

#### Example

```vim
" Select column of numbers with Ctrl+V
:I      " increment selected numbers by 1
:I 5    " increment selected numbers by 5
:II     " increment with left padding
```
===

Insert line numbers
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

Align numbers at decimal point
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

Handle common typos
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

Filter text through external commands
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

Word count methods
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

Work with CSV files
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

Remove duplicate lines
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

Generate increasing numbers column
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

Unique line removal
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

Transpose characters
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

Text alignment and padding
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
