# Title: Append text after line
# Category: Text Editing
# Tags: append, insert, text, add, ex
---
Use `:append` or `:a` to enter text entry mode, adding lines after specified line.

```vim
:5a                 " append after line 5
:append             " append after current line
This is new text
.                   " end with dot on empty line
```
***
# Title: Insert text before line
# Category: Text Editing
# Tags: insert, text, before, add, ex
---
Use `:insert` or `:i` to enter text entry mode, adding lines before specified line.

```vim
:5i                 " insert before line 5
:insert             " insert before current line
New text here
.                   " end with dot on empty line
```
***
# Title: Change lines with text entry
# Category: Text Editing
# Tags: change, replace, lines, text, ex
---
Use `:change` or `:c` to replace line range with new text.

```vim
:5c                 " change line 5
:1,3c               " change lines 1-3
New replacement text
.                   " end with dot on empty line
```
***
# Title: Put register contents
# Category: Registers
# Tags: put, paste, register, insert, ex
---
Use `:put` to insert register contents after current line.

```vim
:put                " put default register after current line
:put a              " put register 'a' after current line
:5put               " put after line 5
:put!               " put before current line
:put +              " put system clipboard
```
***
# Title: Yank lines to register
# Category: Registers
# Tags: yank, copy, register, lines, ex
---
Use `:yank` or `:y` to copy lines to a register.

```vim
:yank               " yank current line to default register
:5y                 " yank line 5
:1,3y a             " yank lines 1-3 to register 'a'
:y 5                " yank 5 lines starting from current
```
***
# Title: Join lines together
# Category: Text Editing
# Tags: join, lines, merge, combine, ex
---
Use `:join` or `:j` to join lines, removing line breaks.

```vim
:join               " join current and next line
:5,10j              " join lines 5 through 10
:j!                 " join without inserting spaces
:j 3                " join current line with next 2 lines
```
***
# Title: Center align text
# Category: Formatting
# Tags: center, align, format, text, ex
---
Use `:center` or `:ce` to center-align text within specified width.

```vim
:center             " center current line (default width)
:ce 80              " center in 80-character width
:1,5ce 60           " center lines 1-5 in 60 chars
```
***
# Title: Left align text
# Category: Formatting
# Tags: left, align, format, text, ex
---
Use `:left` or `:le` to left-align text, removing leading whitespace.

```vim
:left               " left-align current line
:le 4               " left-align with 4-space indent
:1,10left 0         " remove all leading whitespace from lines 1-10
```
***
# Title: Right align text
# Category: Formatting
# Tags: right, align, format, text, ex
---
Use `:right` or `:ri` to right-align text within specified width.

```vim
:right              " right-align current line
:ri 80              " right-align in 80-character width
:1,5ri 60           " right-align lines 1-5 in 60 chars
```
***
# Title: Sort lines alphabetically
# Category: Text Manipulation
# Tags: sort, alphabetical, lines, order, ex
---
Use `:sort` to sort lines in various ways.

```vim
:sort               " sort current buffer alphabetically
:5,10sort           " sort lines 5-10
:sort!              " reverse sort (descending)
:sort n             " numeric sort
:sort u             " remove duplicates while sorting
:sort i             " case-insensitive sort
```
***
# Title: Change tab settings and convert
# Category: Formatting
# Tags: retab, tabs, spaces, convert, ex
---
Use `:retab` to convert tabs to spaces or vice versa based on current settings.

```vim
:retab              " convert tabs using current tabstop
:retab 4            " convert using 4-space tabs
:retab!             " also change tab settings
:1,10retab 2        " retab lines 1-10 with 2-space tabs
```
***
# Title: Write and exit
# Category: File Operations
# Tags: xit, write, exit, save, quit, ex
---
Use `:xit` or `:x` to write file only if modified, then exit.

```vim
:xit                " write if modified and exit
:x                  " shorter version
:5,10x file.txt     " write lines 5-10 to file and exit
```

More efficient than `:wq` since it only writes when necessary.
***
# Title: Write all and quit all
# Category: File Operations
# Tags: wqall, write, quit, all, buffers, ex
---
Use `:wqall` to write all modified buffers and quit all windows.

```vim
:wqall              " write all modified and quit all
:wqa                " shorter version
:xa                 " write all modified and exit (alternative)
```
***
# Title: Browse with file dialog
# Category: File Operations
# Tags: browse, dialog, file, gui, ex
---
Use `:browse` to open file dialog for commands (GUI Vim only).

```vim
:browse edit        " browse for file to edit
:browse saveas      " browse for save location
:browse read        " browse for file to read
:browse source      " browse for script to source
```
***
# Title: List old files
# Category: File History
# Tags: oldfiles, recent, history, files, ex
---
Use `:oldfiles` to show list of recently edited files.

```vim
:oldfiles           " show recently edited files
:ol                 " shorter version
:browse oldfiles    " browse old files with dialog (GUI)
```

