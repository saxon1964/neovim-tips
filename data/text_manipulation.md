Use `!{motion}{command}` to filter text through external commands for text processing.

```vim
!}sort              " sort paragraph (motion: })
:'<,'>!sort         " sort visual selection
!Gtidy -iq -xml     " format XML until end of file
:%!python3 -m json.tool  " format entire file as JSON
:10,20!nl           " add line numbers to lines 10-20
```
***
# Title: Lowercase/uppercase current line
# Category: Text Manipulation
# Tags: case, line, transform
---
Use `gqap` to format/wrap a paragraph according to textwidth.

```vim
gqap  " format around paragraph
```
***
# Title: Remove trailing whitespace
# Category: Text Manipulation
# Tags: whitespace, trailing, clean
---
Use `:v/pattern/d` to delete all lines that do NOT match the pattern.

```vim
:v/TODO/d  " delete lines that don't contain 'TODO'
```
***
# Title: Insert numbering
# Category: Text Manipulation
# Tags: numbering, sequence, insert, auto
---
Use `:retab` to convert tabs to spaces using current tabstop setting, or `:set expandtab | retab` to convert and set future tabs as spaces.

```vim
:retab              " convert tabs to spaces
:set expandtab | retab  " convert and set expandtab
```
***
# Title: Join lines with custom separator
# Category: Text Manipulation
# Tags: join, separator, custom, lines
---
Use visual selection and substitute to align decimal numbers at their decimal points.

```vim
" Select lines with numbers, then:
:'<,'>s/\(\d\+\)\.\(\d\+\)/\=printf("%6.2f", submatch(0))/
" Or use Align plugin:
:'<,'>Align \.
```
***
# Title: Handle common typos
# Category: Text Manipulation
# Tags: typos, abbreviations, correction, auto
---
Create abbreviations to automatically fix common typing mistakes.

```vim
iab teh the
iab adn and
iab recieve receive
iab seperate separate
iab definately definitely
```
***
# Title: Word count methods
# Category: Text Manipulation
# Tags: count, words, statistics, analyze
---
Use `g Ctrl+g` for word count, or external commands for detailed statistics.

```vim
g<C-g>              " show word count for buffer/selection
:w !wc              " count using external wc command
:%s/pattern//gn     " count pattern occurrences
" For live word count in statusline:
function! WordCount()
  return wordcount().words
endfunction
```
***
# Title: Work with CSV files
# Category: Text Manipulation
# Tags: csv, columns, data, tabular
---
Use CSV plugin commands to navigate and manipulate comma-separated data.

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
***
# Title: Remove duplicate lines
# Category: Text Manipulation
# Tags: duplicate, unique, lines, clean
---
Use sort with unique flag or visual block operations to remove duplicate lines.

```vim
:%!sort -u          " sort and remove duplicates
:sort u             " vim's built-in sort unique
" Or manually:
:g/^\(.*\)$\n\1$/d  " remove consecutive duplicates
```
***
# Title: Generate increasing numbers column
# Category: Text Manipulation
# Tags: numbers, increment, column, sequence, generate
---
Generate a column of increasing numbers using visual block mode and increment commands.

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
***
# Title: Transpose characters
# Category: Text Manipulation
# Tags: transpose, swap, characters, exchange
---
Swap adjacent characters or transpose text elements efficiently.

```vim
xp              " transpose characters (delete and paste)

" For words: dawbP (delete word, back, paste)
daw             " delete a word
b               " go back one word
P               " paste before cursor
```
***
# Title: Text alignment and padding
# Category: Text Manipulation
# Tags: align, pad, format, columns, spacing
---
Align text in columns and add padding for better formatting.

```vim
" Align on specific character (e.g., =)
:'<,'>s/=/\t=/g         " add tab before =
:'<,'>!column -t -s $'\t'  " align columns

" Manual alignment
:%s/^/    /             " add 4 spaces to start of each line
:%s/$/    /             " add 4 spaces to end of each line
```
***
# Title: ROT13 encoding
# Category: Text Manipulation
# Tags: rot13, encoding, cipher, transform
---
Apply ROT13 cipher to selected text using `g?` operator or external command.

```vim
g??         " ROT13 current line
g?ap        " ROT13 around paragraph
:'<,'>!tr 'A-Za-z' 'N-ZA-Mn-za-m'  " ROT13 using external tr
```
***
# Title: Binary number operations
# Category: Text Manipulation
# Tags: binary, numbers, conversion, base
---
Convert and manipulate binary numbers using expressions and external tools.

