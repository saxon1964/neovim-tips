# Title: View jump list
# Category: Navigation
# Tags: jump, list, view
---
Use `:jumps` to show the jump list with all stored positions.

#### Example

```vim
:jumps  " show jump list
```
***
# Title: Go to file and open URL under cursor
# Category: Navigation
# Tags: file, cursor, goto, url, gf, gx
---
Use `gf` to open the file whose name is under the cursor, or `gx` to open URLs/links in external browser.

```vim
gf  " go to file under cursor (path/to/file.txt)
gx  " open URL under cursor in browser (https://example.com)
```
***
# Title: LSP go to references
# Category: Navigation
# Tags: lsp, references, goto
---
Use `gr` to go to references of symbol under cursor (requires LSP server).

#### Example

```vim
gr  " go to references
```
***
# Title: Go to declaration
# Category: Navigation
# Tags: lsp, declaration, goto
---
Use `gD` to go to declaration of symbol under cursor.

#### Example

```vim
gD  " go to declaration
```
***
# Title: Jump to last edit location
# Category: Navigation
# Tags: edit, location, jump
---
Use `` `. `` to jump to the exact location of the last edit.

#### Example

```vim
`.  " jump to last edit location
```
***
# Title: List jump locations
# Category: Navigation
# Tags: jump, list, history
---
Use `:ju` to list all jump locations in the jump list.

#### Example

```vim
:ju  " list jump locations
```
***
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

# Title: Quickfix navigation with bracket commands
# Category: Navigation
# Tags: quickfix, navigation, bracket, [q, ]q, [l, ]l
---
Use `[q` and `]q` to navigate quickfix items, `[l` and `]l` for location list items.

```vim
[q    " go to previous quickfix item
]q    " go to next quickfix item
[l    " go to previous location list item
]l    " go to next location list item
```
***
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
***
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
***
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
***
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
***
# Title: Jump to definition with split
# Category: Navigation
# Tags: definition, split, window, tags
---
Use `Ctrl+W ]` to open tag definition in new split window.

#### Example

```vim
Ctrl+W ]  " open tag in split
```
***
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
***
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
***
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
***
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
***
# Title: Square bracket navigation - unmatched brackets
# Category: Navigation
# Tags: bracket, unmatched, navigation
---
Use `[(` and `])` to jump to unmatched parentheses, `[{` and `]}` to jump to unmatched braces.

#### Example

```vim
[(  " jump to previous unmatched (
])  " jump to next unmatched )
[{  " jump to previous unmatched {
]}  " jump to next unmatched }
```
***
# Title: Square bracket navigation - sections
# Category: Navigation
# Tags: section, navigation, document
---
Use `[[` and `]]` to jump between sections, `[]` and `][` to jump between SECTIONS (different formatting).

#### Example

```vim
[[  " jump to previous section
]]  " jump to next section
[]  " jump to previous SECTION
][  " jump to next SECTION
```
***
# Title: Square bracket navigation - marks
# Category: Navigation
# Tags: mark, navigation, position
---
Use `['` and `]'` to jump to previous/next lowercase mark (first non-blank), `` [` `` and `` ]` `` to jump to exact mark position.

#### Example

```vim
['  " jump to previous mark (first non-blank)
]'  " jump to next mark (first non-blank)
[`  " jump to previous mark (exact position)
]`  " jump to next mark (exact position)
```
***
# Title: Square bracket navigation - C comments
# Category: Navigation
# Tags: comment, C, navigation
---
Use `[/` and `]/` to jump to start/end of C-style comments. Use `[*` as alternative to `[/`.

#### Example

```vim
[/  " jump to previous start of C comment
]/  " jump to next end of C comment
[*  " same as [/ (alternative)
]*  " same as ]/ (alternative)
```
***
# Title: Square bracket navigation - preprocessing
# Category: Navigation
# Tags: preprocessing, define, include
---
Use `[#` and `]#` to jump between #if/#else/#endif blocks.

#### Example

```vim
[#  " jump to previous #if, #else, or #ifdef
]#  " jump to next #endif or #else
```
***
# Title: Square bracket navigation - definitions and includes
# Category: Navigation
# Tags: definition, include, search
---
Use `[Ctrl+d`/`]Ctrl+d` to jump to #define, `[Ctrl+i`/`]Ctrl+i` to jump to lines containing word under cursor.

#### Example

```vim
[Ctrl+d  " jump to previous #define matching word
]Ctrl+d  " jump to next #define matching word
[Ctrl+i  " jump to previous line containing word
]Ctrl+i  " jump to next line containing word
```
***
# Title: Square bracket navigation - list definitions
# Category: Navigation
# Tags: list, definition, search, include
---
Use `[D`/`]D` to list all #defines, `[I`/`]I` to list all lines containing word under cursor.

#### Example

```vim
[D  " list all #defines matching word under cursor
]D  " list all #defines matching word under cursor  
[I  " list all lines containing word under cursor
]I  " list all lines containing word under cursor
```
***
# Title: Square bracket navigation - show definitions
# Category: Navigation
# Tags: show, definition, preview
---
Use `[d`/`]d` to show first #define, `[i`/`]i` to show first line containing word under cursor.

#### Example

```vim
[d  " show first #define matching word
]d  " show first #define matching word
[i  " show first line containing word
]i  " show first line containing word
```
***
# Title: Square bracket navigation - changes and diffs
# Category: Navigation
# Tags: change, diff, navigation
---
Use `[c` and `]c` to jump between changes in diff mode.

#### Example

```vim
[c  " jump to previous change
]c  " jump to next change
```
***
# Title: Square bracket navigation - spelling
# Category: Navigation
# Tags: spelling, error, navigation
---
Use `[s` and `]s` to jump between misspelled words.

#### Example

```vim
[s  " jump to previous misspelled word
]s  " jump to next misspelled word
```
***
# Title: Square bracket navigation - folds
# Category: Navigation
# Tags: fold, navigation, code
---
Use `[z` and `]z` to jump to start/end of open fold.

#### Example

```vim
[z  " jump to start of open fold
]z  " jump to end of open fold
```
***
# Title: Square bracket navigation - member functions
# Category: Navigation
# Tags: function, member, class, navigation
---
Use `[m` and `]m` to jump between member function starts.

#### Example

```vim
[m  " jump to previous start of member function
]m  " jump to next start of member function
```
***
# Title: Toggle netrw file explorer
# Category: Navigation
# Tags: netrw, explorer, toggle, file, browser
---
Use `:Lexplore` to toggle the netrw file explorer in a vertical split on the left side.

#### Example

```vim
:Lexplore    " toggle left explorer
:Vexplore    " open explorer in vertical split
:Sexplore    " open explorer in horizontal split
:Explore     " open explorer in current window
```
***
# Title: Jump between matching pair of parenthesis `([{...}])`
# Category: Navigation
# Tags: parenthesis
---
Position your cursor on `(`, `)`, `[`, `]`, `{`, `}`. Use `%` to jump between corresponding opening and closing symbols.

### Example

```vim
%   "jumps between corresponding parenthesis
```
***
