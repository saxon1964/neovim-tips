# Title: View registers
# Category: Registers
# Tags: registers, clipboard, view
---
Use `:registers` to show the contents of all registers.

```vim
:registers
```
***
# Title: System clipboard
# Category: Registers
# Tags: clipboard, system, yank
---
Use `"+y` to yank to the system clipboard and `"+p` to paste from the system clipboard.

```vim
"+y  " yank to system clipboard
"+p  " paste from system clipboard
```
***
# Title: Use specific register
# Category: Registers
# Tags: registers, yank, specific
---
Use `"xy` to yank into specific register x. Replace x with any letter or number.

```vim
"ay  " yank into register a
"bp  " paste from register b
```
***
# Title: Delete without affecting register
# Category: Registers
# Tags: delete, register, blackhole
---
Use `"_d` to delete text without affecting the default register (sends to blackhole register).

```vim
"_d  " delete to blackhole register
```
***
# Title: Set register manually
# Category: Registers
# Tags: register, set, manual
---
Use `:let @a='text'` to manually set the contents of register a.

```vim
:let @a='hello world'  " set register a to 'hello world'
```
***
# Title: Clear specific register
# Category: Registers
# Tags: register, clear, empty, macro
---
Use `q{register}q` to clear/empty a specific register by recording an empty macro.

```vim
qAq    " clear register 'A'
qaq    " clear register 'a'  
q1q    " clear register '1'
q:q    " clear command register
```
***
# Title: Get current buffer path in register
# Category: Registers
# Tags: buffer, path, filename, register, clipboard
---
Use `"%p` to paste current filename, `:let @+=@%` to copy buffer name to system clipboard.

```vim
"%p            " paste current filename
":let @+=@%     " copy current buffer name to system clipboard
":let @"=@%     " copy current buffer name to default register
```
***
# Title: Paste without overwriting register
# Category: Registers
# Tags: paste, register, overwrite, visual, multiple
---
Use `P` (capital) in visual mode to paste without overwriting the register, allowing multiple pastes.

```vim
" Select text, then:
P     " paste without overwriting register (can repeat)
p     " paste and overwrite register with selected text
```
***
# Title: Append to register
# Category: Registers
# Tags: register, append, uppercase
---
Use uppercase letter to append to a register instead of replacing its contents.

```vim
"ayy   " yank line into register a
"Ayy   " append line to register a (note uppercase A)
"ap    " paste both lines from register a
```
***