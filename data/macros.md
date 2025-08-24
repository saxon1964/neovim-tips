# Title: Execute macro
# Category: Macros
# Tags: macro, execute, replay
---
Use `@{letter}` to execute macro stored in register {letter}, or `@@` to repeat the last executed macro.

#### Example

```vim
@a  " execute macro 'a'
@@  " repeat last macro
```
===
# Title: Run macro over visual selection
# Category: Macros
# Tags: macro, visual, selection
---
Use `:'<,'>normal @q` to run macro q over visual selection.

#### Example

```vim
:'<,'>normal @q  " run macro q on selection
```
===
# Title: View macro contents
# Category: Macros
# Tags: macro, view, register, debug
---
Use `:reg` to view all registers including macros, or `:reg a` to view specific macro in register 'a'.

#### Example

```vim
:reg     " view all registers
:reg a   " view macro in register 'a'
```
===
# Title: Edit macro in command line
# Category: Macros
# Tags: macro, edit, modify, command
---
Use `:let @a='` then `Ctrl+R Ctrl+R a` to paste macro contents for editing, then close with `'`.

#### Example

```vim
:let @a='<Ctrl+R><Ctrl+R>a'  " edit macro 'a' inline
```
===
# Title: Save macro in vimrc
# Category: Macros
# Tags: macro, save, persistent, vimrc
---
Use `let @a='macro_contents'` in vimrc to make macros persistent across Vim sessions.

#### Example

```vim
let @a='ddp'  " save line swap macro permanently
```
===
# Title: Record recursive macro by including the self-reference
# Category: Macros
# Tags: macro, recursive, loop, automation
---
Create recursive macros by including `@q` (self-reference) within the macro recording to process entire file automatically.

#### Example

```vim
qqq         " clear register q
qq          " start recording macro q
" ... your editing commands ...
@q          " recursive call to self
q           " stop recording
@q          " execute recursive macro
```
===
# Title: Run macro on multiple files
# Category: Macros
# Tags: macro, files, multiple, batch
---
Use `:argdo normal @q` to run macro q on all files in argument list, or `:bufdo normal @q` for all buffers.

#### Example

```vim
:args *.txt         " load all txt files
:argdo normal @q    " run macro q on all files
:argdo update       " save all changed files
```
===
# Title: Record recursive macro that calls itself until a condition is met
# Category: Macros
# Tags: macro, recursive, loop, repeat
---
Create a recursive macro that calls itself for repeated operations until a condition is met.

#### Example

```vim
" Record recursive macro in register 'a'
qa              " start recording
/pattern<CR>    " search for pattern (will fail when no more matches)
n               " go to next match
@a              " call itself recursively
q               " stop recording

" Execute to process all matches
@a
```
===
# Title: Macro for data transformation
# Category: Macros
# Tags: macro, transform, data, format
---
Use macros to transform structured data formats efficiently.

#### Example

```vim
" Transform tab-separated to Python dict format
qa              " start recording macro 'a'
I"<Esc>         " insert quote at beginning
f<Tab>          " find tab character
r:              " replace with colon
a": "<Esc>      " append quote-colon-quote
A",<Esc>        " append comma at end
j0              " move to next line, beginning
q               " stop recording

" Apply to multiple lines
10@a            " run macro 'a' 10 times
```
===
# Title: Quick macro shortcuts
# Category: Macros
# Tags: macro, shortcut, mapping, space
---
Set up convenient mappings for macro execution and recording.

#### Example

```vim
" Map space to execute last macro
nnoremap <Space> @@

" Map specific keys for common macro registers
nnoremap <leader>1 @q
nnoremap <leader>2 @w
nnoremap <leader>3 @e

" Map for visual selection macro execution
vnoremap <leader>m :normal @q<CR>
```
===
# Title: Make existing macro recursive
# Category: Macros
# Tags: macro, recursive, modify, qQ
---
Convert an existing macro to recursive by appending the macro call to itself using `qQ@qq`.

#### Example

```vim
" After recording macro @q normally:
qQ@qq   " q=start recording to Q, Q=append to q, @q=call q, q=stop
" Now @q is recursive and will loop until end of file
```
===
