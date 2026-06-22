# Title: Insert at beginning/end
# Category: Editing
# Tags: insert, beginning, end
---
Use `s` to substitute character (delete and enter insert mode), `S` for entire line.

```vim
s  " substitute character
S  " substitute line
```

**Source:** Community contributed
***
# Title: Yank (copy) operations
# Category: Editing
# Tags: yank, copy, clipboard
---
Use `<C-r>=` in insert mode to calculate mathematical expressions and insert the result.

```vim
" In insert mode:
<C-r>=2+2<CR>       " inserts '4'
<C-r>=16*1024<CR>   " inserts '16384'
```

**Source:** Community contributed
***
# Title: Insert single character
# Category: Editing
# Tags: insert, character, single, quick
---
Use `i{char}<Esc>` or create mapping with `s` to quickly insert single character without staying in insert mode.

```vim
" Vimscript:
" Insert single character and return to normal mode
nnoremap <leader>i i_<Esc>r
" Or use s to substitute character:
s{char}<Esc>  " replace character under cursor
```

```lua
-- Lua:
-- Insert single character and return to normal mode
vim.keymap.set('n', '<leader>i', 'i_<Esc>r', { desc = 'Insert single character' })
-- Or use: s{char}<Esc> to substitute character under cursor
```

**Source:** Community contributed
***
# Title: Insert multiple lines
# Category: Editing
# Tags: insert, lines, multiple, batch
---
Use `o<Esc>` followed by repeat count, or `{count}o` to insert multiple empty lines at once.

```vim
5o<Esc>     " insert 5 empty lines below
5O<Esc>     " insert 5 empty lines above
" Or in normal mode:
o<Esc>4.    " insert line, then repeat 4 times
```

**Source:** Community contributed
***
# Title: Insert newline without entering insert mode
# Category: Editing
# Tags: newline, insert, normal, mode
---
Use `o<Esc>` to insert line below or `O<Esc>` to insert line above without staying in insert mode.

```vim
" Vimscript:
o<Esc>      " insert empty line below, stay in normal mode
O<Esc>      " insert empty line above, stay in normal mode
" Or map for convenience:
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>
```

```lua
-- Lua:
-- Use: o<Esc> or O<Esc> (built-in commands)
-- Or map for convenience:
vim.keymap.set('n', '<leader>o', 'o<Esc>', { desc = 'Insert line below' })
vim.keymap.set('n', '<leader>O', 'O<Esc>', { desc = 'Insert line above' })
```

**Source:** Community contributed
***
# Title: Ex commands - line operations
# Category: Editing
# Tags: ex, line, delete, copy, move, range
---
Use `:d` to delete lines, `:y` to yank, `:m` to move, `:co` or `:t` to copy, with ranges like `1,5` or `%`.

```vim
:5d           " delete line 5
:1,10d        " delete lines 1-10
:%d           " delete all lines
:%delete      " same as above
ggdG          " same as above
:5,10m 20     " move lines 5-10 to after line 20
:1,5co 10     " copy lines 1-5 to after line 10
```

**Source:** Community contributed
***
# Title: Ex commands - undo and redo
# Category: Editing
# Tags: ex, undo, redo, earlier, later
---
Use `:undo` and `:redo` for undo/redo, `:earlier` and `:later` for time-based undo.

```vim
:undo         " undo last change
:redo         " redo last undone change
:earlier 10m  " go back 10 minutes
:later 5s     " go forward 5 seconds
:earlier 10f  " go back 10 file states
```

**Source:** Community contributed
***
# Title: Ex commands - sorting and formatting
# Category: Editing
# Tags: ex, sort, format, center, left, right
---
Use `:edit +{line} {file}` to open file and jump directly to specified line number.

```vim
:edit +25 config.vim  " open config.vim at line 25
:edit +/pattern file.txt  " open file.txt at first line matching pattern
:edit +$ log.txt      " open log.txt at last line
vim +42 file.txt      " from command line: open at line 42
```

**Source:** Community contributed
***
# Title: Ex commands - joining and splitting
# Category: Editing
# Tags: ex, join, split, lines, combine
---
Use `:join` or `:j` to join lines, with count to join multiple lines.

```vim
:join         " join current line with next
:j            " short form of join
:5,8join      " join lines 5-8
:join!        " join without inserting spaces
```

**Source:** Community contributed
***
# Title: Ex commands - marks and jumps
# Category: Editing
# Tags: ex, marks, jump, position, navigate
---
Use `:mark` to set mark, `:jumps` to show jump list, `:changes` for change list, `:delmarks` to delete marks.

```vim
:mark a       " set mark 'a' at current line
:marks        " show all marks
:jumps        " show jump list
:changes      " show change list
:delmarks a   " delete mark 'a'
:delmarks!    " delete all lowercase marks
```

**Source:** Community contributed
***
# Title: Move line to end of paragraph
# Category: Editing
# Tags: move, line, paragraph, end, motion
---
Use `:m'}-1` to move current line to end of current paragraph.

```vim
:m'}-1        " move current line to end of paragraph
:m'}          " move current line after end of paragraph
:m'{-1        " move current line to start of paragraph
```

**Source:** Community contributed
***
# Title: Execute normal commands without mappings
# Category: Editing
# Tags: normal, command, mapping, script, execute
---
Use `normal!` in scripts to execute normal-mode commands without triggering user mappings.

```vim
" In a script or function:
normal! dd       " delete line without triggering dd mapping
normal! yy       " yank line without triggering yy mapping
execute "normal! \<C-v>j"  " block select down
```

**Source:** Community contributed
***
# Title: Substitute in all buffers
# Category: Editing
# Tags: substitute, buffer, all, bufdo, global
---
Use `:bufdo %s/old/new/ge` to substitute in all open buffers, `e` flag suppresses errors.

```vim
:bufdo %s/old/new/ge    " substitute in all buffers
:bufdo %s/TODO/DONE/ge  " replace TODO with DONE in all buffers
:bufdo update           " save all modified buffers
```

**Source:** Community contributed
***
# Title: Return to last exit position
# Category: Editing
# Tags: position, exit, return, mark, jump
---
Use mark `"0` to jump to position where Vim was last exited from current file.

```vim
`"0     " jump to last exit position
'"0     " jump to last exit position (line start)
:normal `"0  " execute from script/mapping
```

**Source:** Community contributed
***
# Title: Wrap text in HTML tags
# Category: Editing
# Tags: html, tag, wrap, surround, format
---
Use visual selection and substitute to wrap text in HTML tags.

```vim
" Select text in visual mode, then:
:'<,'>s/.*/\<p>&\<\/p>/   " wrap lines in <p> tags
:'<,'>s/.*/\<li>&\<\/li>/ " wrap lines in <li> tags
:'<,'>s/\(.*\)/\<strong>\1\<\/strong>/ " wrap in <strong> tags
```

**Source:** Community contributed
***
# Title: Copy and move lines to marks
# Category: Editing
# Tags: copy, move, mark, line, range
---
Use `:t` to copy lines to marks, `:.t'a` to copy current line to mark 'a', `:152,154t.` to copy range to current position.

```vim
ma           " set mark 'a' at current line
:.t'a        " copy current line to mark 'a'
:5,10t'b     " copy lines 5-10 to mark 'b'
:'<,'>t'a    " copy visual selection to mark 'a'
:152,154t.   " copy lines 152-154 to current position
```

**Source:** Community contributed
***
# Title: Increment search results
# Category: Editing
# Tags: increment, search, replace, counter, sequential
---
Use global command with counter to incrementally replace search results with sequential numbers.

```vim
" Replace all '2.gif' with incremental numbers:
:let idx=0 | g/2\.gif/ let idx += 1 | s//\= idx . '.gif'/

" Replace 'item' with numbered items:
:let n=1 | g/item/ s//\='item' . n/ | let n=n+1
```

**Source:** Community contributed
***
# Title: Global command with normal mode operations
# Category: Editing
# Tags: global, normal, command, pattern, batch
---
Use `:g/pattern/ normal {commands}` to execute normal mode commands on all matching lines.

```vim
:g/console.log/ normal gcc    " comment all lines with 'console.log'
:g/TODO/ normal dw            " delete first word on lines with 'TODO'
:g/function/ normal >>        " indent all lines containing 'function'
```

**Source:** Community contributed
***
# Title: Put text above or below current line
# Category: Editing
# Tags: put, paste, above, below, line
---
Use `:pu` to paste below current line, `:pu!` to paste above current line, regardless of cursor position.

```vim
:pu         " paste register contents below current line
:pu!        " paste register contents above current line
:pu a       " paste register 'a' below current line
:pu! a      " paste register 'a' above current line
```

**Source:** Community contributed
***
# Title: Select non-uniform strings across lines
# Category: Editing
# Tags: select, yank, append, register, pattern
---
Use normal mode with append register to collect text from multiple lines into one register.

