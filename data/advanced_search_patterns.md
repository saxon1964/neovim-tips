# Title: Character classes in search
# Category: Advanced Search
# Tags: regex, character, class, range, search
---
Use `[abc]` to match any of a, b, or c. Use `[a-z]` for ranges, `[^abc]` for negation.

```vim
/[aeiou]        " match any vowel
/[0-9]          " match any digit
/[a-zA-Z]       " match any letter
/[^0-9]         " match any non-digit
/[[:alpha:]]    " match alphabetic characters
/[[:digit:]]    " match digits
```
***
# Title: Quantifiers in search patterns
# Category: Advanced Search
# Tags: regex, quantifier, repeat, match
---
Use `*` for zero or more, `+` for one or more, `?` for zero or one, `{n}` for exactly n.

```vim
/ab*            " a followed by zero or more b's
/ab+            " a followed by one or more b's (very magic: /\vab+)
/ab?            " a followed by zero or one b (very magic: /\vab?)
/ab{3}          " a followed by exactly 3 b's (very magic: /\vab{3})
/ab{2,5}        " a followed by 2 to 5 b's (very magic: /\vab{2,5})
```
***
# Title: Anchors and word boundaries
# Category: Advanced Search
# Tags: regex, anchor, boundary, word, line
---
Use `^` for line start, `$` for line end, `\<` and `\>` for word boundaries.

```vim
/^hello         " 'hello' at beginning of line
/hello$         " 'hello' at end of line
/\<word\>       " exact word 'word' with boundaries
/\<\u\w*\>      " word starting with uppercase letter
```
***
# Title: Lookahead and lookbehind patterns
# Category: Advanced Search
# Tags: regex, lookahead, lookbehind, assertion
---
Use `\@=` for positive lookahead, `\@!` for negative lookahead, `\@<=` for positive lookbehind, `\@<!` for negative lookbehind.

```vim
/hello\@=world      " 'hello' followed by 'world'
/hello\@!           " 'hello' NOT followed by anything
/\@<=good morning   " 'morning' preceded by 'good'
/\@<!bad morning    " 'morning' NOT preceded by 'bad'
```
***
# Title: Non-greedy matching
# Category: Advanced Search
# Tags: regex, non-greedy, lazy, minimal
---
Use `{-}` for non-greedy version of `*`, `{-n,m}` for non-greedy quantified matching.

```vim
/".*"           " greedy: matches entire "hello" "world"
/".{-}"         " non-greedy: matches "hello" and "world" separately
/a.\{-}b        " non-greedy: shortest match from 'a' to 'b'
```
***
# Title: Special characters and escaping
# Category: Advanced Search
# Tags: regex, escape, special, character, literal
---
Use `\` to escape special characters. Common escapes: `\.` for literal dot, `\\` for backslash, `\*` for asterisk.

```vim
/file\.txt      " literal dot in 'file.txt'
/C:\\path       " literal backslashes in path
/\$price        " literal dollar sign
/\[bracket\]    " literal square brackets
```
***
# Title: Case sensitivity control
# Category: Advanced Search
# Tags: case, sensitive, insensitive, ignore, match
---
Use `\c` for case insensitive, `\C` for case sensitive, `\%#=1` for old regex engine.

```vim
/hello\c        " case insensitive search
/Hello\C        " case sensitive search
/\c\<WORD\>     " case insensitive word boundary
/\%#=1pattern   " use old regex engine (sometimes faster)
```
***
# Title: Column and line position matching
# Category: Advanced Search
# Tags: position, column, line, range, specific
---
Use `\%23l` for line 23, `\%23c` for column 23, `\%>23l` for after line 23.

```vim
/\%23lpattern   " pattern only on line 23
/\%>10l\%<20l   " pattern between lines 10 and 20
/\%5cword       " 'word' starting at column 5
/\%>50ctext     " 'text' after column 50
```
***
# Title: Virtual column matching
# Category: Advanced Search
# Tags: virtual, column, tab, display, width
---
Use `\%23v` for virtual column 23 (accounts for tab display width).

```vim
/\%8vpattern    " pattern at virtual column 8
/\%>20vtext     " text after virtual column 20
/\%<10v\S       " non-whitespace before virtual column 10
```
***
# Title: Mark position matching
# Category: Advanced Search
# Tags: mark, position, range, between
---
Use `\%'m` to match at mark m, `\%>'a` for after mark a, `\%<'b` for before mark b.

```vim
/\%'apattern    " pattern at mark 'a' position
/\%>'a\%<'b     " between marks 'a' and 'b'
/\%>'<\%<'>     " within last visual selection
```
***
# Title: Composing complex patterns
# Category: Advanced Search
# Tags: complex, combine, pattern, advanced
---
Combine multiple regex features for sophisticated pattern matching.

