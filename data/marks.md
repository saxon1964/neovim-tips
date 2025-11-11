# Title: Set marks
# Category: Marks
# Tags: marks, position, bookmark
---
Use `m{letter}` to set a mark at current position. Use lowercase letters for file-specific marks and uppercase for global marks.

```vim
ma  " set mark 'a'
mB  " set global mark 'B'
```
***
# Title: Jump to marks
# Category: Marks
# Tags: marks, jump, navigation
---
Use `'{letter}` to jump to beginning of line with mark, or `` `{letter} `` to jump to exact mark position.

```vim
'a   " jump to line with mark 'a'
`a   " jump to exact position of mark 'a'
```
***
# Title: Jump to last edit location (exact or non-blank)
# Category: Marks
# Tags: marks, jump, edit, last, position
---
Use `` `. `` to jump to exact position of last edit, or `'.` to jump to the line of last edit.

```vim
`.   " jump to exact position of last edit
'.   " jump to line of last edit (first non-blank)
```
***
# Title: Jump to last jump location
# Category: Marks
# Tags: marks, jump, last, position, navigation
---
Use `` ` ` `` (backtick-backtick) to jump to exact position before last jump, or `''` (quote-quote) to jump to the line.

```vim
``   " jump to exact position before last jump
''   " jump to line before last jump (first non-blank)
```

These are useful for quickly returning after exploring code with search, tag jumps, or other navigation commands.
***
