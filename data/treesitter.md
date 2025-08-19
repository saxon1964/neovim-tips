# Title: Treesitter inspection
# Category: Treesitter
# Tags: treesitter, inspect, debug
---
Use `:Inspect` to see syntax node under cursor or `:InspectTree` to open full syntax tree.

#### Example

```vim
:Inspect      " inspect node under cursor
:InspectTree  " open full syntax tree
```
===
# Title: Treesitter text objects
# Category: Treesitter
# Tags: treesitter, textobjects, selection
---
Use treesitter text objects like `af` (around function), `if` (inside function), `ac` (around class), `ic` (inside class).

#### Example

```vim
daf  " delete around function
vif  " select inside function
yac  " yank around class
```
===
# Title: Treesitter incremental selection
# Category: Treesitter
# Tags: treesitter, selection, incremental, expand
---
Use `Ctrl-space` to start incremental selection, then repeat to expand selection based on syntax tree.

#### Example

```vim
Ctrl-space  " start/expand selection
Ctrl-x      " shrink selection (if configured)
```
===
# Title: Treesitter syntax highlighting
# Category: Treesitter
# Tags: treesitter, highlighting, syntax, colors
---
Use `:TSBufEnable highlight` to enable treesitter highlighting or `:TSBufDisable highlight` to disable.

#### Example

```vim
:TSBufEnable highlight   " enable TS highlighting
:TSBufDisable highlight  " disable TS highlighting
```
===
# Title: Treesitter playground
# Category: Treesitter
# Tags: treesitter, playground, debug, explore
---
Use `:TSPlaygroundToggle` to open treesitter playground for exploring syntax tree interactively.

#### Example

```vim
:TSPlaygroundToggle  " toggle treesitter playground
```
===
# Title: Treesitter parser info
# Category: Treesitter
# Tags: treesitter, parser, info, status
---
Use `:TSModuleInfo` to see available treesitter modules and their status.

#### Example

```vim
:TSModuleInfo  " show treesitter module info
```
===
# Title: Treesitter folding
# Category: Treesitter
# Tags: treesitter, folding, code, structure
---
Set `foldmethod=expr` and `foldexpr=nvim_treesitter#foldexpr()` to use treesitter-based folding.

#### Example

```vim
:set foldmethod=expr
:set foldexpr=nvim_treesitter#foldexpr()
```
===
# Title: Treesitter query editor
# Category: Treesitter
# Tags: treesitter, query, editor, test
---
Use `:EditQuery` to edit treesitter queries with live preview and testing.

#### Example

```vim
:EditQuery highlights  " edit highlight queries
:EditQuery textobjects " edit textobject queries
```
===
# Title: Treesitter node navigation
# Category: Treesitter
# Tags: treesitter, navigation, nodes, movement
---
Use `]f` and `[f` to navigate between function nodes, or `]c` and `[c` for class nodes (if configured).

#### Example

```vim
]f  " next function
[f  " previous function
]c  " next class
[c  " previous class
```
===
# Title: Treesitter swap nodes
# Category: Treesitter
# Tags: treesitter, swap, parameters, arguments
---
Use treesitter to swap function parameters or other syntax nodes using configured keymaps.

#### Example

```vim
gs  " swap with next parameter/node
gS  " swap with previous parameter/node
```
===
# Title: Treesitter install parser
# Category: Treesitter
# Tags: treesitter, install, parser, language
---
Use `:TSInstall <language>` to install treesitter parser for a specific language.

#### Example

```vim
:TSInstall lua        " install Lua parser
:TSInstall javascript " install JavaScript parser
:TSInstall all        " install all maintained parsers
```
===
# Title: Treesitter update parsers
# Category: Treesitter
# Tags: treesitter, update, parsers, maintenance
---
Use `:TSUpdate` to update all installed treesitter parsers to latest versions.

#### Example

```vim
:TSUpdate  " update all parsers
```
===
# Title: Treesitter context
# Category: Treesitter
# Tags: treesitter, context, sticky, headers
---
Use treesitter context to show function/class headers at top of screen when scrolling.

#### Example

```vim
:TSContextEnable   " enable context
:TSContextDisable  " disable context
:TSContextToggle   " toggle context
```
===