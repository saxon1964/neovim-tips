View registers
# Title: View registers
# Category: Registers
# Tags: registers, clipboard, view
---
Use `:registers` to show the contents of all registers.

#### Example

```vim
:registers
```
===

System clipboard
# Title: System clipboard
# Category: Registers
# Tags: clipboard, system, yank
---
Use `"+y` to yank to the system clipboard and `"+p` to paste from the system clipboard.

#### Example

```vim
"+y  " yank to system clipboard
"+p  " paste from system clipboard
```
===

Use specific register
# Title: Use specific register
# Category: Registers
# Tags: registers, yank, specific
---
Use `"xy` to yank into specific register x. Replace x with any letter or number.

#### Example

```vim
"ay  " yank into register a
"bp  " paste from register b
```
===

Paste last yanked text
# Title: Paste last yanked text
# Category: Registers
# Tags: paste, yank, register
---
Use `"0p` to paste the last yanked text (ignoring deletions).

#### Example

```vim
"0p  " paste last yanked text
```
===

Delete without affecting register
# Title: Delete without affecting register
# Category: Registers
# Tags: delete, register, blackhole
---
Use `"_d` to delete text without affecting the default register (sends to blackhole register).

#### Example

```vim
"_d  " delete to blackhole register
```
===

Set register manually
# Title: Set register manually
# Category: Registers
# Tags: register, set, manual
---
Use `:let @a='text'` to manually set the contents of register a.

#### Example

```vim
:let @a='hello world'  " set register a to 'hello world'
```
===
