# Title: Treesitter incremental selection
# Category: Treesitter
# Tags: treesitter, selection, incremental, expand
---
Use `Ctrl-space` to start incremental selection, then repeat to expand selection based on syntax tree.

```vim
Ctrl-space  " start/expand selection
Ctrl-x      " shrink selection (if configured)
```
***
# Title: Treesitter playground
# Category: Treesitter
# Tags: treesitter, playground, debug, explore
---
Use `:TSPlaygroundToggle` to open treesitter playground for exploring syntax tree interactively.

```vim
:TSPlaygroundToggle  " toggle treesitter playground
```
***
# Title: Treesitter folding
# Category: Treesitter
# Tags: treesitter, folding, code, structure
---
Set `foldmethod=expr` and `foldexpr=nvim_treesitter#foldexpr()` to use treesitter-based folding.

```vim
:set foldmethod=expr
:set foldexpr=nvim_treesitter#foldexpr()
```
***
# Title: Treesitter node navigation
# Category: Treesitter
# Tags: treesitter, navigation, nodes, movement
---
Use `]f` and `[f` to navigate between function nodes, or `]c` and `[c` for class nodes (if configured).

```vim
]f  " next function
[f  " previous function
]c  " next class
[c  " previous class
```
***
# Title: Treesitter swap nodes
# Category: Treesitter
# Tags: treesitter, swap, parameters, arguments
---
Use treesitter to swap function parameters or other syntax nodes using configured keymaps.

```vim
gs  " swap with next parameter/node
gS  " swap with previous parameter/node
```
***
# Title: Treesitter install parser
# Category: Treesitter
# Tags: treesitter, install, parser, language
---
Use `:TSInstall <language>` to install treesitter parser for a specific language.

```vim
:TSInstall lua        " install Lua parser
:TSInstall javascript " install JavaScript parser
:TSInstall all        " install all maintained parsers
```
***