Files are numbered; use `:e #< to edit by number.
***
# Title: Make session file
# Category: Session Management
# Tags: mksession, session, save, workspace, ex
---
Use `:mksession` to save current editing session to file.

```vim
:mksession          " create Session.vim in current dir
:mks ~/my.vim       " save session to specific file
:mks!               " overwrite existing session file
```

Restore with `:source Session.vim` or `nvim -S Session.vim`.
***
# Title: Save current view
# Category: View Management
# Tags: mkview, view, save, position, ex
---
Use `:mkview` to save current window view (cursor position, folds, etc.).

```vim
:mkview             " save view with automatic name
:mkv 1              " save to view slot 1
:mkview ~/my.vim    " save view to specific file
```
***
# Title: Load saved view
# Category: View Management
# Tags: loadview, view, restore, position, ex
---
Use `:loadview` to restore previously saved window view.

```vim
:loadview           " load view with automatic name
:lo 1               " load from view slot 1
:loadview ~/my.vim  " load view from specific file
```
***
# Title: Quit with error code
# Category: Exit
# Tags: cquit, quit, error, code, ex
---
Use `:cquit` or `:cq` to quit Vim with error exit code.

```vim
:cquit              " quit with error code
:cq                 " shorter version  
:cq 2               " quit with specific error code
```

Useful in shell scripts to indicate failure.
***
# Title: Lock marks during operation
# Category: Marks
# Tags: lockmarks, marks, preserve, lock, ex
---
Use `:lockmarks` to prevent commands from changing mark positions.

```vim
:lockmarks normal! dd    " delete line without affecting marks
:loc s/old/new/g         " substitute without moving marks
```
***
# Title: Keep marks during operation
# Category: Marks
# Tags: keepmarks, marks, preserve, maintain, ex
---
Use `:keepmarks` to preserve mark positions during range operations.

```vim
:keepmarks 1,5d     " delete lines 1-5 but keep marks
:kee s/old/new/g    " substitute preserving marks
```
***
# Title: Keep jump list during operation
# Category: Navigation
# Tags: keepjumps, jumps, preserve, navigation, ex
---
Use `:keepjumps` to prevent commands from adding entries to jump list.

```vim
:keepjumps normal! G     " go to end without jump entry
:keepjumps /pattern      " search without jump entry
```
***
# Title: Execute on non-matching lines
# Category: Text Manipulation
# Tags: vglobal, inverse, global, exclude, ex
---
Use `:vglobal` or `:v` to execute commands on lines NOT matching pattern.

```vim
:v/pattern/d        " delete lines NOT containing pattern
:vglobal/TODO/p     " print lines without TODO
:5,10v/^$/d         " delete non-empty lines in range 5-10
```

Opposite of `:global` - executes on non-matching lines.
***
# Title: Return to normal mode
# Category: Mode Switching
# Tags: visual, normal, mode, return, ex
---
Use `:visual` or `:vi` to return to Normal mode from Ex mode.

```vim
:visual             " return to Normal mode
:vi                 " shorter version
```

Historical command, rarely needed in modern Neovim.
***
# Title: Substitute confirmation
# Category: Search Replace
# Tags: substitute, confirm, interactive, replace, ex
---
Use the `c` flag with `:substitute` for interactive confirmation of each replacement.

```vim
:s/old/new/gc       " substitute with confirmation
:%s/foo/bar/gc      " replace in whole file with prompts
:5,10s/x/y/gc       " replace in range with confirmation
```

Prompts: `y`es, `n`o, `a`ll, `q`uit, `l`ast.
***
# Title: Advanced substitute flags
# Category: Search Replace
# Tags: substitute, flags, options, advanced, ex
---
Use various flags with `:substitute` for advanced replacement options.

```vim
:s/old/new/I        " case-sensitive (ignore ignorecase)
:s/old/new/i        " case-insensitive
:s/old/new/e        " no error if pattern not found
:s/old/new/n        " report matches but don't substitute
:s/old/new/p        " print line after substitution
```
***
# Title: Substitute with expressions
# Category: Search Replace
# Tags: substitute, expression, function, dynamic, ex
---
Use `\=` in replacement to evaluate Vim expressions.

```vim
:s/\d\+/\=submatch(0)*2/g    " double all numbers
:s/.*/\=line('.').' '.submatch(0)/  " add line number prefix
:%s/$/\=', line: '.line('.')/       " add line number suffix
```
***
# Title: Global with range
# Category: Text Manipulation
# Tags: global, range, lines, scope, ex
---
Use `:global` with line ranges to limit scope of global operations.

```vim
:5,50g/pattern/d    " delete matching lines only in range 5-50
:.,+10g/TODO/p      " print TODO lines from current to +10 lines
:'<,'>g/^#/s/#/\/\//  " in visual selection, change # to //
```
***
# Title: Nested global commands
# Category: Text Manipulation
# Tags: global, nested, complex, pattern, ex
---
Use nested `:global` commands for complex pattern operations.

```vim
:g/function/+1,/^}/g/TODO/p   " find TODO in function bodies
:g/class/.,/^$/v/def/d        " delete non-def lines in classes
```

Inner global operates on lines found by outer global.
***
# Title: Command history navigation
# Category: Command Line
# Tags: history, navigate, command, previous, ex
---
Use history navigation to recall and modify previous Ex commands.

```vim
:<Up>               " previous command in history
:<Down>             " next command in history
:<C-p>              " previous command (alternative)
:<C-n>              " next command (alternative)
:his                " show command history
```
***
# Title: Range with patterns
# Category: Text Manipulation
# Tags: range, pattern, search, scope, ex
---
Use patterns as range specifiers in Ex commands.

```vim
:/pattern1/,/pattern2/d        " delete from first to second pattern
:/function/+1,/^}/s/old/new/g  " substitute in function body
:?#include?,/main/p            " print from include backward to main
```
***
# Title: Substitute with backreferences
# Category: Search Replace
# Tags: substitute, backreference, capture, group, ex
---
Use `\(` and `\)` to capture groups, reference with `\1`, `\2`, etc.

```vim
:s/\(word1\) \(word2\)/\2 \1/    " swap two words
:s/\(\w\+\)\s\+\(\w\+\)/\2, \1/  " swap and add comma
:%s/\(.*\)/"\1"/                 " quote all lines
```
***