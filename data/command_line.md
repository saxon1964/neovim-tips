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
# Title: Command-line cursor movement
# Category: Command Line
# Tags: command, cursor, movement, navigation
---
Use arrow keys or `Ctrl+b`/`Ctrl+e` for movement, `Shift+Left`/`Shift+Right` or `Ctrl+Left`/`Ctrl+Right` for word movement.

#### Example

```vim
" In command mode:
<Left>/<Right>     " move cursor by character
Ctrl+b/Ctrl+e      " move to beginning/end of line
Shift+Left/Right   " move by word
Ctrl+Left/Right    " move by word (alternative)
```
===
# Title: Command-line deletion operations
# Category: Command Line
# Tags: command, delete, backspace, clear
---
Use `Backspace` or `Ctrl+h` to delete character, `Del` to delete forward, `Ctrl+w` to delete word, `Ctrl+u` to clear line.

#### Example

```vim
" In command mode:
<BS>/Ctrl+h  " delete character backward
<Del>        " delete character forward
Ctrl+w       " delete word backward
Ctrl+u       " clear from cursor to beginning
```
===
# Title: Command-line history with filtering
# Category: Command Line
# Tags: command, history, filter, search
---
Use `Shift+Up`/`Shift+Down` or `PageUp`/`PageDown` to recall commands that start with current text.

#### Example

```vim
" Type partial command, then:
:se<Shift+Up>    " find previous commands starting with 'se'
:ed<PageDown>    " find next commands starting with 'ed'
```
===
# Title: Command-line completion modes
# Category: Command Line
# Tags: command, completion, tab, modes
---
Use `Tab` for next completion, `Shift+Tab` for previous, `Ctrl+d` to list all, `Ctrl+a` to insert all matches, `Ctrl+l` for longest common part.

#### Example

```vim
" In command mode:
:e <Tab>        " complete filename
:e <Shift+Tab>  " previous completion
:set <Ctrl+d>   " list all completions
:b <Ctrl+a>     " insert all buffer matches
:help <Ctrl+l>  " complete to longest common part
```
===
# Title: Command-line register insertion
# Category: Command Line
# Tags: command, register, insert, content
---
Use `Ctrl+r` followed by register name to insert register contents into command line.

#### Example

```vim
" In command mode:
:Ctrl+r "     " insert default register
:Ctrl+r a     " insert register 'a'
:Ctrl+r %     " insert current filename
:Ctrl+r :     " insert last command
:Ctrl+r /     " insert last search pattern
```
===
# Title: Command-line special insertions
# Category: Command Line
# Tags: command, insert, word, filename, line
---
Use `Ctrl+r` with special keys to insert current context: `Ctrl+w` for word, `Ctrl+f` for filename, `Ctrl+l` for line.

#### Example

```vim
" In command mode:
:Ctrl+r Ctrl+w  " insert word under cursor
:Ctrl+r Ctrl+f  " insert filename under cursor
:Ctrl+r Ctrl+p  " insert filename with path expansion
:Ctrl+r Ctrl+a  " insert WORD under cursor
:Ctrl+r Ctrl+l  " insert line under cursor
```
===
# Title: Command-line literal insertion
# Category: Command Line
# Tags: command, literal, insert, special
---
Use `Ctrl+v` or `Ctrl+q` to insert the next character literally (useful for special characters).

#### Example

```vim
" In command mode:
:echo "Ctrl+v<Tab>"   " insert literal tab character
:s/Ctrl+v<Esc>/x/g    " search for literal Esc character
```
===
# Title: Command-line mode switching
# Category: Command Line
# Tags: command, mode, switch, abandon
---
Use `Ctrl+c` or `Esc` to abandon command, `Ctrl+\ Ctrl+n` or `Ctrl+\ Ctrl+g` to go to normal mode.

#### Example

```vim
" In command mode:
Ctrl+c           " abandon command without executing
<Esc>            " abandon command (alternative)
Ctrl+\ Ctrl+n    " go to normal mode
Ctrl+\ Ctrl+g    " go to normal mode (alternative)
```
===
# Title: Command-line window access
# Category: Command Line
# Tags: command, window, edit, history
---
Use `Ctrl+f` to open command-line window for full editing, `Ctrl+o` to execute one normal mode command.

#### Example

```vim
" In command mode:
Ctrl+f  " open command-line window for editing
Ctrl+o  " execute one normal mode command and return
```
===
# Title: Command-line word manipulation
# Category: Command Line
# Tags: command, word, delete, kill, clear
---
Use `Ctrl+w` to delete word before cursor, `Ctrl+u` to delete from cursor to beginning of line.

#### Example

```vim
" In command mode:
Ctrl+w  " delete word before cursor
Ctrl+u  " delete from cursor to beginning
Ctrl+k  " delete from cursor to end of line
```
===