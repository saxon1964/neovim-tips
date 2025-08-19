# Title: Command history navigation
# Category: Command Line
# Tags: command, history, navigation
---
Use `Ctrl+p` to go to previous command in history and `Ctrl+n` to go to next command while in command mode.

#### Example

```vim
:Ctrl+p  " previous command in history
:Ctrl+n  " next command in history
```
===
# Title: Command completion
# Category: Command Line
# Tags: command, completion, tab
---
Use `Tab` for command completion and `Ctrl+d` to list all possible completions.

#### Example

```vim
:ed<Tab>   " complete to :edit
:h vim<Tab>  " complete help topics
:set nu<Ctrl+d>  " list all options starting with 'nu'
```
===
# Title: Insert word under cursor in command
# Category: Command Line
# Tags: command, word, cursor
---
Use `Ctrl+r Ctrl+w` to insert the word under cursor into command line.

#### Example

```vim
:Ctrl+r Ctrl+w  " insert word under cursor
```
===
# Title: Command line editing
# Category: Command Line
# Tags: command, edit, navigation
---
Use `Ctrl+b` to go to beginning of line, `Ctrl+e` to end, `Ctrl+h` to delete character, `Ctrl+w` to delete word.

#### Example

```vim
:Ctrl+b  " go to beginning of command line
:Ctrl+e  " go to end of command line
:Ctrl+h  " delete character backward
:Ctrl+w  " delete word backward
```
===
# Title: Open command history
# Category: Command Line
# Tags: history, command, window
---
Use `q:` to open command history in a searchable window.

#### Example

```vim
q:  " open command history window
```
===