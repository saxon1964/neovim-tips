# Title: Command-line window editing
# Category: Command Line Advanced
# Tags: command-line, window, editing, <C-f>
---
Use `<C-f>` in command-line mode to open the command-line window where you can edit commands with full normal mode motions, including search, replace, and multi-line editing.

```vim
:s/old/   <C-f>    " open command-line window
" Now you can use any normal mode command:
" - Search with /pattern
" - Use ciw to change words
" - Use dd to delete lines
" - Press <Enter> to execute the command
```
***
# Title: Command line expression evaluation
# Category: Command Line Advanced
# Tags: expression, evaluation, calculation, register
---
Use `Ctrl+r =` to evaluate expressions and insert results into command line.

```vim
" In command line:
:echo <Ctrl+r>=2*3<CR>        " insert 6
:edit /path/<Ctrl+r>=strftime("%Y")<CR>/file.txt  " insert current year
:let var = <Ctrl+r>=line('.')*2<CR>  " multiply current line by 2
```

# Title: Insert word under cursor in command line
# Category: Command Line Advanced
# Tags: command-line, register, word, cursor, <C-r><C-w>
---
Use `<C-r><C-w>` in command-line mode to insert the word under the cursor, perfect for quick substitutions.

```vim
" Position cursor on 'oldword' then:
:%s//<C-r><C-w>/g     " substitute oldword with word under cursor
:grep <C-r><C-w> **   " search for word under cursor in all files
:help <C-r><C-w>      " get help for word under cursor
```
***
# Title: Command line filename completion variations
# Category: Command Line Advanced
# Tags: completion, filename, path, directory
---
Use different completion types for files, directories, and patterns.

```vim
" In command line:
:edit <Ctrl+x><Ctrl+f>        " filename completion
:cd <Ctrl+x><Ctrl+d>          " directory completion  
:help <Ctrl+x><Ctrl+v>        " Vim command completion
:set <Ctrl+x><Ctrl+o>         " option completion
```
***
# Title: Command line history search and filtering
# Category: Command Line Advanced  
# Tags: history, search, filter, pattern
---
Search and filter command history with patterns and ranges.

```vim
:history /pattern/            " search command history for pattern
:history : 10                 " show last 10 commands
:history / 5,10               " show search history items 5-10
:history =                    " show expression history
```
***
# Title: Command line range shortcuts  
# Category: Command Line Advanced
# Tags: range, shortcut, selection, lines
---
Use range shortcuts for efficient line selection in commands.

```vim
:.,$d                         " delete from current line to end
:.,+5s/old/new/g             " substitute from current to +5 lines
:'a,'bs/foo/bar/g            " substitute from mark 'a' to mark 'b'
:/pattern/,/end/d            " delete from pattern to 'end'
:1,10!sort                   " sort lines 1-10 with external command
```
***
# Title: Command line substitution flags and modifiers
# Category: Command Line Advanced
# Tags: substitute, flags, modifier, advanced
---
Use advanced substitution flags for precise control over replacements.

```vim
:%s/old/new/gc               " global with confirmation
:%s/old/new/I                " case sensitive (ignore ignorecase setting)  
:%s/old/new/gn               " show matches without replacing
:%s//~/g                     " replace last search with last substitute
:%s/pattern/\=submatch(0)*2/g " use expression in replacement
```
***
# Title: Command line external command integration
# Category: Command Line Advanced
# Tags: external, command, shell, filter, system
---
Integrate external commands seamlessly with Vim command line.

```vim
:r !date                     " insert date command output
:.,+5!sort                   " sort next 5 lines with external sort
:!ls                         " run ls and show output
:!!                          " repeat last external command
:.!tr '[:lower:]' '[:upper:]' " convert current line to uppercase
```
***
# Title: Command line abbreviations and shortcuts
# Category: Command Line Advanced
# Tags: abbreviation, shortcut, cabbrev, expand
---
Create command line abbreviations for frequently used commands.

```vim
:cabbrev W w                 " expand W to w
:cabbrev Q q                 " expand Q to q  
:cabbrev Wq wq               " expand Wq to wq
:cabbrev vsb vert sb         " expand vsb to 'vert sb'
:cabbrev today put =strftime('%Y-%m-%d')  " insert today's date
```
***
# Title: Command line register manipulation
# Category: Command Line Advanced
# Tags: register, insert, content, reference
---
Access and manipulate registers from command line efficiently.

```vim
" In command line:
:<Ctrl+r>"                   " insert default register
:<Ctrl+r>a                   " insert register 'a'
:<Ctrl+r>%                   " insert current filename
:<Ctrl+r>#                   " insert alternate filename
:<Ctrl+r>:                   " insert last command
:<Ctrl+r>/                   " insert last search pattern
```
***
# Title: Command line window operations
# Category: Command Line Advanced
# Tags: window, command, edit, history
---
Use command line window for advanced command editing and history.

```vim
q:                           " open command history window
q/                           " open search history window
:<Ctrl+f>                    " switch to command line window from command line
" In command window: <CR> executes, <Ctrl+c> closes
```
***
# Title: Command line completion customization
# Category: Command Line Advanced
# Tags: completion, custom, wildmenu, wildmode
---
Customize command line completion behavior and appearance.

```vim
:set wildmenu                " enable command completion menu
:set wildmode=longest:full,full  " completion behavior
:set wildignore=*.o,*.pyc,*.swp  " ignore patterns
:set wildoptions=pum         " use popup menu for completion
:set pumheight=15            " limit popup menu height
```
***
# Title: Command line macro recording and playback
# Category: Command Line Advanced
# Tags: macro, record, playbook, command, automation
---
Record and replay command sequences for automation.

