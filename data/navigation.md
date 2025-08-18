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

Jump to tag under cursor
# Title: Jump to tag under cursor
# Category: Navigation
# Tags: tags, jump, definition, ctags
---
Use `Ctrl+]` to jump to tag under cursor, or `Ctrl+T` to jump back. Requires tags file.

#### Example

```vim
Ctrl+]  " jump to tag
Ctrl+T  " jump back
```
===

Navigate to alternate file
# Title: Navigate to alternate file
# Category: Navigation
# Tags: alternate, file, header, source
---
Use `:A` to switch to alternate file (e.g., .h to .c), or `Ctrl+^` to switch to previous buffer.

#### Example

```vim
:A      " alternate file
Ctrl+^  " previous buffer
```
===

Jump to definition with split
# Title: Jump to definition with split
# Category: Navigation
# Tags: definition, split, window, tags
---
Use `Ctrl+W ]` to open tag definition in new split window.

#### Example

```vim
Ctrl+W ]  " open tag in split
```
===

Buffer switching shortcuts
# Title: Buffer switching shortcuts
# Category: Navigation
# Tags: buffer, switching, shortcuts, quick
---
Use `:ls` to list buffers, `:b#` for previous buffer, or create mappings for quick buffer navigation.

#### Example

```vim
:ls         " list all buffers
:b#         " switch to previous buffer
Ctrl+^      " alternate between current and previous buffer
:b partial  " switch to buffer matching partial name
```
===

Jump to random line
# Title: Jump to random line
# Category: Navigation
# Tags: random, line, jump, goto
---
Use `:{number}G` or `:{number}` to jump to specific line, or `:echo line('$')` to see total lines.

#### Example

```vim
:42G        " jump to line 42
:42         " jump to line 42 (alternative)
G           " jump to last line
:echo line('$')  " show total number of lines
```
===

Fast buffer access
# Title: Fast buffer access
# Category: Navigation
# Tags: buffer, fast, access, number
---
Create mappings to quickly access first nine buffers using leader key combinations.

#### Example

```vim
nnoremap <leader>1 :1b<CR>
nnoremap <leader>2 :2b<CR>
nnoremap <leader>3 :3b<CR>
nnoremap <leader>4 :4b<CR>
nnoremap <leader>5 :5b<CR>
" Continue for buffers 6-9
```
===

Jump to matching brace
# Title: Jump to matching brace
# Category: Navigation
# Tags: brace, bracket, matching, jump
---
Use `%` to jump to matching brace/bracket/parenthesis, works with (), [], {}, and more.

#### Example

```vim
%   " jump to matching brace/bracket/parenthesis
[%  " jump to previous unmatched (
]%  " jump to next unmatched )
```
===
