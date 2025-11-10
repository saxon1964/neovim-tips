# Title: Get file type and encoding
# Category: Functions
# Tags: getftype, getfperm, file, info
---
Use `getftype()` to determine file type and `getfperm()` to get file permissions for the current or specified file.

```vim
:echo getftype(expand('%'))     " file type (file, dir, link, etc.)
:echo getfperm(expand('%'))     " file permissions (rwxrwxrwx)
:echo getfsize(expand('%'))     " file size in bytes
```

Or:

```lua
print(vim.fn.getftype(vim.fn.expand('%')))
print(vim.fn.getfperm(vim.fn.expand('%')))
print(vim.fn.getfsize(vim.fn.expand('%')))
```
***
# Title: String manipulation functions
# Category: Functions
# Tags: substitute, matchstr, split, string
---
Use `substitute()`, `matchstr()`, and `split()` functions for powerful string manipulation without changing buffers.

```vim
:echo substitute("hello world", "world", "vim", "g")  " hello vim
:echo matchstr("file.txt", '\\.\\w\\+$')             " .txt
:echo split("a,b,c", ",")                            " ['a', 'b', 'c']
```

Or:

```lua
print(vim.fn.substitute("hello world", "world", "vim", "g"))
print(vim.fn.matchstr("file.txt", '\\.\\w\\+$'))
print(vim.fn.split("a,b,c", ","))
```
***
# Title: Buffer and window information
# Category: Functions
# Tags: bufnr, winnr, tabpagenr, info
---
Use `bufnr()`, `winnr()`, `tabpagenr()` to get current buffer, window, and tab numbers for scripting.

```vim
:echo bufnr('%')        " current buffer number
:echo winnr()           " current window number
:echo tabpagenr()       " current tab number
:echo winnr('$')        " total number of windows
```

Or:

```lua
print(vim.fn.bufnr('%'))
print(vim.fn.winnr('%'))
print(vim.fn.tabpagenr('%'))
print(vim.fn.winnr('%'))
```
***
# Title: Path manipulation functions
# Category: Functions
# Tags: fnamemodify, resolve, simplify, path
---
Use `fnamemodify()` to manipulate file paths and `resolve()` to resolve symbolic links and shortcuts.

```vim
:echo fnamemodify(expand('%'), ':p:h')     " full directory path
:echo fnamemodify(expand('%'), ':t:r')     " filename without extension
:echo resolve(expand('%'))                 " resolve symlinks
:echo simplify('../path/./file')           " normalize path
```

Or:

```lua
print(vim.fn.fnamemodify(vim.fn.expand('%'), ':p:h'))
print(vim.fn.fnamemodify(vim.fn.expand('%'), ':t:r'))
print(vim.fn.resolve(vim.fn.expand('%')))
print(vim.fn.simplify('../path/./file'))
```
***
# Title: Search and match functions
# Category: Functions
# Tags: search, searchpos, match, pattern
---
Use `search()`, `searchpos()`, and `match()` functions for programmatic searching without moving cursor.

```vim
:echo search('pattern')                    " find pattern, return line number
:echo searchpos('pattern')                 " return [line, column]
:echo match('hello world', 'wor')          " find position in string (6)
:echo matchend('hello world', 'wor')       " end position (9)
```

Or:

```lua
print(vim.fn.search('pattern'))
print(vim.fn.searchpos('pattern'))
print(vim.fn.match('hello world', 'wor'))
print(vim.fn.matchend('hello world', 'wor'))
```
***
# Title: Line and column functions
# Category: Functions
# Tags: line, col, getline, setline
---
Use `line()`, `col()`, `getline()`, `setline()` for precise cursor positioning and line manipulation.

```vim
:echo line('.')         " current line number
:echo col('.')          " current column number
:echo getline('.')      " current line text
:call setline('.', 'new text')  " replace current line
```

Or:

```lua
print(vim.fn.line('.'))
print(vim.fn.col('.'))
print(vim.fn.getline('.'))
vim.fn.setline('.', 'new text')
```
***
# Title: Date and time functions
# Category: Functions
# Tags: strftime, localtime, getftime, date
---
Use `strftime()` and `localtime()` for date/time manipulation, and `getftime()` for file timestamps.

```vim
:echo strftime('%Y-%m-%d %H:%M:%S')       " current date/time
:echo strftime('%Y-%m-%d', localtime())   " current date
:echo getftime(expand('%'))               " file modification time
:put =strftime('%Y-%m-%d')                " insert current date
```

Or:

```lua
print(vim.fn.strftime('%Y-%m-%d %H:%M:%S'))
print(vim.fn.strftime('%Y-%m-%d', vim.fn.localtime()))
print(vim.fn.getftime('%Y-%m-%d', vim.fn.expand('%')))
vim.api.nvim_put({os.date('%Y-%m-%d')}, 'c', true, true)
```
***
# Title: System and environment functions
# Category: Functions
# Tags: system, systemlist, environ, getenv
---
Use `system()` and `systemlist()` to execute shell commands and `getenv()` to access environment variables.

```vim
:echo system('date')                      " execute shell command
:echo systemlist('ls -la')               " return as list
:echo getenv('HOME')                      " get environment variable
:echo exists('$EDITOR')                  " check if env var exists
```

Or:

```lua
print(vim.fn.system('date'))
print(vim.fn.systemlist('ls -la'))
print(vim.fn.geten('HOME'))
print(vim.fn.exists('$EDITOR'))
```
***
# Title: List and dictionary functions
# Category: Functions
# Tags: len, empty, has_key, keys, values
---
Use `len()`, `empty()`, `has_key()`, `keys()`, `values()` for working with lists and dictionaries.

```vim
:let mylist = [1, 2, 3]
:echo len(mylist)                         " length: 3
:echo empty(mylist)                       " false (0)
:let mydict = {'a': 1, 'b': 2}
:echo has_key(mydict, 'a')               " true (1)
:echo keys(mydict)                        " ['a', 'b']
```

Or:

```lua
local mylist = {1, 2, 3}
print(#mylist)
print(vim.tbl_isempty(mylist))
local mydict = {a = 1, b = 2}
print(mydict.a ~= nil)
print(vim.inspect(vim.tbl_keys(mydict)))
```
***
# Title: Type checking functions
# Category: Functions
# Tags: type, islocked, exists, function
---
Use `type()`, `islocked()`, and `exists()` functions to check variable types and existence.

```vim
:echo type(42)                   " 0 (Number)
:echo type("string")             " 1 (String)  
:echo type([])                   " 3 (List)
:echo type({})                   " 4 (Dictionary)
:echo exists('g:my_var')         " check if variable exists
```

Or:

```lua
print(vim.fn.type(42))
print(vim.fn.type("string"))
print(vim.fn.type([]))
print(vim.fn.type({}))
print(vim.fn.exists('g:my_var'))
```
***
# Title: Mathematical functions
# Category: Functions
# Tags: abs, pow, sqrt, sin, cos, math
---
Use built-in math functions like `abs()`, `pow()`, `sqrt()`, `sin()`, `cos()` for calculations in vim script.

```vim
:echo abs(-5)                    " absolute value: 5
:echo pow(2, 3)                  " 2 to power of 3: 8
:echo sqrt(16)                   " square root: 4.0
:echo sin(3.14159/2)             " sine: ~1.0
:echo round(3.7)                 " round: 4
```

Or:

```lua
print(vim.fn.abs(-5))
print(vim.fn.pow(2, 3))
print(vim.fn.sqrt(16))
print(vim.fn.sin(3.14159/2))
print(vim.fn.round(3.7))
```
***
# Title: Buffer content functions
# Category: Functions
# Tags: getbufline, setbufline, append, delete
---
Use `getbufline()` and `setbufline()` to read and modify buffer content without switching to the buffer.

```vim
:echo getbufline(1, 1, 10)              " get lines 1-10 from buffer 1
:call setbufline(2, 1, 'new first line') " set line 1 in buffer 2
:call append(line('.'), 'new line')      " append after current line
:call delete(line('.'))                  " delete current line
```

Or:

```lua
print(vim.fn.getbufline(1, 1, 10))
vim.fn.setbufline(2, 1, 'new first line')
vim.fn.append(vim.fn.line('.'), 'new line')
vim.fn.delete(vim.fn.line('.'))
```
***
# Title: Input and interaction functions
# Category: Functions
# Tags: input, inputsave, inputlist, confirm
---
Use `input()`, `inputlist()`, `confirm()` functions to create interactive vim scripts with user prompts.

```vim
:let name = input('Enter name: ')         " prompt for input
:let choice = inputlist(['1. Red', '2. Blue', '3. Green'])
:let result = confirm('Save changes?', "&Yes\n&No\n&Cancel")
:echo "You chose: " . choice
```

Or:

```lua
local name = vim.fn.input('Enter name: ')
local choice = vim.fn.inputlist(['1.Red', '2. Blue', '3. Green'])
local result = vim.fn.confirm('Save changes?', '&Yes\n&No\n&Cancel')
print("You chose: " .. choice)
```
***
# Title: Window and tab functions
# Category: Functions  
# Tags: winheight, winwidth, tabpagebuflist, winsaveview
---
Use window dimension and state functions to manage window layouts programmatically.

```vim
:echo winheight(0)               " current window height
:echo winwidth(0)                " current window width  
:let view = winsaveview()        " save cursor position and view
:call winrestview(view)          " restore saved view
:echo tabpagebuflist()           " list buffers in current tab
```