```vim
" Yank text inside {} from multiple lines to register A:
:'<,'>norm "Ayi{

" Yank word under cursor from multiple lines:
:g/pattern/ normal "Ayiw

" Clear register first:
qAq
:'<,'>norm "Ayi{
```

**Source:** Community contributed
***
# Title: Move lines to marks
# Category: Editing
# Tags: move, marks, line, navigation
---
Fast abbreviations for inserting PHP debug statements

```vim
iab phpb exit("<hr>Debug ");
iab phpv echo "<hr><pre>";var_dump($a);exit("debug ");
iab phpallv print_r(get_defined_vars());
```

```lua
vim.cmd('iab phpb exit("<hr>Debug ");')
vim.cmd('iab phpv echo "<hr><pre>";var_dump($a);exit("debug ");')
vim.cmd('iab phpallv print_r(get_defined_vars());')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/$_instead_of_4)
***
# Title: Quick Heading Underline with Dashes
# Category: editing
# Tags: text-formatting, markdown, key-mapping
---
Quickly add dashed underlines to headings using a simple mapping or function, useful for markdown and documentation

```vim
" Underline the current line with dashes in normal mode
nnoremap <F5> yyp<c-v>$r-

" Underline the current line with dashes in insert mode
inoremap <F5> <Esc>yyp<c-v>$r-A
```

```lua
-- Underline current line with dashes in normal mode
vim.keymap.set('n', '<F5>', function()
  -- Duplicate current line
  vim.cmd('normal! yyp')
  -- Select entire line and replace with dashes
  vim.cmd('normal! V$r-')
end, { desc = 'Underline with dashes' })

-- Alternatively, with more explicit Lua commands
vim.keymap.set('n', '<F5>', function()
  local line = vim.api.nvim_get_current_line()
  local line_length = #line
  local underline = string.rep('-', line_length)
  
  vim.api.nvim_buf_set_lines(0, vim.fn.line('.'), vim.fn.line('.'), false, {line, underline})
end, { desc = 'Underline with dashes' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Add_a_dashed_line_under_a_title_in_text_documents)
***
# Title: Fast Print Statement Generation
# Category: editing
# Tags: debugging, code-generation, productivity
---
Quickly insert print/debug statements for C/C++ languages

```vim
" Shortcut to insert print statement
imap <F3> printf("DEBUG: ");<Left><Left>
```

```lua
vim.keymap.set('i', '<F3>', 'printf("DEBUG: ");<Left><Left>', { desc = 'Insert print statement' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/All_tips_for_C_family_programming)
***
# Title: Comment Code with Flexible Delimiters
# Category: editing
# Tags: commenting, search-replace, code-editing
---
Use alternative delimiters to easily comment out code ranges with less escaping

```vim
:5,8 s#^#//#
```

```lua
-- Comment lines 5-8 with // in Neovim
vim.cmd('5,8 s#^#//#')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Alternate_delimiters_for_the_replace_command)
***
# Title: Quick Word Completion in Insert Mode
# Category: editing
# Tags: completion, insert-mode, productivity
---
Quickly complete words by typing the first few characters and using Ctrl-N or Ctrl-P to cycle through matching completions

```vim
" In insert mode
Ctrl-N  " Complete next matching word
Ctrl-P  " Complete previous matching word
```

```lua
-- Neovim uses the same default behavior
-- No specific Lua configuration needed
-- Just use Ctrl-N and Ctrl-P in insert mode
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Any_word_completion)
***
# Title: Filter Text Using External Shell Commands
# Category: editing
# Tags: text-processing, shell-filter, visual-mode
---
Use Vim's filter functionality to process selected text through shell commands, enabling powerful text transformations

```vim
" Example filtering workflow
" 1. Select lines in visual mode
" 2. Press ! to filter
" 3. Enter command like 'cut -f2-3 -d,'
```

```lua
-- Lua note: Native Vim filtering works the same in Neovim
-- Use visual mode selection + ! to filter text
-- Example commands remain consistent with Vim
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Append_output_of_an_external_command)
***
# Title: Restore Cursor Position in Previous Session
# Category: editing
# Tags: persistence, cursor-position, workflow
---
Automatically return to the last cursor position when reopening a file, maintaining your editing context

```vim
augroup RestoreCursor
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup END
```

```lua
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local last_pos = vim.fn.line("'\"")
    if last_pos > 0 and last_pos <= vim.fn.line('$') then
      vim.cmd('normal! g`"')
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Authors)
***
# Title: Quickly Insert Current Date or Time
# Category: editing
# Tags: shortcuts, date-time, insert-mode
---
Create quick mappings to insert current date or time while editing

```vim
" Insert current date
map <F5> a<C-R>=strftime('%Y-%m-%d')<CR>
" Insert current time
map <F6> a<C-R>=strftime('%H:%M:%S')<CR>
```

```lua
-- Insert date mapping
vim.keymap.set('n', '<F5>', function()
  vim.api.nvim_put({os.date('%Y-%m-%d')}, 'c', true, true)
end, { desc = 'Insert current date' })

-- Insert time mapping
vim.keymap.set('n', '<F6>', function()
  vim.api.nvim_put({os.date('%H:%M:%S')}, 'c', true, true)
end, { desc = 'Insert current time' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Authors)
***
# Title: Auto-Close HTML Tags with Omni Completion
# Category: editing
# Tags: html, completion, auto-insert
---
Automatically complete closing HTML tags using Vim's omni completion in insert mode

```vim
" Abbreviation to auto-close HTML tags
:iabbrev <// </<C-X><C-O>

" Remap Ctrl-Space for tag completion
:imap <C-Space> <C-X><C-O>
```

```lua
-- Lua equivalent for auto-closing HTML tags
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = {'*.html', '*.js', '*.xml'},
  callback = function()
    vim.keymap.set('i', '>', function()
      return '>' .. '</>' .. vim.fn.complete(vim.fn.col('.'), vim.fn['compl#omnifunc']())
    end, { buffer = true, expr = true })
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Auto_closing_an_HTML_tag)
***
# Title: Auto Spelling Correction with Abbreviations
# Category: editing
# Tags: spelling, autocorrect, abbreviations
---
Automatically correct common misspellings and typos using Vim's abbreviation feature

```vim
iabbrev mispell misspell
iabbrev funciton function
iabbrev functiton function
iabbrev fucntion function
iabbrev funtion function
iabbrev erturn return
iabbrev retunr return
iabbrev reutrn return
iabbrev reutn return
```

```lua
-- Create abbreviations in Lua
vim.cmd([[iabbrev mispell misspell
iabbrev funciton function
iabbrev functiton function
iabbrev fucntion function
iabbrev funtion function
iabbrev erturn return
iabbrev retunr return
iabbrev reutrn return
iabbrev reutn return]])
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Auto_spelling_correction_using_abbreviations)
***
# Title: Reflow Paragraphs Quickly
# Category: editing
# Tags: text-editing, formatting, paragraph
---
Quickly reformat a paragraph to optimal line length using a single command

```vim
" Reflow the inner paragraph
gqip
```

```lua
-- Reflow the inner paragraph (works the same in Neovim)
vim.cmd('normal gqip')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Automatic_formatting_of_paragraphs)
***
# Title: Efficient Undo and Redo
# Category: editing
# Tags: undo, redo, history
---
Quickly undo and redo changes with simple commands

```vim
u       # Undo last change
Ctrl-r  # Redo last undone change
```

```lua
-- Set up undo/redo keymaps
vim.keymap.set('n', '<leader>u', 'u', { desc = 'Undo last change' })
vim.keymap.set('n', '<leader>r', '<C-r>', { desc = 'Redo last change' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Beginners_guide)
***
# Title: Autocomplete Words in Insert Mode
# Category: editing
# Tags: insert-mode, completion, productivity
---
Use Ctrl-N and Ctrl-P to autocomplete words from the current file

```vim
" In insert mode
<C-N>  " Complete word forward
<C-P>  " Complete word backward
```

```lua
-- Built-in completion
-- Configure with:
vim.opt.complete:append('k')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Best_Tips)
***
# Title: Powerful Text Case Manipulation
# Category: editing
# Tags: text-case, editing, transformation
---
Quickly change text case in normal mode using simple commands

```vim
guu     " lowercase line
gUU     " uppercase line
~       " invert case of current character
```

```lua
-- Lua equivalents for text case manipulation
-- Note: These are vim commands that work similarly in Neovim
-- vim.cmd('normal! guu')  -- lowercase line
-- vim.cmd('normal! gUU')  -- uppercase line
-- vim.cmd('normal! ~')    -- invert case of current character
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Best_of_VIM_Tips_(VIM%27s_best_Features))
***
# Title: Convert Between CamelCase and snake_case
# Category: editing
# Tags: text-transformation, case-conversion, regex
---
Provides flexible regex-based substitution commands to convert variable naming styles between CamelCase and snake_case, useful for code refactoring and consistent naming

```vim
" Convert snake_case to CamelCase
:s#_\([a-z]\)#\u\1#g

