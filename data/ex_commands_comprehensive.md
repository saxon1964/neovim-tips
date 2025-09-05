# Title: Buffer list navigation
# Category: Buffer Management
# Tags: buffer, list, navigation, ex
---
Use `:ls` or `:buffers` to show all buffers with their numbers and status indicators.

```vim
:ls                 " list all buffers
:buffers           " same as :ls (alternative)
:ls!               " list all buffers including unlisted
```

Status indicators: `%` current, `#` alternate, `+` modified, `x` read errors.
***
# Title: Go to specific buffer by number
# Category: Buffer Management
# Tags: buffer, number, navigation, ex
---
Use `:buffer N` or `:b N` to switch to buffer number N from the buffer list.

```vim
:buffer 3          " go to buffer number 3
:b 3               " shorter version
:b filename        " go to buffer by partial filename match
```
***
# Title: Delete buffers
# Category: Buffer Management
# Tags: buffer, delete, close, ex
---
Use `:bdelete` or `:bd` to remove buffer from list, `:bwipeout` to completely wipe buffer.

```vim
:bdelete           " delete current buffer
:bd 3              " delete buffer number 3
:bd file.txt       " delete buffer by name
:bwipeout          " completely wipe current buffer
:1,3bd             " delete buffers 1 through 3
```
***
# Title: Create new empty buffer
# Category: Buffer Management
# Tags: buffer, new, empty, enew, ex
---
Use `:enew` to create a new empty buffer in current window.

```vim
:enew              " create new empty buffer
:new               " create new buffer in split window
:vnew              " create new buffer in vertical split
```
***
# Title: Recover file from swap
# Category: File Recovery
# Tags: recover, swap, file, crash, ex
---
Use `:recover filename` or `:rec` to recover file from swap file after crash.

```vim
:recover file.txt  " recover file from swap
:rec               " recover current file
```

Vim creates `.swp` files for crash recovery. Use this after unexpected shutdowns.
***
# Title: Find file in path
# Category: File Operations
# Tags: find, path, file, search, ex
---
Use `:find filename` to search for file in 'path' option directories and edit it.

```vim
:find config.vim   " find and edit config.vim in path
:fin *.py          " find Python files (with tab completion)
```

Set your path with `:set path+=directory` to include custom directories.
***
# Title: Copy lines to another location
# Category: Text Manipulation
# Tags: copy, lines, move, range, ex
---
Use `:copy` or `:co` to copy lines to another location in the file.

```vim
:5copy10           " copy line 5 after line 10
:1,3co$            " copy lines 1-3 to end of file
:.co0              " copy current line to beginning
:co.               " copy current line after itself (duplicate)
```
***
# Title: Move lines to another location
# Category: Text Manipulation
# Tags: move, lines, cut, range, ex
---
Use `:move` or `:m` to move lines to another location in the file.

```vim
:5move10           " move line 5 after line 10
:1,3m$             " move lines 1-3 to end of file
:.m0               " move current line to beginning
:m+1               " move current line down one position
```
***
# Title: Delete specific lines
# Category: Text Manipulation
# Tags: delete, lines, range, remove, ex
---
Use `:delete` or `:d` to delete specific lines or line ranges.

```vim
:5delete           " delete line 5
:1,3d              " delete lines 1 through 3
:.,$d              " delete from current line to end
:g/pattern/d       " delete all lines containing pattern
```
***
# Title: Close all windows except current
# Category: Window Management
# Tags: window, close, only, layout, ex
---
Use `:only` or `:on` to close all windows except the current one.

```vim
:only              " close all other windows
:on                " shorter version
```

Useful for cleaning up complex window layouts quickly.
***
# Title: Show version information
# Category: System Information
# Tags: version, info, build, features, ex
---
Use `:version` to display Neovim version, build info, and compiled features.

```vim
:version           " show full version information
:ve                " shorter version
```

Shows version number, build date, features, and compilation options.
***
# Title: List all sourced scripts
# Category: Configuration
# Tags: scripts, source, debug, files, ex
---
Use `:scriptnames` to list all sourced Vim script files with their script IDs.

```vim
:scriptnames       " list all sourced scripts
:scr               " shorter version
```

Useful for debugging configuration issues and seeing load order.
***
# Title: Source Vim scripts
# Category: Configuration
# Tags: source, script, load, runtime, ex
---
Use `:source` to execute Vim script file, `:runtime` to source from runtime path.

```vim
:source ~/.vimrc   " source specific file
:so %              " source current file
:runtime plugin/myplugin.vim  " source from runtime path
:ru syntax/python.vim         " load Python syntax
```
***
# Title: Set local options
# Category: Configuration
# Tags: set, local, options, buffer, window, ex
---
Use `:setlocal` to set options only for current buffer/window.

```vim
:setlocal number   " show line numbers in current buffer only
:setl ts=2         " set tabstop to 2 for current buffer
:setlocal ft=python " set filetype for current buffer
```
***
# Title: Jump to tag definition
# Category: Navigation
# Tags: tag, jump, definition, ctags, ex
---
Use `:tag tagname` to jump to tag definition (requires tags file).