Or:

```lua
print(vim.fn.winheight(0))
print(vim.fn.winwidth(0))
local view = vim.fn.winsaveview()
vim.fn.winrestview(view)
print(vim.fn.tabpaebuflist())
```
***
# Title: Highlighting and syntax functions
# Category: Functions
# Tags: synID, synIDattr, hlID, syntax
---
Use syntax highlighting functions to query and manipulate syntax highlighting programmatically.

```vim
:echo synID(line('.'), col('.'), 1)      " syntax ID under cursor
:echo synIDattr(synID(line('.'), col('.'), 1), 'name')  " syntax name
:echo hlID('Comment')                    " highlight group ID
:echo synIDattr(hlID('Comment'), 'fg')   " foreground color
```

Or:

```lua
print(vim.fn.synID(vim.fn.line('.'), vim.fn.col('.'), 1))
print(vim.fn.synIDattr(vim.fn.synId(vim.fn.line('.'), vim.fn.col('.'), 1), 'name'))
print(vim.fn.hlID('Comment'))
print(vim.fn.synIDattr(vim.fn.hlID('Comment'), 'fg'))
```
***
# Title: Regular expression functions
# Category: Functions
# Tags: matchadd, matchdelete, matchlist, regex
---
Use `matchadd()`, `matchdelete()`, `matchlist()` for advanced pattern matching and highlighting.

```vim
:let m = matchadd('Search', 'TODO')      " highlight all TODO
:call matchdelete(m)                     " remove highlighting
:echo matchlist('file.txt', '\\(.*\\)\\.\\(.*\\)')  " capture groups
:echo matchstr('hello123world', '\\d\\+') " extract digits: 123
```

Or:

```lua
local m = vim.fn.matchadd('Search', 'TODO')
vim.fn.matchdelete(m)
print(vim.fn.matchlist('file.txt', '\\(.*\\)\\.\\(.*\\)'))
print(vim.fn.matchstr('hello123world', '\\d\\+'))
```
***
# Title: Fold information functions
# Category: Functions
# Tags: foldclosed, foldtext, foldlevel, folding
---
Use folding functions to query and manipulate code folds programmatically.

```vim
:echo foldclosed(line('.'))      " check if current line is folded
:echo foldlevel(line('.'))       " fold level of current line
:echo foldtext()                 " default fold text
:set foldtext=MyCustomFoldText() " custom fold text function
```

Or:

```lua
print(vim.fn.foldclosed(vim.fn.line('.')))
print(vim.fn.foldlevel(vim.fn.line('.')))
print(vim.fn.foldnext())
vim.opt.foldtext = MyCustomFoldText()
```
***
# Title: File and directory functions
# Category: Functions
# Tags: glob, globpath, isdirectory, readable
---
Use `glob()`, `globpath()`, `isdirectory()` for file system operations and path expansion.

```vim
:echo glob('*.txt')              " find all .txt files
:echo globpath(&rtp, 'plugin/*.vim')  " find plugins in runtimepath
:echo isdirectory(expand('%:h')) " check if directory exists
:echo readable(expand('%'))      " check if file is readable
```

Or:

```lua
print(vim.fn.glob('*.txt'))
print(vim.fn.globpath(&rtp, 'plugin/*.vim'))
print(vim.fn.isdirectory(vim.fn.expand('%:h')))
print(vim.fn.readable(vim.fn.expand('%')))
```
***
# Title: Register manipulation functions
# Category: Functions
# Tags: getreg, setreg, getregtype, registers
---
Use `getreg()`, `setreg()`, `getregtype()` to programmatically work with vim registers.

```vim
:echo getreg('"')                " get default register content
:call setreg('a', 'hello world') " set register 'a'
:echo getregtype('a')            " get register type (v, V, or Ctrl-V)
:call setreg('+', "@")            " copy default register to clipboard
```

Or:

```lua
print(vim.fn.getreg('"'))
vim.fn.setreg('a', 'hello world')
print(vim.fn.getregtype('a'))
vim.fn.setreg('+', "@")
```
***
# Title: Cursor and mark functions
# Category: Functions
# Tags: cursor, getpos, setpos, marks
---
Use `cursor()`, `getpos()`, `setpos()` for precise cursor and mark manipulation.

```vim
:call cursor(10, 5)              " move cursor to line 10, column 5
:let pos = getpos('.')           " get current cursor position
:call setpos('.', pos)           " restore cursor position
:echo getpos("'a")               " get position of mark 'a'
```

Or:

```lua
vim.fn.cursor(10, 5)
local pos = vim.fn.getpos('.')
vim.fn.setpos('.', pos)
print(vim.fn.getpos("'a"))
```
***