" Convert CamelCase to snake_case
:s#\C\(\<\u[a-z0-9]\+\|[a-z0-9]\+\)\(\u\)#\l\1_\l\2#g
```

```lua
-- Lua function to convert snake_case to CamelCase
function convert_to_camel_case(str)
  return str:gsub('_(%a)', function(letter)
    return letter:upper()
  end)
end

-- Lua function to convert CamelCase to snake_case
function convert_to_snake_case(str)
  return str:gsub('(%u)', function(letter)
    return '_' .. letter:lower()
  end):lower()
end
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/CamelCase)
***
# Title: Quickly Change Words and Lines
# Category: editing
# Tags: text-editing, key-mapping, productivity
---
Provides efficient ways to change words, lines, or text objects with simplified mappings

```vim
nmap pw :inoremap <lt>Space> <lt>Space><lt>Esc>:iunmap <lt>lt>Space><lt>CR><CR> cw

nmap p$ :inoremap <lt>CR> <lt>CR><lt>Esc>:iunmap <lt>lt>CR><lt>CR><CR> c$
```

```lua
-- Lua equivalent for quick word/line change
-- Note: This can be achieved more simply with native Neovim keymaps
vim.keymap.set('n', 'pw', function()
  vim.cmd('normal! cw')
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Space>', true, false, true), 'n', true)
end)

vim.keymap.set('n', 'p$', function()
  vim.cmd('normal! c$')
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, false, true), 'n', true)
end)
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Change_word_or_line_with_automatic_return_to_normal_mode)
***
# Title: Case Modification Techniques
# Category: editing
# Tags: text-case, regex-substitution
---
Use \U, \L, \u, and \l for comprehensive case transformation in regex substitutions

```vim
" Convert to uppercase with termination
:s/\(test\)/\U\1\e file/

" Uppercase first character
:s/\(test\)/\u\1/
```

```lua
-- Similar transformations can be done using vim.cmd()
-- Note: Lua will require escaping backslashes
vim.cmd(':s/\\(test\\)/\\U\\1\\e file/')
vim.cmd(':s/\\(test\\)/\\u\\1/')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Changing_case_with_regular_expressions)
***
# Title: Easy Comment/Uncomment for Multiple Languages
# Category: editing
# Tags: commenting, text-manipulation, multi-language
---
Dynamically set comment leaders for different file types, with easy comment/uncomment mappings

```vim
au FileType haskell,vhdl,ada let b:comment_leader = '-- '
au FileType vim let b:comment_leader = '" '
au FileType c,cpp,java let b:comment_leader = '// '
au FileType sh,make let b:comment_leader = '# '
au FileType tex let b:comment_leader = '% '

noremap <silent> ,c :<C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/') <CR>/<CR>:noh<CR>
noremap <silent> ,u :<C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/') <CR>//e<CR>:noh<CR>
```

```lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'haskell', 'vhdl', 'ada'},
  callback = function() vim.b.comment_leader = '-- ' end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'vim'},
  callback = function() vim.b.comment_leader = '" ' end
})

-- Similar autocmds for other filetypes

-- Comment mapping
vim.keymap.set('n', ',c', function()
  local comment_leader = vim.b.comment_leader or '// '
  vim.cmd('silent s/^/' .. vim.fn.escape(comment_leader, '\/') .. '/')
  vim.cmd('nohlsearch')
end)

-- Uncomment mapping
vim.keymap.set('n', ',u', function()
  local comment_leader = vim.b.comment_leader or '// '
  vim.cmd('silent s/^\\V' .. vim.fn.escape(comment_leader, '\/') .. '//')
  vim.cmd('nohlsearch')
end)
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Comment/UnComment_visually_selected_text)
***
# Title: Extend Word Completion with Precision
# Category: editing
# Tags: autocomplete, insert-mode, advanced-editing
---
Incrementally complete words by repeatedly pressing Ctrl-X Ctrl-P to refine matches

```vim
" In insert mode, use Ctrl-X Ctrl-P to extend word matches
```

```lua
-- Lua doesn't change the core Vim completion behavior
-- Use Ctrl-X Ctrl-P in insert mode to extend matches
-- Customize 'complete' option for broader matching
vim.opt.complete:append('i') -- include current and included files
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Completing_words_quickly_in_insert_mode)
***
# Title: Convert Enum to String Table Automatically
# Category: editing
# Tags: c-programming, code-generation, transformation
---
Quickly generate a string representation for enum values, useful for debugging and logging

```vim
function! Enum2Array()
    exe "normal! :'<,'>g/^\s*$/d\n"
    exe "normal! :'<,'>s/\(\s*\)\([[:alnum:]_]*\).*/\1[\2] = \"\2\",/\n"
    normal `>
    exe "normal a\n};\n"
    normal `<
    exe "normal iconst char *[] =\n{\n"
    exe ":'<,'>normal ==" " try some indentation
    normal `< " set the cursor at the top
endfunction
```

```lua
function _G.enum_to_array()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    
    -- Remove empty lines
    vim.cmd(start_line .. ',' .. end_line .. 'g/^\s*$/d')
    
    -- Transform enum entries to string array
    vim.cmd(start_line .. ',' .. end_line .. 's/\s*\(\w\+\)/[\1] = "\1",/')
    
    -- Add array declaration and closing brace
    vim.cmd('normal! O const char *[] = {\<Esc>')
    vim.cmd('normal! o};\<Esc>')
    
    -- Optionally reindent
    vim.cmd(start_line .. ',' .. end_line .. 'normal! ==')
end

-- Usage: Select enum lines and call the function
vim.keymap.set('x', '<leader>ce', _G.enum_to_array, { desc = 'Convert Enum to String Array' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Convert_enum_to_string_table)
***
# Title: Flexible Case Conversion with Visual Selection
# Category: editing
# Tags: text-transformation, visual-mode, custom-commands
---
Create custom commands to convert case within visual selections or entire lines

```vim
function! s:Camelize(range) abort
  if a:range == 0
    s#\(\%\(\<\l\+\)\%\(_\)\@=\)\|_\(\l\)#\u\1\2#g
  else
    s#\%V\(\%\(\<\l\+\)\%\(_\)\@=\)\|_\(\l\)\%V#\u\1\2#g
  endif
endfunction

command! -range CamelCase silent! call <SID>Camelize(<range>)
```

```lua
local function camelize(range)
  if range == 0 then
    vim.cmd('s#\\(\\%\\(\\<\\l\\+\\)\\%\\(_\\)\\@=\\)\\|_\\(\\l\\)#\\u\1\2#g')
  else
    vim.cmd('s#\\%V\\(\\%\\(\\<\\l\\+\\)\\%\\(_\\)\\@=\\)\\|_\\(\\l\\)\\%V#\\u\1\2#g')
  end
end

vim.api.nvim_create_user_command('CamelCase', function(opts)
  camelize(opts.range)
end, { range = true })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Converting_variables_to_camelCase)
***
# Title: Convert Variable Naming Styles
# Category: editing
# Tags: text-transformation, variable-naming, refactoring
---
Easily convert between camelCase, snake_case, and UPPER_CASE variable naming conventions

```vim
" Convert snake_case to CamelCase
:s#_\(\l\)#\u\1#g

" Convert CamelCase to snake_case
:s#\C\(\<\u[a-z0-9]\+\|[a-z0-9]\+\)\(\u\)#\l\1_\l\2#g
```

```lua
-- Convert snake_case to CamelCase
vim.cmd('s#_\(\l\)#\u\1#g')

-- Convert CamelCase to snake_case
vim.cmd('s#\C\(\<\u[a-z0-9]\+\|[a-z0-9]\+\)\(\u\)#\l\1_\l\2#g')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Converting_variables_to_or_from_camel_case)
***
# Title: Add Unicode Combining Characters to Text
# Category: editing
# Tags: unicode, text-formatting, advanced-editing
---
Add underlines, overlines, and strikethroughs using Unicode combining characters across selected text

```vim
" Define commands for adding combining characters
command! -range -nargs=0 Overline        call s:CombineSelection(<line1>, <line2>, '0305')
command! -range -nargs=0 Underline       call s:CombineSelection(<line1>, <line2>, '0332')
command! -range -nargs=0 DoubleUnderline call s:CombineSelection(<line1>, <line2>, '0333')
command! -range -nargs=0 Strikethrough   call s:CombineSelection(<line1>, <line2>, '0336')

function! s:CombineSelection(line1, line2, cp)
  execute 'let char = "\u'.a:cp.'"'
  execute a:line1.','.a:line2.'s/\%V[^[:cntrl:]]/&'.char.'/ge'
endfunction

" Optional mapping for quick access
vnoremap OO :Overline<CR>
```

