Record macro
# Title: Record macro
# Category: Macros
# Tags: macro, record, automation
---
Use `q{letter}` to start recording a macro into register {letter}, then `q` again to stop recording.

#### Example

```vim
qa  " start recording macro 'a'
q   " stop recording
```
===

Execute macro
# Title: Execute macro
# Category: Macros
# Tags: macro, execute, replay
---
Use `@{letter}` to execute macro stored in register {letter}, or `@@` to repeat the last executed macro.

#### Example

```vim
@a  " execute macro 'a'
@@  " repeat last macro
```
===

Run macro over visual selection
# Title: Run macro over visual selection
# Category: Macros
# Tags: macro, visual, selection
---
Use `:'<,'>normal @q` to run macro q over visual selection.

#### Example

```vim
:'<,'>normal @q  " run macro q on selection
```
===
