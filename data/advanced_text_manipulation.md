# Title: Advanced text objects for precise selections
# Category: Text Objects
# Tags: textobject, selection, precise, custom, advanced
---
Use advanced text object variations for more precise text selection and manipulation.

#### Example

```vim
" Next/Last variations
in(     " inside next (
il(     " inside last (
an)     " around next )
al)     " around last )

" Multi-line text objects
ap      " around paragraph
ip      " inside paragraph
as      " around sentence
is      " inside sentence

" Advanced combinations
va"i'   " select around " then inside '
ci"<Esc>va'   " change inside " then select around '

" Custom text object for function calls
vif     " inside function (with treesitter)
vaf     " around function (with treesitter)
vic     " inside class (with treesitter)
vac     " around class (with treesitter)
```
***
# Title: Expression register for calculations
# Category: Registers
# Tags: register, expression, calculation, math, formula
---
Use the expression register `"=` to perform calculations and dynamic text insertion.

#### Example

```vim
" In insert mode:
<C-r>=42*7<CR>          " inserts 294
<C-r>=strftime('%Y-%m-%d')<CR>  " inserts current date
<C-r>=line('.')<CR>     " inserts current line number
<C-r>=expand('%:t')<CR> " inserts filename

" In command mode:
:echo @=                " show expression register content
:let @= = '2+2'         " set expression register
<C-r>=2+2<CR>          " calculate and insert result

" Complex expressions:
<C-r>=printf('Line %d: %s', line('.'), getline('.'))<CR>
<C-r>=system('date +%s')<CR>  " unix timestamp
<C-r>=repeat('-', 50)<CR>     " insert 50 dashes
```
***
# Title: Zero-width assertions in search patterns
# Category: Advanced Search
# Tags: regex, assertion, lookahead, lookbehind, pattern
---
Use zero-width assertions (`\@=`, `\@!`, `\@<=`, `\@<!`) for complex search patterns that match without consuming characters.

#### Example

```vim
" Positive lookahead (\@=)
/foo\@=bar          " match 'foo' only if followed by 'bar'
/\w\+\@=ing         " match word ending with 'ing'

" Negative lookahead (\@!)
/foo\@!bar          " match 'foo' only if NOT followed by 'bar'
/^\w\+\@!\d         " match line starting with non-word then digit

" Positive lookbehind (\@<=)
/\@<=foo            " match 'foo' only if preceded by pattern
/\d\@<=px           " match 'px' only after digits

" Negative lookbehind (\@<!)
/\@<!foo            " match 'foo' only if NOT preceded by pattern
/\w\@<!-            " match '-' not preceded by word character

" Complex combinations
/\@<=\d\+\.\@=      " match digits between word and dot
/\(function\)\@<=\w\+\@=(   " function names
```
***
# Title: Advanced register chaining and manipulation
# Category: Registers
# Tags: register, chain, manipulation, sequence, advanced
---
Chain register operations and use registers creatively for complex text manipulation workflows.

#### Example

```vim
" Chain multiple register operations
"ayiw"byiw"cp       " yank word to 'a', yank to 'b', paste 'c'
"Ayiw               " append to register 'a' (uppercase)

" Register arithmetic
:let @a = @a + 1    " increment number in register 'a'
:let @b = @a . @b   " concatenate registers

" Swap register contents
:let tmp = @a | let @a = @b | let @b = tmp

" Use registers in substitution
:%s/old/@a/g        " replace 'old' with register 'a' content
:%s/\(\w\+\)/\=@a/g " replace each word with register 'a'

" Complex register macros
qa                  " start recording macro 'a'
I"<Esc>A"<Esc>j     " wrap line in quotes, go to next
q                   " stop recording
@a                  " execute macro
@@                  " repeat last macro
5@a                 " execute macro 5 times
```
***