```lua
-- Unicode combining character utility functions
local function combine_selection(line1, line2, cp)
  vim.cmd(string.format(
    '%d,%ds/\%%V[^[:cntrl:]]/&\u%s/ge',
    line1, line2, cp
  ))
end

-- Create commands for different text decorations
vim.api.nvim_create_user_command('Overline', function()
  combine_selection(vim.fn.line("'<"), vim.fn.line("'>"), '0305')
end, { range = true })

vim.api.nvim_create_user_command('Underline', function()
  combine_selection(vim.fn.line("'<"), vim.fn.line("'>"), '0332')
end, { range = true })

-- Optional keymapping
vim.keymap.set('v', 'OO', ':Overline<CR>', { desc = 'Apply overline to selected text' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Create_underlines,_overlines,_and_strikethroughs_using_combining_characters)
***
# Title: Delete XML/HTML Tags Efficiently
# Category: editing
# Tags: xml, html, text-objects, editing
---
Quickly delete a pair of XML or HTML tags using text objects, which works for both small and large tag blocks

```vim
vat<Esc>`<df>`>F<df>
```

```lua
-- Delete around tag (at text object)
-- Requires manual mapping in Lua
vim.keymap.set('n', '<leader>dt', function()
  vim.cmd('normal! vat<Esc>`<df>`>F<df>')
end, { desc = 'Delete XML/HTML tag pair' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Delete_a_pair_of_XML/HTML_tags)
***
# Title: Delete Lines Matching a Pattern
# Category: editing
# Tags: search-replace, text-manipulation, global-command
---
Use :g command to delete lines matching or not matching a specific pattern globally in the file

```vim
" Delete all lines containing 'profile'
:g/profile/d

" Delete empty or whitespace-only lines
:g/^\s*$/d

" Delete all lines not containing comments in Vim script
:g!/^\s*"/d
```

```lua
-- Delete lines containing 'profile'
vim.cmd('g/profile/d')

-- Delete empty or whitespace-only lines
vim.cmd('g/^\s*$/d')

-- Delete lines not containing comments in Vim script
vim.cmd('g!/^\s*"/d')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Delete_all_lines_containing_a_pattern)
***
# Title: Consistent Yank to End of Line
# Category: editing
# Tags: yank, text-objects, consistency
---
Makes 'Y' behave consistently with 'D' and 'C' by yanking to end of line

```vim
nnoremap Y y$
```

```lua
vim.keymap.set('n', 'Y', 'y$', { desc = 'Yank to end of line' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Delete_to_the_end_of_the_line)
***
# Title: Delete to Custom Delimiter Efficiently
# Category: editing
# Tags: text-editing, motion, deletion
---
Delete text up to a specific character, which is more flexible than standard word deletion

```vim
" Delete to space
df 

" Delete to period (end of sentence)
df.
```

```lua
-- Lua equivalents for custom delimiter deletion
-- Use native Vim motions, so no specific Lua translation needed
-- Can use 'df ' or 'df.' directly in Neovim
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Delete_words_in_a_different_way)
***
# Title: Alternative Word Deletion Methods
# Category: editing
# Tags: text-editing, word-deletion
---
Use different word deletion commands for more precise text removal

```vim
" Delete a WORD (includes special characters)
dW

" Delete up to (not including) a character
dt<char>
```

```lua
-- These are standard Vim motions that work identically in Neovim
-- No specific Lua translation required
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Delete_words_in_a_different_way)
***
# Title: Quick Email Thread Cleanup
# Category: editing
# Tags: email, text-manipulation, autocmd
---
Easily remove nested reply threads in email messages by deleting lines with multiple '>' characters

```vim
autocmd FileType mail map <F8> :%g/^> >/d<CR>
```

```lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'mail',
  callback = function()
    vim.keymap.set('n', '<F8>', function()
      vim.cmd('g/^> >/d')
    end, { buffer = true })
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Deleting_nested_reply_threads_in_emails)
***
# Title: Dictionary-Based Word Completion
# Category: editing
# Tags: completion, insert-mode, text-editing
---
Enable dictionary-based word completion to quickly insert words from a predefined dictionary, useful for writing and coding

```vim
" Set dictionary location
set dictionary+=/usr/share/dict/words

" Enable dictionary completion
set complete+=k

" Optional: Map F12 for dictionary completion
:inoremap <F12> <C-X><C-K>
```

```lua
-- Set dictionary location
vim.opt.dictionary:append('/usr/share/dict/words')

-- Enable dictionary completion
vim.opt.complete:append('k')

-- Optional: Map F12 for dictionary completion
vim.keymap.set('i', '<F12>', '<C-X><C-K>', { desc = 'Dictionary word completion' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Dictionary_completions)
***
# Title: Block Line Sorting with Global Command
# Category: editing
# Tags: sorting, text-manipulation, global-command
---
Sort each block of lines in a file, separating blocks by blank lines

```vim
":g/^\s*$/;//-1sort"
```

```lua
-- Lua equivalent using vim.cmd
vim.cmd('g/^\s*$/;//-1sort')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Did_you_know)
***
# Title: Repeat Last Change with Dot Command
# Category: editing
# Tags: editing, productivity
---
Press '.' to repeat the last edit or change, saving keystrokes and improving efficiency

```lua
-- Simply press . in normal mode to repeat last change
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Did_you_know/2008)
***
# Title: Increment and Decrement Numbers Quickly
# Category: editing
# Tags: editing, text-manipulation
---
Use Ctrl-A and Ctrl-X to quickly increment or decrement numbers under the cursor

```vim
Ctrl-A  # Increment number
Ctrl-X  # Decrement number
```

```lua
-- In normal mode
vim.keymap.set('n', '<C-a>', '<C-a>', { desc = 'Increment number' })
vim.keymap.set('n', '<C-x>', '<C-x>', { desc = 'Decrement number' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Did_you_know/2008)
***
# Title: Remove All Blank Lines in a File
# Category: editing
# Tags: text-manipulation, command-line
---
Quickly disable auto-indentation when pasting pre-indented code to prevent double indentation

```vim
:set paste
:set nopaste
```

```lua
-- Lua equivalent
vim.opt.paste = true  -- Enable paste mode
vim.opt.paste = false  -- Disable paste mode
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Disable_auto_indenting_yet_keep_imaps)
***
# Title: Copy and Replace Lines Across Document
# Category: editing
# Tags: line-manipulation, copy, paste
---
Quickly copy a line and paste it to multiple locations with minimal keystrokes

```vim
# Copy line: Y
# Paste after/before: p/P
# Alternative replace method:
# 0y$ to copy line content
# S<C-R>0<Esc> to replace line
```

```lua
-- Copy line: yy or Y
-- Paste after/before: p/P
-- Complex replace:
-- 0y$ to copy line content
-- S to replace line content
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Dot_makes_life_easier)
***
# Title: Duplicate Previous Line Word by Word
# Category: editing
# Tags: key-mapping, text-manipulation, productivity
---
Quickly duplicate words from the previous line, useful for coding and documentation

```vim
" Duplicate previous line word by word
imap <F1> @<Esc>kyWjPA<BS>
nmap <F1> @<Esc>kyWjPA<BS>
imap <F2> <Esc>o<Esc>kyWjPA<BS><Space>
nmap <F2> <Esc>o<Esc>kyWjPA<BS><Space>
```

```lua
-- Lua equivalent for duplicating words from previous line
vim.keymap.set({'n', 'i'}, '<F1>', function()
  local line = vim.fn.getline(vim.fn.line('.') - 1)
  local word = vim.fn.matchstr(line, '\k\+')
  vim.api.nvim_put({word}, 'c', true, true)
end, { desc = 'Duplicate word from previous line' })

-- Alternative approach using built-in Neovim mapping style
vim.keymap.set({'n', 'i'}, '<F2>', function()
  vim.cmd('normal! o')
  local line = vim.fn.getline(vim.fn.line('.') - 2)
  local word = vim.fn.matchstr(line, '\k\+')
  vim.api.nvim_put({word}, 'c', true, true)
end, { desc = 'Duplicate word from previous line and create new line' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Duplicate_previous_line_word_by_word)
***
# Title: Insert Special Characters with Digraphs
# Category: editing
# Tags: special-characters, unicode, input-methods
---
Easily insert special characters like umlauts, accents, and symbols using digraphs in insert mode

```vim
" Insert special characters
:set digraph
" In insert mode
<C-K>a:
<C-K>e>
```

```lua
-- Enable digraphs
vim.opt.digraph = true

-- In insert mode, use Ctrl-K followed by two characters
-- e.g., a: for ä, e> for ê
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Entering_German_umlauts)
***
# Title: Enter Characters by Unicode Value
# Category: editing
# Tags: unicode, character-input, encoding
---
Insert characters by their decimal, octal, hex, or Unicode value in insert mode

```vim
" Insert characters by value in insert mode
" Decimal: Ctrl-V followed by 3-digit number
" Hex Unicode: Ctrl-V u1234
" Full Unicode: Ctrl-V U00001234
```

```lua
-- For full Unicode support, ensure encoding is set to UTF-8
vim.opt.encoding = 'utf-8'

-- Character input methods remain similar in insert mode
-- Requires knowing the specific Unicode code point
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Entering_German_umlauts)
***
# Title: Easy Character and Word Swapping
# Category: editing
# Tags: text-manipulation, quick-edit, normal-mode
---
Quick methods to swap characters and words in normal mode without moving the cursor