```vim
/\v^(\s*)(class|function)\s+\w+\s*\(
" Very magic pattern matching:
" - Line start with optional whitespace
" - 'class' or 'function' keyword
" - Whitespace and word (name)
" - Opening parenthesis

/\v<(https?|ftp)://[^\s]+>
" URL matching pattern
```
***
# Title: Search history and repetition
# Category: Advanced Search
# Tags: history, repeat, search, previous
---
Use `/` then arrow keys to navigate search history, `/<Up>` to recall previous searches.

```vim
/<Up>           " previous search in history
/<Down>         " next search in history
/<C-p>          " previous search (alternative)
/<C-n>          " next search (alternative)
//              " repeat last search
```
***
# Title: Search with confirmation
# Category: Advanced Search
# Tags: confirm, interactive, replace, substitute
---
Use the `c` flag in substitute commands for interactive confirmation.

```vim
:%s/old/new/gc  " global replace with confirmation
:g/pattern/s/old/new/c  " replace on matching lines with confirmation
```

Prompts: `y`es, `n`o, `a`ll, `q`uit, `l`ast, `^E` scroll down, `^Y` scroll up.
***
# Title: Multiline pattern matching
# Category: Advanced Search
# Tags: multiline, pattern, across, lines
---
Use `\_` prefix for character classes that include newlines.

```vim
/function\_.\{-}end     " match function to end across lines
/\_^pattern             " pattern at start of any line
/\_$                    " end of any line
/\_s\+                  " one or more whitespace including newlines
/\_[a-z]                " any lowercase letter or newline
```
***
# Title: Zero-width assertions
# Category: Advanced Search
# Tags: zero-width, assertion, position, match
---
Use zero-width patterns to match positions without consuming characters.

```vim
/\zs\w\+\ze@        " match word before @, highlight only word
/.*\zs\w\+$         " match last word on line
/^\zs\s\+           " match leading whitespace (for highlighting)
```
***
# Title: Branch and alternation
# Category: Advanced Search
# Tags: branch, alternation, or, choice
---
Use `\|` for alternation (OR), `\%(...\)` for grouping without capturing.

```vim
/hello\|world       " match 'hello' OR 'world'
/\(foo\|bar\)baz    " match 'foobaz' or 'barbaz'
/\%(red\|blue\)     " non-capturing group for 'red' or 'blue'
```
***
# Title: Recursive patterns
# Category: Advanced Search
# Tags: recursive, pattern, nested, structure
---
Use `\%(\)` and backreferences for matching nested structures.

```vim
/([^()]*\([^()]*\)[^()]*)   " match balanced parentheses (simple)
/\v"([^"\\]|\\.)*"          " match quoted strings with escapes
```
***
# Title: Search in specific file types
# Category: Advanced Search
# Tags: filetype, specific, extension, file
---
Combine search with file patterns for targeted searching.

```vim
:vimgrep /pattern/ **/*.py      " search in Python files only
:grep -r "pattern" --include="*.js" .   " external grep in JS files
:lvimgrep /function/ *.lua      " local search in Lua files
```
***
# Title: Pattern modifiers and flags
# Category: Advanced Search
# Tags: modifier, flag, option, behavior
---
Use various flags to modify search behavior and pattern interpretation.

```vim
/pattern/e      " position cursor at end of match
/pattern/s      " set search pattern but don't jump
/pattern/b      " search backward
/pattern/+2     " position cursor 2 lines after match
/pattern;/next  " search for pattern, then search for 'next'
```
***
# Title: Search and replace with expressions
# Category: Advanced Search
# Tags: expression, function, dynamic, replace
---
Use `\=` in replacement to evaluate expressions dynamically.

```vim
:%s/\d\+/\=submatch(0)*2/g      " double all numbers
:%s/$/\=' - line '.line('.')/   " add line numbers at end
:%s/\w\+/\=len(submatch(0))/g   " replace words with their length
```
***
# Title: Search context and ranges
# Category: Advanced Search
# Tags: context, range, scope, limit
---
Use ranges and context to limit search scope effectively.

```vim
:+5,+10s/old/new/g      " replace from 5 to 10 lines below cursor
:.,/pattern/s/a/b/g     " replace from cursor to first pattern match
:/start/,/end/s/x/y/g   " replace between start and end patterns
```
***
# Title: Very magic mode shortcuts
# Category: Advanced Search
# Tags: very-magic, shortcut, intuitive, regex
---
Use `\v` to make regex more like standard regex engines.

```vim
/\v(word1|word2)+           " one or more of word1 or word2
/\v<\w+>@<email\.com        " word before email.com
/\v^\s*#\s*include          " C include statements
/\v(function|class)\s+\w+   " function or class definitions
```
***
# Title: Atom and group matching
# Category: Advanced Search
# Tags: atom, group, capture, match
---
Use `\(` and `\)` for grouping and capturing, `\1` to `\9` for backreferences.

```vim
/\(\w\+\)\s\+\1         " word repeated with whitespace
/\(.*\)\n\1             " duplicate lines
/\(<\w\+>\).\{-}\1      " XML/HTML tag pairs
:%s/\(\w\+\) \(\w\+\)/\2, \1/g  " swap first and last name
```
***
