# Title: Text objects - inside brackets
# Category: Text Objects
# Tags: textobject, brackets, inside
---
Use `ci(`, `ci[`, `ci{` to change inside parentheses, square brackets, or curly braces. Works with `d`, `y`, `v` too.

#### Example

```vim
ci(  " change inside parentheses
di[  " delete inside square brackets
yi{  " yank inside curly braces
```
===
# Title: Text objects - around brackets
# Category: Text Objects
# Tags: textobject, brackets, around
---
Use `ca(`, `ca[`, `ca{` to change around parentheses, square brackets, or curly braces including the brackets.

#### Example

```vim
ca(  " change around parentheses
da[  " delete around square brackets
ya{  " yank around curly braces
```
===
# Title: Text objects - sentences and paragraphs
# Category: Text Objects
# Tags: textobject, sentence, paragraph
---
Use `is`/`as` for inside/around sentence and `ip`/`ap` for inside/around paragraph.

#### Example

```vim
cis  " change inside sentence
das  " delete around sentence
vip  " select inside paragraph
yap  " yank around paragraph
```
===
# Title: Text objects - word variations
# Category: Text Objects
# Tags: textobject, word, inner
---
Use `iw` for inside word, `aw` for around word (includes space), `iW` for inside WORD, `aW` for around WORD.

#### Example

```vim
ciw  " change inside word
daw  " delete around word (includes space)
yiW  " yank inside WORD (space-separated)
```
===
# Title: Select inside quotes
# Category: Text Objects
# Tags: select, quotes, inside
---
Use `vi"` to select text inside double quotes or `vi'` for single quotes.

#### Example

```vim
vi"  " select inside double quotes
vi'  " select inside single quotes
```
===
# Title: Select around parentheses
# Category: Text Objects
# Tags: select, parentheses, around
---
Use `va(` to select text around parentheses (including the parentheses).

#### Example

```vim
va(  " select around parentheses
```
===
# Title: Text objects - quoted strings
# Category: Text Objects
# Tags: textobject, quotes, strings
---
Use `i"` and `a"` for double-quoted strings, `i'` and `a'` for single-quoted strings, `` i` `` and `` a` `` for backtick strings.

#### Example

```vim
ci"  " change inside double quotes
da'  " delete around single quotes
yi`  " yank inside backticks
```
===
# Title: Text objects - angle brackets
# Category: Text Objects
# Tags: textobject, angle, brackets
---
Use `i<` and `a<` (or `i>` and `a>`) to operate inside/around angle brackets.

#### Example

```vim
ci<  " change inside angle brackets
da>  " delete around angle brackets
vi<  " select inside angle brackets
```
===
# Title: Text objects - square brackets
# Category: Text Objects
# Tags: textobject, square, brackets
---
Use `i[` and `a[` (or `i]` and `a]`) to operate inside/around square brackets.

#### Example

```vim
ci[  " change inside square brackets
da]  " delete around square brackets
yi[  " yank inside square brackets
```
===
# Title: Text objects - HTML/XML tags
# Category: Text Objects
# Tags: textobject, html, xml, tags
---
Use `it` for inside HTML/XML tags and `at` for around tags including the tag markup.

#### Example

```vim
cit  " change inside HTML tag
dat  " delete around HTML tag
yit  " yank inside tag content
vat  " select around tag including markup
```
===
# Title: Text objects - alternative bracket notation
# Category: Text Objects
# Tags: textobject, brackets, alternatives
---
Use `ib` or `ab` as alternatives for `i(` or `a(`, and `iB` or `aB` as alternatives for `i{` or `a{`.

#### Example

```vim
cib  " change inside parentheses  - same as ci(, enters insert mode
dab  " delete around parentheses  - same as da(
yiB  " yank inside curly braces   - same as yi{
vib  " select inside parentheses  - same as vi(
vab  " select around parentheses  - sane as va(
vaB  " select around curly braces - same as va{
viB  " select inside curly braces - same as vi{
```
===
# Title: Text objects with operators
# Category: Text Objects
# Tags: textobject, operators, combinations
---
Text objects work with all operators: `c` (change), `d` (delete), `y` (yank), `v` (visual select), `=` (format), `>` (indent right), `<` (indent left).

#### Example

```vim
=ap  " format around paragraph
>i{  " indent inside curly braces
<as  " unindent around sentence
```
===