```vim
" Swap current character with next
xp

" Swap current word with next
:nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>
```

```lua
-- Swap current character with next
vim.keymap.set('n', 'gc', 'xph', { desc = 'Swap current character' })

-- Swap current word with next
vim.keymap.set('n', 'gw', function()
  local current_word = vim.fn.expand('<cword>')
  local next_word = vim.fn.expand('<cWORD>')
  local line = vim.api.nvim_get_current_line()
  local new_line = line:gsub(vim.fn.escape(current_word, '%'), next_word, 1)
  new_line = new_line:gsub(vim.fn.escape(next_word, '%'), current_word, 1)
  vim.api.nvim_set_current_line(new_line)
end, { desc = 'Swap current word with next' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Exchange_columns)
***
# Title: Quick Email Quote Formatting Techniques
# Category: editing
# Tags: text-editing, email, formatting
---
Multiple ways to reformat email quotations using Vim's text formatting operators

```vim
" Formatting techniques:
" Visual mode: V, then gq
" Movement-based: gq} or gq4j
" Text object: gqip or gqap
```

```lua
-- Note: These are built-in Vim/Neovim operations
-- Use in normal mode with equivalent commands
-- Relies on formatoptions and textwidth settings
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Fix_email_quotations_with_long_lines)
***
# Title: Quick Footnote Insertion Abbreviations
# Category: editing
# Tags: abbreviations, text-editing, insertion
---
Provides abbreviations for quickly inserting and navigating footnotes in a document

```vim
ab (1 [1]<Esc>:/^--\s/-1/<CR>o<insert><CR>Footnotes:<CR>----------<CR>[1]
ab (2 [2]<Esc>:/^Footnotes\:/+2/<CR>o<insert>[2]
ab (3 [3]<Esc>:/^Footnotes\:/+3/<CR>o<insert>[3]
```

```lua
-- Lua equivalents would typically be implemented using autocmds or custom functions
-- This is more complex and would require a custom Lua function
-- Example skeleton:
vim.cmd([[cnoreabbrev (1 [1]<Esc>:/^--\s/-1/<CR>o<insert><CR>Footnotes:<CR>----------<CR>[1]]])
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Footnotes)
***
# Title: Paste with Automatic Indentation
# Category: editing
# Tags: paste, indentation, text-formatting
---
Automatically adjust indentation when pasting text to match the surrounding context

```vim
" Map p to paste with correct indentation
:nnoremap p ]p

" Alternative: Paste and re-indent
:nnoremap p p=`]
```

```lua
-- Map p to paste with correct indentation
vim.keymap.set('n', 'p', ']p', { desc = 'Paste with correct indentation' })

-- Alternative: Paste and re-indent
vim.keymap.set('n', 'p', function()
  vim.cmd('normal! p')
  vim.cmd('normal! =`]')
end, { desc = 'Paste and re-indent' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Format_pasted_text_automatically)
***
# Title: Block Commenting in Lisp
# Category: editing
# Tags: commenting, block-edit
---
Quick way to comment out an entire code block between parentheses

```vim
map .; v%:s/^/;;;/<CR>:noh<CR>
```

```lua
vim.keymap.set('n', '.,', function()
  vim.cmd('normal! v%:s/^/;;;/\<CR>:nohl\<CR>')
end, { desc = 'Comment out code block' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Formatting_stuff)
***
# Title: Join Lines with Customizable Spacing
# Category: editing
# Tags: line-manipulation, text-editing
---
Control how lines are joined using 'J' command and joinspaces option

```vim
set nojoinspaces
" Use 'J' to join lines, 'gJ' to join without extra spaces
```

```lua
vim.opt.joinspaces = false
-- Use 'J' in normal mode to join lines with custom spacing
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/From_Vim_Help/2009)
***
# Title: Preserve Cursor Position When Pasting
# Category: editing
# Tags: clipboard, cursor-preservation
---
Use a mark to maintain cursor position when pasting from clipboard using xclip on X11.

```vim
map <F7> mz:-1r !xclip -o -sel clip<CR>`z
```

```lua
vim.keymap.set('n', '<F7>', 'mz:-1r !xclip -o -sel clip<CR>`z', { desc = 'Paste and preserve cursor position' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/GNU/Linux_clipboard_copy/paste_with_xclip)
***
# Title: Generate Numbered Lists Quickly
# Category: editing
# Tags: list-generation, range, formatting
---
Quickly generate incrementing sequences in visual block mode, useful for creating arrays or sequences

```vim
" Select first column in block mode
" Press g Ctrl-A to increment numbers
my_array[0] = 0;
(select block, g Ctrl-A)
```

```lua
-- Vim 8+ functionality, equivalent Lua approach
-- Use vim.cmd to simulate visual block and increment
-- Note: Exact visual block manipulation might require additional scripting in Lua
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Generating_a_list)
***
# Title: Insert Current Filename
# Category: editing
# Tags: insert-mode, filename, completion
---
Insert current filename in insert or command mode using register expansion

```vim
" In insert mode: Ctrl-R %
" In command mode: Ctrl-R %
" In normal mode: "%p to put filename after cursor
```

```lua
-- In insert mode, use vim.api.nvim_feedkeys to simulate Ctrl-R %
vim.api.nvim_feedkeys(vim.fn.expand('%'), 'i', true)
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Get_the_name_of_the_current_file)
***
# Title: HTML Entity Conversion Utility
# Category: editing
# Tags: html, text-processing, search-replace
---
Easily escape or unescape HTML entities like <, >, & in text, with support for whole file or specific ranges

```vim
function! HtmlEntities(line1, line2, action)
  let search = @/
  let range = 'silent ' . a:line1 . ',' . a:line2
  if a:action == 0  " must convert &amp; last
    execute range . 'sno/&lt;/</eg'
    execute range . 'sno/&gt;/>/eg'
    execute range . 'sno/&amp;/&/eg'
  else              " must convert & first
    execute range . 'sno/&/&amp;/eg'
    execute range . 'sno/</&lt;/eg'
    execute range . 'sno/>/&gt;/eg'
  endif
  nohl
  let @/ = search
endfunction

command! -range -nargs=1 Entities call HtmlEntities(<line1>, <line2>, <args>)
noremap <silent> <Leader>h :Entities 0<CR>
noremap <silent> <Leader>H :Entities 1<CR>
```

```lua
vim.api.nvim_create_user_command('Entities', function(opts)
  local start_line = opts.line1
  local end_line = opts.line2
  local action = tonumber(opts.args)
  
  local function html_entities(action)
    local view = vim.fn.winsaveview()
    local search = vim.fn.getreg('/')
    
    if action == 0 then  -- Unescape
      vim.cmd(start_line .. ',' .. end_line .. 's/&lt;/</eg')
      vim.cmd(start_line .. ',' .. end_line .. 's/&gt;/>/eg')
      vim.cmd(start_line .. ',' .. end_line .. 's/&amp;/&/eg')
    else  -- Escape
      vim.cmd(start_line .. ',' .. end_line .. 's/&/\&amp;/eg')
      vim.cmd(start_line .. ',' .. end_line .. 's/</\&lt;/eg')
      vim.cmd(start_line .. ',' .. end_line .. 's/>/\&gt;/eg')
    end
    
    vim.fn.winrestview(view)
    vim.fn.setreg('/', search)
    vim.cmd.nohlsearch()
  end
  
  html_entities(action)
end', {nargs = 1, range = true})

-- Keymappings
vim.keymap.set('n', '<Leader>h', ':Entities 0<CR>', {silent = true})
vim.keymap.set('n', '<Leader>H', ':Entities 1<CR>', {silent = true})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/HTML_entities)
***
# Title: Temporarily Disable Auto-Indentation for Pasting
# Category: editing
# Tags: paste, indentation, clipboard
---
Use paste mode to prevent auto-indentation when inserting pre-indented code

```vim
:set paste
:set nopaste
```

```lua
-- Temporarily disable auto-indentation
vim.o.paste = true
-- After pasting
vim.o.paste = false
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/How_to_stop_auto_indenting)
***
# Title: Increment/Decrement Numbers Flexibly
# Category: editing
# Tags: number-manipulation, text-editing, key-mapping
---
Easily increment or decrement numbers in various formats (decimal, hex, alpha) using Ctrl-A and Ctrl-X with enhanced search capabilities

```vim
function! AddSubtract(char, back)
  let pattern = &nrformats =~ 'alpha' ? '[[:alpha:][:digit:]]' : '[[:digit:]]'
  call search(pattern, 'cw' . a:back)
  execute 'normal! ' . v:count1 . a:char
  silent! call repeat#set(":\<C-u>call AddSubtract('" .a:char. "', '" .a:back. "')\<CR>")
endfunction

nnoremap <silent>         <C-a> :<C-u>call AddSubtract("\<C-a>", '')<CR>
nnoremap <silent> <Leader><C-a> :<C-u>call AddSubtract("\<C-a>", 'b')<CR>
nnoremap <silent>         <C-x> :<C-u>call AddSubtract("\<C-x>", '')<CR>
nnoremap <silent> <Leader><C-x> :<C-u>call AddSubtract("\<C-x>", 'b')<CR>
```

