# Title: Basic variable assignment and types
# Category: Vim Script
# Tags: variable, let, type, assignment, scope
---
Use `:let` to assign variables with different scopes: `g:` (global), `l:` (local), `s:` (script), `a:` (argument), `v:` (vim).

```vim
:let g:my_var = 42           " global variable
:let l:local_var = "hello"   " local variable
:let s:script_var = []       " script-local variable
:let b:buffer_var = {}       " buffer-local variable
:let w:window_var = 3.14     " window-local variable
```
===
# Title: String operations and concatenation
# Category: Vim Script
# Tags: string, concatenation, operation, manipulation
---
Use `.` for string concatenation, `len()` for length, `split()` and `join()` for array operations.

```vim
:let name = "Neo" . "vim"        " concatenation
:let length = len("hello")       " string length
:let words = split("a,b,c", ",") " split string
:let text = join(['a','b'], '-') " join array
:echo toupper("hello")           " HELLO
:echo tolower("WORLD")           " world
```
===
# Title: Conditional statements and logic
# Category: Vim Script
# Tags: if, else, condition, logic, comparison
---
Use `if`, `elseif`, `else`, `endif` for conditional logic with comparison operators.

```vim
:let score = 85
:if score >= 90
  echo "Excellent"
:elseif score >= 70
  echo "Good"
:else
  echo "Needs improvement"
:endif

" Comparison operators: == != > < >= <= =~ !~
```
===
# Title: Loops and iteration
# Category: Vim Script
# Tags: for, while, loop, iteration, range
---
Use `for` loops for iteration over lists/ranges, `while` for conditional loops.

```vim
" For loop over range
:for i in range(1, 5)
  echo i
:endfor

" For loop over list
:for item in ['a', 'b', 'c']
  echo item
:endfor

" While loop
:let i = 0
:while i < 3
  echo i
  let i += 1
:endwhile
```
===
# Title: Function definition and calling
# Category: Vim Script
# Tags: function, define, call, return, parameter
---
Define functions with `function` keyword, call with `:call` or directly in expressions.

```vim
function! MyFunction(param1, param2)
  let result = a:param1 + a:param2
  return result
endfunction

:call MyFunction(5, 3)           " call function
:echo MyFunction(10, 20)         " use in expression
:let value = MyFunction(1, 2)    " assign result
```
===
# Title: List and dictionary operations
# Category: Vim Script
# Tags: list, dictionary, array, hash, data-structure
---
Work with lists `[]` and dictionaries `{}` using built-in functions and operators.

```vim
" Lists
:let mylist = ['apple', 'banana', 'cherry']
:let mylist += ['date']          " add item
:let first = mylist[0]           " access by index
:call add(mylist, 'elderberry')  " append item
:call remove(mylist, 1)          " remove by index

" Dictionaries
:let mydict = {'name': 'vim', 'version': 8}
:let mydict.type = 'editor'      " add key
:let name = mydict['name']       " access value
:call remove(mydict, 'version')  " remove key
```
===
# Title: Error handling with try-catch
# Category: Vim Script
# Tags: try, catch, finally, error, exception
---
Handle errors gracefully using try-catch-finally blocks.

```vim
:try
  " Potentially failing code
  let result = some_risky_function()
:catch /^Error:/
  " Handle specific error pattern
  echo "Caught error: " . v:exception
:catch /.*/
  " Handle any other error
  echo "Unknown error occurred"
:finally
  " Always execute this
  echo "Cleanup code"
:endtry
```
===
# Title: Regular expressions in Vim script
# Category: Vim Script
# Tags: regex, pattern, match, substitute, search
---
Use `=~` and `!~` operators for pattern matching, `substitute()` for replacements.

```vim
:let text = "Hello World 123"
:if text =~ '\d\+'              " contains digits
  echo "Has numbers"
:endif

:let clean = substitute(text, '\d\+', 'XXX', 'g')  " replace digits
:let matches = matchlist(text, '\(\w\+\) \(\w\+\)')  " capture groups
:echo match(text, 'World')      " find position
```
===
# Title: File and buffer operations
# Category: Vim Script
# Tags: file, buffer, read, write, operation
---
Read/write files and manipulate buffers programmatically.

```vim
" File operations
:let lines = readfile('config.txt')    " read file to list
:call writefile(['line1', 'line2'], 'output.txt')  " write list to file

" Buffer operations
:let bufnr = bufnr('%')                " current buffer number
:let bufname = bufname(bufnr)          " buffer name
:let lines = getbufline(bufnr, 1, '$') " get all lines
:call setbufline(bufnr, 1, 'new first line')  " set line
```
===
# Title: Autocommand creation in script
# Category: Vim Script
# Tags: autocmd, autocommand, event, group, script
---
Create autocommands programmatically with proper grouping and cleanup.

```vim
" Create autocommand group
:augroup MyGroup
  :autocmd!  " clear existing autocommands in group
  :autocmd BufRead *.py setlocal tabstop=4
  :autocmd BufWritePre * call TrimWhitespace()
:augroup END

" Function called by autocommand
function! TrimWhitespace()
  %s/\s\+$//e
endfunction
```
===
# Title: User command definition
# Category: Vim Script
# Tags: command, user-command, define, custom
---
Create custom user commands with parameters and completion.