```vim
" In insert mode, convert decimal to binary:
Ctrl+r =printf("%b", 42)<Enter>   " inserts 101010

" Convert binary to decimal:
Ctrl+r =str2nr("101010", 2)<Enter>  " inserts 42

" Format as hex:
Ctrl+r =printf("0x%x", 42)<Enter>   " inserts 0x2a
```
***
# Title: Text statistics
# Category: Text Manipulation
# Tags: statistics, analysis, count, metrics
---
Get detailed text statistics including character, word, and line counts.

```vim
g<C-g>              " detailed stats for selection/buffer
:%s/word//gn        " count occurrences of 'word'
:%s/\w\+//gn        " count total words
:%s/.//gn           " count total characters
:%s/\n//gn          " count total lines
```
***
# Title: Increment/decrement numbers
# Category: Text Manipulation
# Tags: increment, decrement, numbers, math
---
Modify numbers in text using increment and decrement operations.

```vim
Ctrl+a              " increment number under cursor
Ctrl+x              " decrement number under cursor
10<C-a>             " increment by 10
" In visual block mode:
g<C-a>              " increment each selected number progressively
g<C-x>              " decrement each selected number progressively
```
***
# Title: Comment and uncomment blocks
# Category: Text Manipulation
# Tags: comment, uncomment, code, blocks
---
Duplicate current line or selected text efficiently.

```vim
yyp                 " duplicate current line (yank and paste)
"ayy"ap             " duplicate line using register a
:'<,'>co'<-1        " duplicate selected lines above
:'<,'>co'>          " duplicate selected lines below
:.,.+5co$           " copy lines to end of file
```
***
# Title: Undo and redo operations
# Category: Text Manipulation
# Tags: undo, redo, history
---
Use `R` to enter Replace mode where typed characters overwrite existing text. Use `r{char}` to replace single character.

```vim
R    " enter Replace mode
ra   " replace character under cursor with 'a'
3rx  " replace 3 characters with 'x'
```
***
# Title: Delete character operations
# Category: Text Manipulation
# Tags: delete, character, cursor
---
Use `x` to delete character under cursor and `X` to delete character before cursor.

```vim
x   " delete character under cursor
X   " delete character before cursor
5x  " delete 5 characters forward
```
***
# Title: Create incremental sequence with g Ctrl+a
# Category: Text Manipulation
# Tags: increment, sequence, numbers, visual, ctrl-a
---
Use `g Ctrl+a` in visual block mode to create incremental number sequences instead of incrementing all numbers by the same amount.

```vim
" Select multiple lines with numbers, then:
g<C-a>    " creates 1,2,3,4... sequence
<C-a>     " would increment all by 1
```
***
# Title: Uppercase and lowercase
# Category: Text Manupulation
# Tags: uppercase, lowercase
---
Here are some practical examples how to uppercase/lowercase various text parts:

**Normal mode (no selection needed)**

_Word-based_

```
gUiw    " UPPERCASE word under cursor
guiw    " lowercase word under cursor
g~iw    " toggle case of word
````

_From cursor_

```
gUe     " uppercase to end of word
gue     " lowercase to end of word
g~e     " toggle case to end of word
```

_Line-based_

```
gUU     " UPPERCASE entire line
guu     " lowercase entire line
g~~     " toggle case of entire line
```

**Visual mode (most intuitive)**

_Select text:_

```
v       " character-wise
V       " line-wise
<C-v>   " block-wise
```

_Then apply:_

```
U       " UPPERCASE selection
u       " lowercase selection
~       " toggle case
```

Works beautifully with `viw`, `vip`, `va{`, etc.

Text objects you’ll use 99% of the time

```
iw	            " inner word
aw	            " a word (includes punctuation)
ip	            " inner paragraph
i"	            " inside quotes
i( / i[ / i{	" inside brackets
```

More examples:

```
gUi"        " UPPERCASE text inside quotes
gU$         " uppercase to end of line
gu0         " lowercase to start of line
g~ap        " toggle case of paragraph
```

Provide keyboard mappings for most used commands:

```
vim.keymap.set("n", "<leader>u", "gUiw", { desc = "Uppercase word" })
vim.keymap.set("n", "<leader>l", "guiw", { desc = "Lowercase word" })
vim.keymap.set("n", "<leader>~", "g~iw", { desc = "Toggle case word" })
```
***