```lua
local function add_subtract(char, back)
  local pattern = vim.o.nrformats:find('alpha') and '[%a%d]' or '[%d]'
  vim.fn.search(pattern, 'cw' .. back)
  vim.cmd('normal! ' .. vim.v.count1 .. char)
  
  -- Optional: Use repeat.vim if available
  pcall(function()
    require('repeat').set(string.format(':lua add_subtract("%s", "%s")<CR>', char, back))
  end)
end

vim.keymap.set('n', '<C-a>', function() add_subtract('\<C-a>', '') end)
vim.keymap.set('n', '<Leader><C-a>', function() add_subtract('\<C-a>', 'b') end)
vim.keymap.set('n', '<C-x>', function() add_subtract('\<C-x>', '') end)
vim.keymap.set('n', '<Leader><C-x>', function() add_subtract('\<C-x>', 'b') end)
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Increasing_or_decreasing_numbers)
***
# Title: Quickly Comment Lines in Visual Mode
# Category: editing
# Tags: visual-mode, commenting, text-manipulation
---
Easily add comments to multiple lines using visual block mode and substitute command

```vim
:'<,'>s/^/%/  " Add comment at start of selected lines
:'<,'>s/^/<your comment here>/
```

```lua
-- In visual mode, use:'<,'>s/^/%/ to add comment
-- Or use blockwise visual mode and I to prepend comment
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Insert_C%2B%2B_or_LaTeX_or_other_comments_easily)
***
# Title: Quick Word Deletion in Insert Mode
# Category: editing
# Tags: insert-mode, text-editing, key-mapping
---
Map Ctrl-Backspace to delete previous word in insert mode

```vim
imap <C-BS> <C-W>
```

```lua
vim.keymap.set('i', '<C-BS>', '<C-W>', { desc = 'Delete previous word' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Insert_a_non_commented_line_despite_formatoptions)
***
# Title: Insert Filename in Neovim
# Category: editing
# Tags: insert-mode, filename, expansion
---
Quickly insert the current filename or path in insert mode using expand() function

```vim
" Insert filename without extension
:inoremap <Leader>fn <C-R>=expand("%:t:r")<CR>

" Insert full filename with extension
:inoremap <Leader>fn <C-R>=expand("%:t")<CR>

" Insert full absolute path
:inoremap <Leader>fn <C-R>=expand("%:p:h")<CR>
```

```lua
-- Insert filename without extension
vim.keymap.set('i', '<Leader>fn', function()
  vim.api.nvim_put({vim.fn.expand('%:t:r')}, '', true, true)
end, { desc = 'Insert filename without extension' })

-- Insert full filename with extension
vim.keymap.set('i', '<Leader>fn', function()
  vim.api.nvim_put({vim.fn.expand('%:t')}, '', true, true)
end, { desc = 'Insert full filename' })

-- Insert full absolute path
vim.keymap.set('i', '<Leader>fn', function()
  vim.api.nvim_put({vim.fn.expand('%:p:h')}, '', true, true)
end, { desc = 'Insert file path' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Insert_current_filename)
***
# Title: Insert Line Numbers in File
# Category: editing
# Tags: line-numbering, text-manipulation, search-replace
---
Programmatically insert sequential line numbers into a file or selected section using Vim's search and replace functionality

```vim
:%s/^/\=printf('%-4d', line('.'))
:'<,'>s/^/\=printf('%d.\t', line('.') - line("'<") + 1)
```

```lua
-- Insert line numbers for entire file
vim.cmd(':%s/^/\=printf("%-4d", line("."))')

-- Insert line numbers for selected range
vim.cmd("'<,'>s/^/\=printf('%d.\t', line('.') - line("'<") + 1)")
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Insert_line_numbers_2)
***
# Title: Number Lines Using External Utility
# Category: editing
# Tags: external-tools, line-numbering
---
Use Unix 'nl' utility to insert line numbers with flexible formatting options

```vim
:%!nl -ba
:'<,'>!nl -s '. ' -w 2
```

```lua
-- Number entire file
vim.cmd('%!nl -ba')

-- Number selected range with custom formatting
vim.cmd("'<,'>!nl -s '. ' -w 2")
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Insert_line_numbers_2)
***
# Title: Join Lines Matching a Pattern Globally
# Category: editing
# Tags: text-manipulation, global-command, line-joining
---
Easily increment numbers across multiple lines using block visual mode and g Ctrl-A

```vim
# In Vim 8+ visual block mode
# Select first column of numbers
g Ctrl-A
```

```lua
-- Requires Vim 8+ functionality
-- Use Ctrl-V to enter block visual mode
-- Select first column of numbers
-- Use 'g Ctrl-A' to increment sequentially
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/List_of_numbers)
***
# Title: Insert Numbered List with Range Function
# Category: editing
# Tags: list-generation, range, text-manipulation
---
Easily replace words with previously yanked text using a single key mapping

```vim
nnoremap S diw"0P
```

```lua
vim.keymap.set('n', 'S', 'diw"0P', { desc = 'Replace word with last yanked text' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Mappings_and_commands_for_visual_mode)
***
# Title: Insert Special Characters Quickly
# Category: editing
# Tags: special-characters, unicode, menu-mapping
---
Create custom menu mappings to easily insert special Unicode characters using nr2char() function

```vim
" Insert special characters via menu
20imenu Editieren.Sonderzeichen.copyright\ \ © <C-R>=nr2char(169)<CR>
20nmenu Editieren.Sonderzeichen.copyright\ \ © a<C-R>=nr2char(169)<CR><Esc>
```

```lua
-- Lua equivalent for special character insertion
vim.api.nvim_set_keymap('i', '<M-c>', '<C-R>=nr2char(169)<CR>', { noremap = true, desc = 'Insert copyright symbol' })
vim.api.nvim_set_keymap('n', '<M-c>', 'a<C-R>=nr2char(169)<CR><Esc>', { noremap = true, desc = 'Insert copyright symbol' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Menu_for_inserting_special_characters)
***
# Title: Quick Separating Line Abbreviations
# Category: editing
# Tags: abbreviations, text-formatting, documentation
---
Create quick abbreviations for inserting different styles of separating lines in documentation or code

```vim
" Line separator abbreviations
abb dlin =======================================================================
abb cdlin /*===================================================================*/
abb lin -----------------------------------------------------------------------
abb clin /*-------------------------------------------------------------------*/
```

```lua
-- Lua equivalent for line separator abbreviations
vim.cmd('iabbrev dlin =======================================================================')
vim.cmd('iabbrev cdlin /*===================================================================*/')
vim.cmd('iabbrev lin -----------------------------------------------------------------------')
vim.cmd('iabbrev clin /*-------------------------------------------------------------------*/')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Menu_for_inserting_special_characters)
***
# Title: Merge Terminal-Split Long Lines
# Category: editing
# Tags: text-manipulation, terminal-output
---
Automatically merge long lines split by terminal windows, useful for cleaning up copied output with a consistent 80-character line length

```vim
g/^.\{79}\S$/normal Jx
```

```lua
-- Merge long lines split by terminal
vim.cmd.global('/^.\{79}\S$/normal! Jx')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Merge_longs_lines_that_were_split_by_terminal_window)
***
# Title: Quick Minify File in Vim
# Category: editing
# Tags: text-manipulation, formatting
---
Quickly remove line breaks and compress a file into a single line using visual mode and Shift-J

```vim
# In visual mode, select entire file
# Then press SHIFT-J
```

```lua
-- In Neovim, same approach works
-- 1. Select entire file with ggVG
-- 2. Press J to join lines
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Minify_File_inside_Vim_without_plugins)
***
# Title: Move Comment to End of Line Efficiently
# Category: editing
# Tags: line-manipulation, code-formatting, key-mapping
---
Use Vim's built-in word completion and home row navigation to speed up editing

```vim
# Word completion
Ctrl-P  # Complete previous word
Ctrl-N  # Complete next word
```

```lua
-- Word completion mappings
vim.keymap.set('i', '<C-p>', '<C-x><C-p>', { desc = 'Complete previous word' })
vim.keymap.set('i', '<C-n>', '<C-x><C-n>', { desc = 'Complete next word' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/New_to_Vim)
***
# Title: Number Lines Sequentially in Visual Selection
# Category: editing
# Tags: text-manipulation, line-numbering, visual-mode
---
Easily number lines in a visual selection with custom start number and optional suffix

```vim
function! Nlist(...) range
  if 2 == a:0
    let start = a:1
    let append = a:2
  elseif 1 == a:0
    let start = a:1
    let append = " "
  else
    let start = 1
    let append = " "
  endif
  exe a:firstline . "," . a:lastline . 's/^/\=line(".")-a:firstline+start.append/'