```vim
" Simple command
:command! Hello echo "Hello World"

" Command with arguments
:command! -nargs=1 Greet echo "Hello " . <args>

" Command with range
:command! -range LineCount echo <line2> - <line1> + 1

" Command with completion
:command! -nargs=1 -complete=file EditConfig edit ~/.config/<args>
```
===
# Title: Mappings in Vim script
# Category: Vim Script
# Tags: mapping, keymap, bind, shortcut, script
---
Create key mappings programmatically with different modes and options.

```vim
" Normal mode mapping
:nnoremap <leader>w :write<CR>

" Insert mode mapping
:inoremap jk <Esc>

" Visual mode mapping
:vnoremap <leader>c "+y

" Mapping with script-local function
:nnoremap <leader>f :call <SID>MyFunction()<CR>

function! s:MyFunction()
  echo "Script-local function called"
endfunction
```
===
# Title: Option manipulation
# Category: Vim Script
# Tags: option, set, setlocal, global, buffer
---
Get and set Vim options programmatically using `&` syntax.

```vim
" Get option value
:let current_ts = &tabstop
:let buf_ft = &l:filetype        " buffer-local option

" Set option value
:let &tabstop = 4
:let &l:number = 1               " buffer-local
:let &g:background = 'dark'      " global

" Toggle boolean option
:let &wrap = !&wrap
```
===
# Title: String formatting and printf
# Category: Vim Script
# Tags: string, format, printf, sprintf, output
---
Format strings using `printf()` and `string()` functions.

```vim
:let name = "Neovim"
:let version = 0.8
:let message = printf("Welcome to %s v%.1f", name, version)

" Number formatting
:echo printf("%d", 42)           " integer
:echo printf("%04d", 7)          " zero-padded: 0007
:echo printf("%.2f", 3.14159)    " float: 3.14
:echo printf("%s", string([1,2,3]))  " convert to string
```
===
# Title: System command execution
# Category: Vim Script
# Tags: system, command, execute, shell, external
---
Execute system commands and capture output using `system()` and related functions.

```vim
" Execute command and get output
:let output = system('ls -la')
:let files = split(system('find . -name "*.vim"'), '\n')

" Check command success
:let result = system('grep pattern file.txt')
:if v:shell_error == 0
  echo "Command succeeded"
:else
  echo "Command failed"
:endif
```
===
# Title: Lua integration in Vim script
# Category: Vim Script
# Tags: lua, integration, execute, call, hybrid
---
Execute Lua code from Vim script and pass data between them.

```vim
" Execute Lua code
:lua print("Hello from Lua")
:lua vim.opt.number = true

" Call Lua from Vim script
:let result = luaeval('2 + 3')
:let data = luaeval('vim.fn.getbufinfo()')

" Execute Lua file
:luafile ~/.config/nvim/lua/config.lua

" Vim script function called from Lua
function! VimFunction(arg)
  return "Vim received: " . a:arg
endfunction
```
===
# Title: Script sourcing and modules
# Category: Vim Script
# Tags: source, module, include, script, organization
---
Source other scripts and create modular code organization.

```vim
" Source another script
:source ~/.config/nvim/helpers.vim
:runtime! plugin/**/*.vim        " source all plugins

" Script-local variables and functions
let s:script_var = "private"

function! s:ScriptFunction()
  return "Only accessible within this script"
endfunction

" Export public interface
function! MyModule#PublicFunction()
  return s:ScriptFunction()
endfunction
```
===
# Title: Debugging Vim scripts
# Category: Vim Script
# Tags: debug, echo, echom, verbose, profile
---
Debug Vim scripts using various techniques and built-in tools.

```vim
" Basic debugging
:echo "Debug: variable = " . variable
:echom "Message saved to :messages"     " persistent message

" Conditional debugging
if exists('g:debug_mode') && g:debug_mode
  echom "Debug info: " . string(data)
endif

" Verbose execution
:verbose source script.vim           " show sourcing info
:set verbose=9                       " detailed execution info

" Profile script execution
:profile start profile.log
:profile func *                      " profile all functions
:source slow_script.vim
:profile pause
```
===
# Title: Built-in function usage
# Category: Vim Script
# Tags: builtin, function, vim, utility, helper
---
Utilize Vim's extensive built-in function library for common tasks.

```vim
" String functions
:echo strwidth("text")          " display width
:echo stridx("hello", "ll")     " find substring index
:echo repeat("*", 10)           " repeat string

" List functions
:echo max([1, 5, 3, 2])         " maximum value
:echo sort(['c', 'a', 'b'])     " sort list
:echo uniq(sort([1, 2, 2, 3]))  " unique sorted values

" File functions
:echo expand('%:p')             " full path of current file
:echo fnamemodify('file.txt', ':r')  " remove extension
:echo glob('*.vim')             " glob pattern matching
```
===
# Title: Event handling and callbacks
# Category: Vim Script
# Tags: event, callback, timer, async, handler
---
Handle events and create callbacks using timers and autocommands.

```vim
" Timer callback
function! TimerCallback(timer_id)
  echo "Timer " . a:timer_id . " fired!"
endfunction

:let timer_id = timer_start(1000, 'TimerCallback')      " 1 second
:let repeat_timer = timer_start(500, 'TimerCallback', {'repeat': 5})

" Autocommand with function callback
function! OnBufEnter()
  echo "Entered buffer: " . bufname('%')
endfunction

:autocmd BufEnter * call OnBufEnter()
```
===