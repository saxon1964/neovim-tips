Toggle case of character
# Title: Toggle case of character
# Category: Text Manipulation
# Tags: case, toggle, character
---
Use `~` to toggle case of character under cursor.

#### Example

```vim
~  " toggle character case
```
===

Lowercase/uppercase current line
# Title: Lowercase/uppercase current line
# Category: Text Manipulation
# Tags: case, line, transform
---
Use `guu` to lowercase current line or `gUU` to uppercase current line.

#### Example

```vim
guu  " lowercase current line
gUU  " uppercase current line
```
===

Uppercase current word
# Title: Uppercase current word
# Category: Text Manipulation
# Tags: case, word, uppercase
---
Use `gUw` to uppercase current word.

#### Example

```vim
gUw  " uppercase current word
```
===

Sort paragraph
# Title: Sort paragraph
# Category: Text Manipulation
# Tags: sort, paragraph, formatting
---
Use `!}sort` to sort the next paragraph.

#### Example

```vim
!}sort  " sort next paragraph
```
===

Sort with remove duplicates
# Title: Sort with remove duplicates
# Category: Text Manipulation
# Tags: sort, duplicates, unique
---
Use `:sort u` to sort selected lines and remove duplicates.

#### Example

```vim
:sort u  " sort and remove duplicates
```
===

Format paragraph
# Title: Format paragraph
# Category: Text Manipulation
# Tags: format, paragraph, wrap
---
Use `gqap` to format/wrap a paragraph according to textwidth.

#### Example

```vim
gqap  " format around paragraph
```
===

Replace newlines with spaces
# Title: Replace newlines with spaces
# Category: Text Manipulation
# Tags: newlines, replace, spaces
---
Use `:%s/\n/ /g` to replace all newlines with spaces.

#### Example

```vim
:%s/\n/ /g  " replace newlines with spaces
```
===

Remove trailing whitespace
# Title: Remove trailing whitespace
# Category: Text Manipulation
# Tags: whitespace, trailing, clean
---
Use `:%s/\s\+$//` to remove trailing whitespace from all lines.

#### Example

```vim
:%s/\s\+$//  " remove trailing whitespace
```
===

Delete blank lines
# Title: Delete blank lines
# Category: Text Manipulation
# Tags: delete, blank, lines
---
Use `:g/^$/d` to delete all blank/empty lines in the buffer.

#### Example

```vim
:g/^$/d  " delete blank lines
```
===

Delete non-matching lines
# Title: Delete non-matching lines
# Category: Text Manipulation
# Tags: delete, pattern, inverse
---
Use `:v/pattern/d` to delete all lines that do NOT match the pattern.

#### Example

```vim
:v/TODO/d  " delete lines that don't contain 'TODO'
```
===
