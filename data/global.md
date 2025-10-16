# Title: Open terminal 
# Category: Global
# Tags: terminal
---
Use `:ter[minal]` to open a terminal window. When the window shows up, press `i` to enter the insert mode and start typing shell commands. Type `exit` to close the terminal window. 

**TIP**: Once in terminal, type `vimtutor` for a nice vim tutorial, excellent for starters.

```vim
:ter
```
***
# Title: Open documentation for word under the cursor 
# Category: Global
# Tags: man pages, documentation, help
---
Use `K` to open a man page or other type of available documentation for the word under the cursor. 

```vim
K
```
***
# Title: Global command - execute on matching lines
# Category: Global
# Tags: global, command, pattern, ex
---
Use `:g/pattern/command` to execute a command on all lines matching a pattern. One of Vim's most powerful features.

```vim
:g/TODO/d           " delete all lines containing TODO
:g/function/p       " print all lines with 'function'
:g/error/norm gUU   " uppercase lines containing 'error'
:g!/pattern/d       " delete lines NOT matching pattern (inverse)
:v/pattern/d        " same as :g! (v for inVerse)
```
***
# Title: Global command with normal mode commands
# Category: Global
# Tags: global, normal, command, pattern
---
Use `:g/pattern/norm <commands>` to execute normal mode commands on matching lines.

```vim
:g/TODO/norm A !!!          " append !!! to lines with TODO
:g/^#/norm >>               " indent all lines starting with #
:g/function/norm dwelp      " swap first two words on lines with 'function'
:g/console\.log/norm gcc    " comment out console.log lines (with commentary.vim)
```
***
# Title: Global command with line ranges
# Category: Global
# Tags: global, range, lines, pattern
---
Combine `:g` with line ranges to limit where the global command operates.

```vim
:10,50g/pattern/d         " delete matching lines only in range 10-50
:'<,'>g/pattern/norm A!   " append ! to matching lines in visual selection
:1,$g/^$/d                " delete all empty lines in file
```
***
# Title: Global command - move matching lines
# Category: Global
# Tags: global, move, pattern, reorder
---
Use `:g` with `:m` to move all matching lines to a specific location.

```vim
:g/TODO/m$                " move all lines with TODO to end of file
:g/^import/m0             " move all import lines to top of file
:g/function/m'a           " move all lines with 'function' to mark 'a'
```
***
# Title: Global command - copy matching lines
# Category: Global
# Tags: global, copy, pattern, duplicate
---
Use `:g` with `:t` (copy) to duplicate matching lines to a location.

```vim
:g/error/t$               " copy all error lines to end of file
:g/TODO/t0                " copy all TODO lines to top of file
```
***
# Title: Global command - advanced patterns
# Category: Global
# Tags: global, regex, pattern, advanced
---
Combine global command with advanced patterns for complex operations.

```vim
:g/^\s*$/d                " delete all blank lines (whitespace only)
:g/pattern1/.,/pattern2/d " delete from pattern1 to pattern2
:g/^/m0                   " reverse all lines in file
:g/^/t.                   " duplicate every line
```
***