```vim
:let @q = 'command sequence' " store command in register q
:normal @q                   " execute commands from register q
:g/pattern/normal @q         " execute macro on matching lines
:%normal @q                  " execute macro on all lines
```
***
# Title: Command line conditional execution
# Category: Command Line Advanced
# Tags: conditional, execute, if, expression
---
Execute commands conditionally using expressions and logic.

```vim
:if line('.') > 100 | echo "Large file" | endif
:execute line('.') > 50 ? 'echo "Past line 50"' : 'echo "Early in file"'
:silent! write               " suppress error messages
:try | source ~/.vimrc | catch | echo "Config error" | endtry
```
***
# Title: Command line script execution  
# Category: Command Line Advanced
# Tags: script, execute, source, runtime
---
Execute scripts and source files with advanced options.

```vim
:source %                    " source current file
:so $MYVIMRC                 " source vimrc
:runtime! plugin/**/*.vim    " source all plugins
:execute 'source' fnameescape(expand('~/.config/nvim/init.lua'))
:luafile %                   " execute current Lua file
```
***
# Title: Command line error handling
# Category: Command Line Advanced
# Tags: error, silent, try, catch, handling
---
Handle errors gracefully in command line operations.

```vim
:silent! command             " suppress error messages
:try | risky_command | catch /^Vim/ | echo "Vim error" | endtry
:if exists(':SomeCommand') | SomeCommand | endif
:command! -bang MyCmd if <bang>0 | echo "Bang!" | else | echo "No bang" | endif
```
***
# Title: Command line buffer and window targeting
# Category: Command Line Advanced
# Tags: buffer, window, target, specific, operation
---
Target specific buffers and windows for command execution.

```vim
:bufdo %s/old/new/ge         " execute in all buffers
:windo set number            " execute in all windows  
:tabdo echo tabpagenr()      " execute in all tabs
:argdo %s/pattern/replace/ge " execute on argument list files
:cdo s/old/new/g             " execute on quickfix list items
```
***
# Title: Command line advanced search operations
# Category: Command Line Advanced
# Tags: search, advanced, pattern, replace, scope
---
Perform sophisticated search operations from command line.

```vim
:vimgrep /pattern/ **/*.js   " search in all JS files recursively
:lvimgrep /TODO/ %           " search in current file (location list)
:grep -r "pattern" --include="*.py" .  " external grep
:helpgrep pattern            " search help files
:g/pattern1/s/pattern2/replacement/g   " conditional substitute
```
***
# Title: Command line job control and async
# Category: Command Line Advanced
# Tags: job, async, background, control
---
Control background jobs and asynchronous operations.

```vim
:call jobstart(['ls', '-la'])           " start async job
:let job = jobstart('long_command', {'on_exit': 'MyHandler'})
:call jobstop(job)                      " stop job
:call jobwait([job], 5000)              " wait for job with timeout
```
***
# Title: Command line terminal integration
# Category: Command Line Advanced
# Tags: terminal, integration, shell, command
---
Integrate terminal operations seamlessly with command line.

```vim
:terminal                    " open terminal in split
:vert terminal              " open vertical terminal
:terminal ++close grep pattern *.txt  " run command and close
:let @" = system('date')    " capture system command output
:put =system('whoami')      " insert system command result
```
***
# Title: Command line advanced substitution techniques
# Category: Command Line Advanced
# Tags: substitute, advanced, technique, pattern
---
Master advanced substitution patterns and techniques.

```vim
:%s/\v(word1|word2)/\U\1/g   " uppercase specific words
:%s/\(.*\)\n\1/\1/           " remove duplicate consecutive lines
:%s/^\s*\(.*\S\)\s*$/\1/     " trim leading/trailing whitespace
:%s/\%V.*\%V/\=substitute(submatch(0), 'a', 'A', 'g')  " in visual selection
```
***
# Title: Command line debugging and inspection
# Category: Command Line Advanced
# Tags: debug, inspect, verbose, trace
---
Debug command execution and inspect Vim state from command line.

```vim
:verbose map <leader>        " show where mapping was defined
:verbose set tabstop?        " show where option was last set
:function                    " list all user-defined functions
:scriptnames                 " list all sourced scripts
:messages                    " show message history
:redir @a | silent! command | redir END  " redirect output to register
```
***
# Title: Command line custom command creation
# Category: Command Line Advanced
# Tags: command, custom, user, define, parameter
---
Create sophisticated custom commands with parameters and completion.

```vim
" Command with file completion
:command! -nargs=1 -complete=file EditConfig edit ~/.config/<args>

" Command with custom completion
:command! -nargs=1 -complete=custom,MyComplete MyCmd echo <args>
function! MyComplete(ArgLead, CmdLine, CursorPos)
  return ['option1', 'option2', 'option3']
endfunction

" Range command with count
:command! -range=% -nargs=1 ReplaceAll <line1>,<line2>s/<args>/g
```
***
# Title: Command line environment variable integration
# Category: Command Line Advanced
# Tags: environment, variable, expand, system
---
Work with environment variables and system integration.

```vim
:echo $HOME                  " display environment variable
:let $MYVAR = 'value'       " set environment variable
:edit $HOME/.vimrc          " use environment variable in path
:!echo $PATH                " use in external command
:put =expand('$USER')       " insert environment variable value
```
***
