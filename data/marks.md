# Title: Set marks
# Category: Marks
# Tags: marks, position, bookmark
---
Use `m{letter}` to set a mark at current position. Use lowercase letters for file-specific marks and uppercase for global marks.

#### Example

```vim
ma  " set mark 'a'
mB  " set global mark 'B'
```
***
# Title: Jump to marks
# Category: Marks
# Tags: marks, jump, navigation
---
Use `'{letter}` to jump to beginning of line with mark, or \`{letter}\` to jump to exact mark position.

#### Example

```vim
'a   " jump to line with mark 'a'
`a   " jump to exact position of mark 'a'
```
***