endfunction
```

```lua
function _G.number_lines(start, append)
  start = start or 1
  append = append or " "
  local first_line = vim.fn.line("'<")
  local last_line = vim.fn.line("'>")
  for i = first_line, last_line do
    local line_text = vim.fn.getline(i)
    local new_line = string.format("%d%s%s", i - first_line + start, append, line_text)
    vim.fn.setline(i, new_line)
  end
end

-- Usage: In visual mode, call :lua _G.number_lines()
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Number_a_group_of_lines)
***
# Title: Number Lines with External Filter
# Category: editing
# Tags: text-manipulation, external-tools, numbering
---
Trigger omni completion and navigate suggestions using keyboard shortcuts

```vim
" Trigger omni completion: Ctrl-X Ctrl-O
" Navigate suggestions: Ctrl-N (next), Ctrl-P (previous)
```

```lua
-- Use built-in Vim completion mappings
-- <C-x><C-o> to trigger
-- <C-n> and <C-p> to navigate suggestions
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Omni_Completion)
***
# Title: Trigger Omni Completion in Insert Mode
# Category: editing
# Tags: auto-completion, insert-mode, productivity
---
Use Ctrl-X Ctrl-O to open context-aware completion popup menu in insert mode

```vim
" In insert mode, press Ctrl-X Ctrl-O to trigger omni completion
" Navigate popup with Ctrl-N and Ctrl-P
```

```lua
-- Omni completion is triggered in insert mode with Ctrl-X Ctrl-O
-- Use built-in Vim mapping, no direct Lua equivalent needed
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Omni_completion)
***
# Title: Insert Multiple Lines Efficiently
# Category: editing
# Tags: line-insertion, key-mapping, productivity
---
Quickly insert multiple blank lines above or below the current line, with automatic cursor positioning and mode entry

```vim
function! OpenLines(nrlines, dir)
  let nrlines = a:nrlines < 3 ? 3 : a:nrlines
  let start = line('.') + a:dir
  call append(start, repeat([''], nrlines))
  if a:dir < 0
    normal! 2k
  else
    normal! 2j
  endif
endfunction

nnoremap <Leader>o :<C-u>call OpenLines(v:count, 0)<CR>S
nnoremap <Leader>O :<C-u>call OpenLines(v:count, -1)<CR>S
```

```lua
function OpenLines(nrlines, dir)
  nrlines = nrlines < 3 and 3 or nrlines
  local start = vim.fn.line('.') + dir
  
  local empty_lines = vim.fn.repeat({''},nrlines)
  vim.fn.append(start, empty_lines)
  
  if dir < 0 then
    vim.cmd('normal! 2k')
  else
    vim.cmd('normal! 2j')
  end
end

vim.keymap.set('n', '<Leader>o', function()
  local count = vim.v.count > 0 and vim.v.count or 3
  OpenLines(count, 0)
  vim.cmd('startinsert')
end)

vim.keymap.set('n', '<Leader>O', function()
  local count = vim.v.count > 0 and vim.v.count or 3
  OpenLines(count, -1)
  vim.cmd('startinsert')
end)
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Open_Multiple_Lines_Above/Below_and_Drop_Into_Insert_Mode)
***
# Title: Fix Numeric Prefix Mistake in PHP Variables
# Category: editing
# Tags: php, error-correction, key-mapping
---
Remove consecutive blank lines, replacing multiple empty lines with a single blank line

```vim
" Compress multiple blank lines to single line
:v/./,/./-j

" Alternative method
:%s/^$\n^$//g
```

```lua
-- Compress blank lines
vim.cmd('v/./,/./-j')

-- Alternative substitution method
vim.cmd('%s/^$\\n^$//g')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Power_of)
***
# Title: Quickly Add/Delete Empty Lines
# Category: editing
# Tags: line-manipulation, key-mapping, productivity
---
Efficiently insert or remove blank lines above or below the current line without moving the cursor

```vim
" Ctrl-j/k deletes blank line below/above, and Alt-j/k inserts
nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>
```

```lua
-- Delete blank line below/above
vim.keymap.set('n', '<C-j>', function()
  vim.cmd('silent +g/^\s*$/d')
  vim.cmd('noh')
end, { silent = true })

vim.keymap.set('n', '<C-k>', function()
  vim.cmd('silent -g/^\s*$/d')
  vim.cmd('noh')
end, { silent = true })

-- Insert blank line below/above
vim.keymap.set('n', '<A-j>', function()
  vim.o.paste = true
  vim.cmd('normal! o')
  vim.cmd('normal! `[')
  vim.o.paste = false
end, { silent = true })

vim.keymap.set('n', '<A-k>', function()
  vim.o.paste = true
  vim.cmd('normal! O')
  vim.cmd('normal! `[')
  vim.o.paste = false
end, { silent = true })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Quickly_adding_and_deleting_empty_lines)
***
# Title: Quick Word and Line Editing Commands
# Category: editing
# Tags: text-objects, editing-shortcuts, change-command
---
Efficient ways to change text using Vim's change (c) commands for words, lines, and text objects

```vim
" Change word variants:
cw    " Change word from cursor
caw   " Change whole word
ciw   " Change inner word

" Change line variants:
c$    " Change to end of line
C     " Change to end of line
cc    " Change entire line
cis   " Change inner sentence
```

```lua
-- These are built-in Vim/Neovim commands, so no direct Lua translation needed
-- But can be used directly in Neovim
-- Examples:
-- cw, caw, ciw for word changes
-- c$, C, cc for line changes
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Quickly_change_word_or_line)
***
# Title: Remove Diacritical Signs from Characters
# Category: editing
# Tags: text-transformation, character-replacement, internationalization
---
Quickly remove empty or whitespace-only lines using global commands in Vim/Neovim

```vim
" Remove completely empty lines
:g/^$/d
:v/./d

" Remove lines with only whitespace
:g/^\s*$/d
:v/\S/d
```

```lua
-- Remove empty lines
vim.cmd('g/^$/d')
vim.cmd('v/./d')

-- Remove lines with only whitespace
vim.cmd('g/^\s*$/d')
vim.cmd('v/\S/d')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Remove_unwanted_empty_lines)
***
# Title: Condense Multiple Blank Lines
# Category: editing
# Tags: text-cleanup, search-replace
---
Reduce multiple consecutive blank lines to a single blank line while removing trailing whitespace

```vim
" Remove trailing whitespace and condense blank lines
:%s/\s\+$//e
:%s/\n\{3,}/\r\r/e
```

```lua
-- Remove trailing whitespace and condense blank lines
vim.cmd('%s/\s\+$//e')
vim.cmd('%s/\n\{3,}/\r\r/e')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Remove_unwanted_empty_lines)
***
# Title: Remove Automatic Comment Leaders Quickly
# Category: editing
# Tags: insert-mode, comments, text-editing
---
Quickly copy a word and replace multiple occurrences using yanking and dot command repetition

```vim
" Workflow:
" yiw - yank current word
" ciw<C-R>0<Esc> - change word with yanked text
" . - repeat the replacement
```

```lua
-- Similar workflow in Neovim
-- Use vim.fn.feedkeys() for complex macros if needed
-- Essentially the same key sequence works
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Repeat_last_changes)
***
# Title: Line Replacement Across Multiple Locations
# Category: editing
# Tags: line-manipulation, registers, text-replacement
---
Copy a line and replace lines at different locations using registers and dot command

```vim
" Workflow:
" Y - yank current line
" p/P - paste after/before current line
" . - repeat paste
```

```lua
-- Neovim supports the same line replacement techniques
-- Use standard vim.api.nvim_buf_set_lines() for programmatic replacements
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Repeat_last_changes)
***
# Title: Copy and Replace Words Across Multiple Locations
# Category: editing
# Tags: copy, replace, registers
---
Efficiently copy a word and replace words in multiple locations using yank and repeat commands

```vim
# Workflow:
# 1. yiw - yank current word
# 2. Move cursor
# 3. ciw<C-R>0<Esc> - change word with yanked text
# 4. Use '.' to repeat
```

```lua
-- Similar workflow can be achieved
-- Use vim.fn.feedkeys() for complex macros if needed
-- Mostly relies on standard Vim/Neovim keybindings
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Repeating)
***
# Title: Quick Paragraph Sorting in Normal Mode
# Category: editing
# Tags: text-objects, paragraph-manipulation
---
Quickly sort a paragraph using a normal mode command

```vim
Vip:
```

```lua
-- In normal mode, sort current paragraph
vim.cmd('normal Vip:')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Repeating_an_ex_command_on_multiple_blocks)
***
# Title: Smart Word Replacement Across Files
# Category: editing
# Tags: registers, text-manipulation, replace
---
Quickly reverse the order of lines in a Vim buffer using a global command, useful for reordering lists or log files

```vim
:g/^/m0  # Reverse all lines in buffer
:100,150g/^/m99  # Reverse lines 100-150
```

```lua
-- Reverse all lines
vim.cmd('g/^/m0')