```vim
:tag function_name " jump to tag definition
:ta MyClass        " jump to MyClass tag
:tag /pattern      " search for tags matching pattern
```

Generate tags with `ctags -R .` in your project root.
***
# Title: Previous tag in stack
# Category: Navigation
# Tags: tag, previous, stack, back, ex
---
Use `:pop` or `:po` to go back to previous location in tag stack.

```vim
:pop               " go back in tag stack
:po                " shorter version
:2pop              " go back 2 positions
```

Use after jumping to tags with `:tag` or `Ctrl+]`.
***
# Title: Next file in argument list
# Category: File Navigation
# Tags: next, file, argument, list, ex
---
Use `:next` or `:n` to edit next file in argument list.

```vim
:next              " edit next file
:n                 " shorter version
:2next             " skip 2 files forward
```

See argument list with `:args`, set with `nvim file1 file2 file3`.
***
# Title: Previous file in argument list
# Category: File Navigation
# Tags: previous, file, argument, list, ex
---
Use `:previous` or `:prev` to edit previous file in argument list.

```vim
:previous          " edit previous file  
:prev              " shorter version
:2prev             " skip 2 files backward
```
***
# Title: First and last files in argument list
# Category: File Navigation
# Tags: first, last, file, argument, list, ex
---
Use `:first` and `:last` to jump to first or last file in argument list.

```vim
:first             " edit first file in argument list
:rewind            " same as :first
:last              " edit last file in argument list
```
***
# Title: Show argument list
# Category: File Navigation
# Tags: args, argument, list, files, ex
---
Use `:args` to display current argument list with current file highlighted.

```vim
:args              " show argument list
:args *.py         " set argument list to all Python files
:args **/*.js      " recursively find all JavaScript files
```
***
# Title: Run grep and jump to matches
# Category: Search
# Tags: grep, search, quickfix, external, ex
---
Use `:grep pattern files` to run external grep and jump to first match.

```vim
:grep TODO *.py    " search for TODO in Python files
:grep -r "function" src/  " recursive search in src/
:grep! pattern *   " run grep but don't jump to first match
```

Results appear in quickfix list. Use `:cn` and `:cp` to navigate.
***
# Title: Internal grep with vimgrep
# Category: Search
# Tags: vimgrep, search, internal, pattern, ex
---
Use `:vimgrep` to search using Vim's internal grep (works with Vim patterns).

```vim
:vimgrep /pattern/j *.py   " search in Python files
:vim /\cTODO/ **/*.js      " case-insensitive recursive search
:vimgrep /\<word\>/ %      " search for whole word in current file
```

Use `j` flag to avoid jumping to first match immediately.
***
# Title: Location list navigation
# Category: Search
# Tags: location, list, navigate, lnext, ex
---
Use `:lnext`, `:lprev` to navigate location list (window-local quickfix).

```vim
:lnext             " go to next item in location list
:lprev             " go to previous item
:lfirst            " go to first item
:llast             " go to last item
:lopen             " open location list window
```
***
# Title: Quickfix list navigation
# Category: Search
# Tags: quickfix, navigate, error, jump, ex
---
Use `:cnext`, `:cprev` to navigate quickfix list (global error list).

```vim
:cnext             " go to next quickfix item
:cprev             " go to previous item  
:cfirst            " go to first item
:clast             " go to last item
:copen             " open quickfix window
:cclose            " close quickfix window
```
***
# Title: Execute normal mode commands
# Category: Command Execution
# Tags: normal, execute, mode, command, ex
---
Use `:normal commands` to execute normal mode commands from Ex mode.

```vim
:normal dd         " delete current line
:5,10normal A;     " append semicolon to lines 5-10
:%normal I//       " comment all lines with //
```

Use `!` to avoid mappings: `:normal! dd`
***
# Title: Repeat last Ex command
# Category: Command History
# Tags: repeat, last, command, history, ex
---
Use `@:` to repeat the last Ex command, `@@` to repeat last `@` command.

```vim
@:                 " repeat last Ex command
5@:                " repeat last Ex command 5 times
@@                 " repeat the last @ command
```

Useful for repeating complex commands without retyping.
***
# Title: Save all modified buffers
# Category: File Operations  
# Tags: save, all, buffers, write, wa, ex
---
Use `:wall` or `:wa` to save all modified buffers at once.

```vim
:wall              " write all modified buffers
:wa                " shorter version
:wqa               " write all and quit
:xa                " write all modified and exit
```
***
# Title: Quit all windows/buffers
# Category: File Operations
# Tags: quit, all, exit, buffers, ex  
---
Use `:qall` or `:qa` to quit all windows, `:qa!` to quit without saving.

```vim
:qall              " quit all windows/buffers
:qa                " shorter version
:qa!               " quit all without saving changes
:wqa               " save all and quit
```
***