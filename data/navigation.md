Jump list navigation
# Title: Jump list navigation
# Category: Navigation
# Tags: jump, list, position
---
Use `Ctrl+o` to jump to older position in jump list and `Ctrl+i` to jump to newer position.

#### Example

```vim
Ctrl+o  " jump to older position
Ctrl+i  " jump to newer position
```
===

View jump list
# Title: View jump list
# Category: Navigation
# Tags: jump, list, view
---
Use `:jumps` to show the jump list with all stored positions.

#### Example

```vim
:jumps  " show jump list
```
===

Go to file under cursor
# Title: Go to file under cursor
# Category: Navigation
# Tags: file, cursor, goto
---
Use `gf` to open the file whose name is under the cursor.

#### Example

```vim
gf  " go to file under cursor
```
===

LSP go to definition
# Title: LSP go to definition
# Category: Navigation
# Tags: lsp, definition, goto
---
Use `gd` to go to definition of symbol under cursor (requires LSP server).

#### Example

```vim
gd  " go to definition
```
===

LSP go to references
# Title: LSP go to references
# Category: Navigation
# Tags: lsp, references, goto
---
Use `gr` to go to references of symbol under cursor (requires LSP server).

#### Example

```vim
gr  " go to references
```
===

Go to declaration
# Title: Go to declaration
# Category: Navigation
# Tags: lsp, declaration, goto
---
Use `gD` to go to declaration of symbol under cursor.

#### Example

```vim
gD  " go to declaration
```
===

Jump to last edit location
# Title: Jump to last edit location
# Category: Navigation
# Tags: edit, location, jump
---
Use `` `. `` to jump to the exact location of the last edit.

#### Example

```vim
`.  " jump to last edit location
```
===

List jump locations
# Title: List jump locations
# Category: Navigation
# Tags: jump, list, history
---
Use `:ju` to list all jump locations in the jump list.

#### Example

```vim
:ju  " list jump locations
```
===

Navigate quickfix list
# Title: Navigate quickfix list
# Category: Navigation
# Tags: quickfix, navigation, errors
---
Use `:cnext` to go to next item in quickfix list and `:cprev` to go to previous item.

#### Example

```vim
:cnext  " next quickfix item
:cprev  " previous quickfix item
```
===

Jump to block boundaries
# Title: Jump to block boundaries
# Category: Navigation
# Tags: block, boundaries, jump
---
Use `[{` to jump to start of current block and `]}` to jump to end of current block.

#### Example

```vim
[{  " jump to block start
]}  " jump to block end
```
===

Jump between functions
# Title: Jump between functions
# Category: Navigation
# Tags: function, jump, treesitter
---
Use `]m` to jump to next function start and `[m` to jump to previous function start.

#### Example

```vim
]m  " next function start
[m  " previous function start
```
===