-- Reverse specific line range
vim.cmd('100,150g/^/m99')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Reverse_all_lines)
***
# Title: Reverse Lines Using External Command
# Category: editing
# Tags: external-tools, text-manipulation
---
Use external 'tac' utility to reverse lines, works with specific ranges

```vim
:%!tac  # Reverse entire buffer
:100,150!tac  # Reverse lines 100-150
```

```lua
-- Reverse entire buffer
vim.cmd(':%!tac')

-- Reverse specific line range
vim.cmd(':100,150!tac')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Reverse_all_lines)
***
# Title: Reverse Lines in a Specific Range
# Category: editing
# Tags: line-manipulation, range-operations, text-editing
---
Reverse lines within a specific line range, useful for targeted line order manipulation

```vim
:100,150g/^/m99
```

```lua
-- Reverse lines 100-150
vim.cmd('100,150g/^/m99')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Reverse_lines_in_a_file_using_tac)
***
# Title: Use Text Filters to Process Line Ranges
# Category: editing
# Tags: text-processing, shell-commands, filtering
---
Demonstrates using Vim's filter functionality to process selected text ranges with shell commands, enabling powerful text transformation

```vim
" Visual selection followed by ! allows filtering text through shell commands
" Example: Select lines and use 'cut' to extract specific CSV fields
```

```lua
-- While this is primarily a Vim editing technique, in Neovim you can
-- achieve similar results with lua functions or external command processing
-- Example filter function:
function ProcessSelectedLines(cmd)
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local lines = vim.fn.getline(start_line, end_line)
  local result = vim.fn.systemlist(cmd, lines)
  vim.api.nvim_buf_set_lines(0, start_line-1, end_line, false, result)
end
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/VimTip467)
***
# Title: Swap Characters and Words Easily
# Category: editing
# Tags: text-manipulation, quick-edit
---
Quick normal mode commands to swap adjacent characters, words, or lines with minimal keystrokes

```vim
" Swap current character with next
xp

" Swap current word with next
dawwP
```

```lua
-- Note: These are direct normal mode commands
-- Lua equivalents would typically use vim.api.nvim_input()
-- for similar character/word swapping functionality
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/VimTip47)
***
# Title: Toggle Paste Mode Easily
# Category: editing
# Tags: paste-mode, key-mapping, clipboard
---
Add a quick toggle for paste mode to prevent auto-indentation issues when pasting text

```vim
map <F11> :set invpaste<CR>
set pastetoggle=<F11>
```

```lua
vim.keymap.set('n', '<F11>', ':set invpaste<CR>', { desc = 'Toggle paste mode' })
vim.o.pastetoggle = '<F11>'
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/VimTip471)
***
# Title: Flexible Case Conversion in Text
# Category: editing
# Tags: text-manipulation, case-conversion, text-editing
---
Provides multiple ways to change text case, including toggling, uppercase, and lowercase conversions using movement commands or visual selection

```vim
" Toggle case of characters
g~3w  " Toggle case of next 3 words
g~iw  " Toggle case of current word
gUU   " Convert current line to uppercase
guu   " Convert current line to lowercase
```

```lua
-- Toggle case of characters
-- Lua uses same Vim commands, but can be mapped with vim.keymap
vim.keymap.set('n', 'g~3w', 'g~3w', { desc = 'Toggle case of next 3 words' })
vim.keymap.set('n', 'g~iw', 'g~iw', { desc = 'Toggle case of current word' })
vim.keymap.set('n', 'gUU', 'gUU', { desc = 'Convert line to uppercase' })
vim.keymap.set('n', 'guu', 'guu', { desc = 'Convert line to lowercase' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/VimTip49)
***
# Title: Easy Word Replacement Across Files
# Category: editing
# Tags: registers, text-objects, search-replace
---
Replace words efficiently using registers and text objects, with repeatable operations across multiple locations

```vim
" Stamp mapping to replace words with last yanked text
nnoremap S diw"0P

" Remap paste in visual mode to preserve register
xnoremap <silent> p p:let @"=@0<CR>
```

```lua
-- Stamp mapping to replace words with last yanked text
vim.keymap.set('n', 'S', 'diw"0P', { desc = 'Replace word with last yanked text' })

-- Remap paste in visual mode to preserve register
vim.keymap.set('x', 'p', 'p<Cmd>let @"=@0<CR>', { desc = 'Paste and preserve register' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/VimTip497)
***
# Title: Insert Filename in Different Modes
# Category: editing
# Tags: insert-mode, command-line, file-operations
---
Various methods to insert the current filename in different Vim modes

```vim
" In insert mode: Ctrl-R %
" In command mode: Ctrl-R %
" In normal mode: "%p (after cursor) or "%P (before cursor)
```

```lua
-- These are mode-specific Vim commands, so equivalent Lua mapping approach:
vim.keymap.set('i', '<C-x>f', function()
  vim.api.nvim_put({vim.fn.expand('%')}, 'c', true, true)
end, { desc = 'Insert current filename' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/VimTip530)
***
# Title: Quick Text Filtering with External Commands
# Category: editing
# Tags: text-processing, external-commands, filtering
---
Use '!<motion><command>' to filter text through external commands, like formatting paragraphs or performing calculations.

```vim
# Filter paragraph through fmt
!}fmt

# Calculate expression
!}bc
```

```lua
-- Lua equivalent for external command filtering
-- Note: Requires external commands
vim.keymap.set('n', '<leader>fp', '!}fmt<CR>', { desc = 'Format paragraph' })
vim.keymap.set('n', '<leader>bc', '!}bc<CR>', { desc = 'Calculate expression' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/VimTip535)
***
# Title: Quick Paragraph Line Joining
# Category: editing
# Tags: text-manipulation, line-editing
---
Easily join lines within paragraphs, removing excess newlines in a single command

```vim
:v/^\s*$/norm vipJ
```

```lua
vim.cmd('v/^\s*$/norm vipJ')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/VimTip579)
***
# Title: Expand Abbreviations Without Extra Characters
# Category: editing
# Tags: insert-mode, abbreviations, text-expansion
---
Use Ctrl-] to expand an abbreviation without inserting an extra space

```vim
:iabbrev hh hello
" hh<Ctrl-]> will expand to just 'hello'
```

```lua
-- Use vim.cmd to set abbreviation
vim.cmd('iabbrev hh hello')
-- Use Ctrl-] in insert mode to expand without space
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/VimTip610)
***
# Title: Start Editing Blank Lines with Correct Indent
# Category: editing
# Tags: indentation, editing, productivity
---
Efficiently copy a word and replace multiple occurrences using registers and repeat commands

```vim
" To copy and replace words:
yiw   " Yank current word
ciw<C-R>0<Esc>  " Change word with yanked text
.     " Repeat the replacement
```

```lua
-- Lua equivalent for copying and replacing words
-- yiw to yank word
-- ciw<C-R>0<Esc> to replace
-- . to repeat
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/VimTip69)
***
# Title: Outline Manipulation Techniques
# Category: editing
# Tags: outline, text-editing, indentation
---
Use backspace in insert mode to promote and tab to demote headlines, providing quick outline editing

```vim
" In insert mode:
" Backspace to promote
" Tab to demote
```

```lua
-- Recommended to set up custom keymappings for outline manipulation
-- Example:
vim.keymap.set('i', '<S-Tab>', function()
  -- Implement promote logic
end)

vim.keymap.set('i', '<Tab>', function()
  -- Implement demote logic
end)
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/VimTip74)
***
# Title: Insert Unicode Characters Easily
# Category: editing
# Tags: unicode, character-input, insert-mode
---
Multiple methods to insert Unicode characters in Vim/Neovim: using digraphs, direct Unicode code input, and keyboard input

```vim
" Insert Unicode character methods:
" 1. Digraph: Ctrl-K followed by two characters
" 2. Direct Unicode input: Ctrl-V u XXXX or Ctrl-V U XXXXXXXX
" 3. Keyboard characters work directly in UTF-8 mode
```

```lua
-- Unicode character input methods remain the same
-- Use :lua vim.api.nvim_input('<C-k>') for digraphs
-- Use :lua vim.api.nvim_input('<C-v>u2023') for direct Unicode input
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Working_with_Unicode)
***
# Title: Inspect Unicode Character Details
# Category: editing
# Tags: unicode, character-info, inspection
---
Use built-in commands to get detailed information about Unicode characters

```vim
" Normal mode commands:
га  " Show character details
g8  " Show byte representation
```

```lua
-- Character inspection mapping example
vim.keymap.set('n', '<Leader>u', function()
  local char = vim.fn.getcharstr()
  local codepoint = vim.fn.char2nr(char)
  print(string.format('Character: %s, Codepoint: U+%04X', char, codepoint))
end, { desc = 'Inspect Unicode character' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Working_with_Unicode)
***
