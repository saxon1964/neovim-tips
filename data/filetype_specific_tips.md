# Title: Python indentation and formatting
# Category: File Type Specific  
# Tags: python, indent, format, pep8, filetype
---
Configure Python-specific settings for proper indentation and formatting.

```vim
" Set Python-specific options
:autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
:autocmd FileType python setlocal textwidth=79
:autocmd FileType python setlocal autoindent smartindent

" Python folding
:autocmd FileType python setlocal foldmethod=indent
:autocmd FileType python setlocal foldlevel=2
```
***
# Title: JavaScript/TypeScript development setup
# Category: File Type Specific
# Tags: javascript, typescript, js, ts, node, format
---
Optimize settings for JavaScript and TypeScript development.

```vim
" JavaScript/TypeScript settings
:autocmd FileType javascript,typescript setlocal tabstop=2 shiftwidth=2 expandtab
:autocmd FileType javascript,typescript setlocal suffixesadd+=.js,.ts
:autocmd FileType javascript,typescript setlocal include=^\\s*import\\s*.*\\s*from

" Quick console.log insertion
:autocmd FileType javascript nnoremap <leader>cl oconsole.log();<Left><Left>
:autocmd FileType typescript nnoremap <leader>cl oconsole.log();<Left><Left>
```
***
# Title: HTML and XML tag manipulation
# Category: File Type Specific  
# Tags: html, xml, tag, element, markup
---
Use specialized commands for HTML/XML tag editing and navigation.

```vim
" Tag matching with %
:autocmd FileType html,xml set matchpairs+=<:>

" Surround word with HTML tags
:autocmd FileType html nnoremap <leader>t ysiw<

" Quick tag completion in insert mode
:autocmd FileType html inoremap <lt>/ </<C-X><C-O>

" Format HTML/XML
:autocmd FileType html,xml nnoremap <leader>= gg=G
```
***
# Title: CSS and SCSS productivity shortcuts
# Category: File Type Specific
# Tags: css, scss, sass, style, property
---
Speed up CSS/SCSS development with smart shortcuts and settings.

```vim
" CSS-specific settings
:autocmd FileType css,scss setlocal tabstop=2 shiftwidth=2 expandtab
:autocmd FileType css,scss setlocal iskeyword+=-

" Quick property completion
:autocmd FileType css inoremap : :<Space>
:autocmd FileType css inoremap ; ;<CR>

" Color hex value highlighting
:autocmd FileType css,scss syntax match cssColor /#\x\{6\}/
```
***
# Title: Go language specific features
# Category: File Type Specific
# Tags: go, golang, gofmt, import, build
---
Configure Go development workflow with formatting and building.

```vim
" Go-specific settings
:autocmd FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab
:autocmd FileType go setlocal listchars=tab:\ \ ,trail:·

" Go formatting on save
:autocmd BufWritePre *.go lua vim.lsp.buf.format()

" Quick Go build and run
:autocmd FileType go nnoremap <leader>gr :!go run %<CR>
:autocmd FileType go nnoremap <leader>gb :!go build<CR>
:autocmd FileType go nnoremap <leader>gt :!go test<CR>
```
***
# Title: Rust development optimization
# Category: File Type Specific
# Tags: rust, cargo, rustfmt, clippy, build
---
Set up efficient Rust development environment and shortcuts.

```vim
" Rust settings
:autocmd FileType rust setlocal tabstop=4 shiftwidth=4 expandtab
:autocmd FileType rust setlocal textwidth=100

" Rust cargo commands
:autocmd FileType rust nnoremap <leader>rc :!cargo check<CR>
:autocmd FileType rust nnoremap <leader>rb :!cargo build<CR>
:autocmd FileType rust nnoremap <leader>rr :!cargo run<CR>
:autocmd FileType rust nnoremap <leader>rt :!cargo test<CR>

" Format on save
:autocmd BufWritePre *.rs lua vim.lsp.buf.format()
```
***
# Title: C/C++ header and implementation switching
# Category: File Type Specific
# Tags: c, cpp, header, implementation, switch
---
Navigate between C/C++ header and implementation files efficiently.

```vim
" Switch between header and implementation
function! SwitchSourceHeader()
  let extension = expand('%:e')
  let base = expand('%:r')
  
  if extension ==# 'h' || extension ==# 'hpp'
    " Switch to implementation
    for ext in ['c', 'cpp', 'cc', 'cxx']
      if filereadable(base . '.' . ext)
        execute 'edit ' . base . '.' . ext
        return
      endif
    endfor
  else
    " Switch to header
    for ext in ['h', 'hpp', 'hxx']
      if filereadable(base . '.' . ext)
        execute 'edit ' . base . '.' . ext
        return
      endif
    endfor
  endif
endfunction

:autocmd FileType c,cpp nnoremap <leader>a :call SwitchSourceHeader()<CR>
```
***
# Title: Java class and package navigation
# Category: File Type Specific
# Tags: java, class, package, import, navigation
---
Streamline Java development with class and package utilities.

```vim
" Java settings
:autocmd FileType java setlocal tabstop=4 shiftwidth=4 expandtab
:autocmd FileType java setlocal suffixesadd+=.java

" Quick class template
:autocmd FileType java nnoremap <leader>jc :0r ~/.config/nvim/templates/java-class.java<CR>

" Import statement insertion
:autocmd FileType java nnoremap <leader>ji ggOimport 

" Quick main method
:autocmd FileType java nnoremap <leader>jm ipublic static void main(String[] args) {<CR>}<Esc>O
```
***
# Title: Markdown writing and formatting
# Category: File Type Specific
# Tags: markdown, md, writing, format, preview
---
Enhance Markdown writing experience with formatting and navigation.

```vim
" Markdown settings
:autocmd FileType markdown setlocal textwidth=80
:autocmd FileType markdown setlocal wrap linebreak
:autocmd FileType markdown setlocal spell spelllang=en_us

" Quick formatting
:autocmd FileType markdown nnoremap <leader>mb ysiw**    " bold
:autocmd FileType markdown nnoremap <leader>mi ysiw*     " italic
:autocmd FileType markdown nnoremap <leader>mc ysiw`     " code

" Header navigation
:autocmd FileType markdown nnoremap <leader>h1 I# <Esc>
:autocmd FileType markdown nnoremap <leader>h2 I## <Esc>
:autocmd FileType markdown nnoremap <leader>h3 I### <Esc>
```
***
# Title: JSON formatting and validation
# Category: File Type Specific
# Tags: json, format, validate, pretty, minify
---
Work efficiently with JSON files using formatting and validation tools.

```vim
" JSON settings
:autocmd FileType json setlocal tabstop=2 shiftwidth=2 expandtab
:autocmd FileType json setlocal conceallevel=0

" Format JSON
:autocmd FileType json nnoremap <leader>jf :%!jq '.'<CR>
:autocmd FileType json nnoremap <leader>jm :%!jq -c '.'<CR>  " minify

" Validate JSON
:autocmd FileType json nnoremap <leader>jv :!jq . % > /dev/null<CR>

" Quick JSON template
:autocmd FileType json nnoremap <leader>jt i{<CR>"key": "value"<CR>}<Esc>
```
***
# Title: YAML configuration editing
# Category: File Type Specific
# Tags: yaml, yml, config, indent, validate
---
Optimize YAML editing with proper indentation and validation.

```vim
" YAML settings
:autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 expandtab
:autocmd FileType yaml setlocal indentkeys-=<:>
:autocmd FileType yaml setlocal foldmethod=indent

" YAML validation
:autocmd FileType yaml nnoremap <leader>yv :!yamllint %<CR>

" Quick list item
:autocmd FileType yaml nnoremap <leader>yl o- 
:autocmd FileType yaml inoremap <C-l> <CR>- 
```
***
# Title: Shell script development
# Category: File Type Specific
# Tags: shell, bash, sh, script, executable
---
Streamline shell script development with proper settings and shortcuts.

```vim
" Shell script settings
:autocmd FileType sh setlocal tabstop=2 shiftwidth=2 expandtab
:autocmd FileType sh setlocal textwidth=100

" Make executable on save
:autocmd BufWritePost *.sh silent !chmod +x %

" Shell check linting
:autocmd FileType sh nnoremap <leader>sc :!shellcheck %<CR>

" Quick shebang insertion
:autocmd FileType sh nnoremap <leader>sb ggO#!/bin/bash<Esc>
```
***
# Title: SQL query formatting and execution
# Category: File Type Specific
# Tags: sql, query, format, database, execute
---
Enhance SQL development with formatting and execution capabilities.

```vim
" SQL settings
:autocmd FileType sql setlocal tabstop=2 shiftwidth=2 expandtab

" SQL keyword formatting (uppercase)
:autocmd FileType sql nnoremap <leader>su :s/\<\(select\|from\|where\|join\|group\|order\|by\)\>/\U&/g<CR>

" Format SQL query
:autocmd FileType sql nnoremap <leader>sf :%!sqlformat --reindent --keywords upper --identifiers lower -<CR>

" Quick SQL templates
:autocmd FileType sql nnoremap <leader>ss iSELECT <CR>FROM <CR>WHERE 
:autocmd FileType sql nnoremap <leader>si iINSERT INTO  () VALUES ();<Esc>
```
***
# Title: Lua script configuration
# Category: File Type Specific
# Tags: lua, script, neovim, config, development
---
Configure Lua development for Neovim scripting and general development.

```vim
" Lua settings  
:autocmd FileType lua setlocal tabstop=2 shiftwidth=2 expandtab
:autocmd FileType lua setlocal suffixesadd+=.lua

" Quick Neovim Lua testing
:autocmd FileType lua nnoremap <leader>ll :luafile %<CR>
:autocmd FileType lua vnoremap <leader>ll :lua <CR>

" Lua function template
:autocmd FileType lua nnoremap <leader>lf ilocal function ()<CR>end<Esc>kf(a

" Quick vim namespace
:autocmd FileType lua nnoremap <leader>lv ivim.
```
***
# Title: XML and configuration file handling
# Category: File Type Specific
# Tags: xml, config, plist, format, validate
---
Handle XML and various configuration file formats effectively.

```vim
" XML settings
:autocmd FileType xml setlocal tabstop=2 shiftwidth=2 expandtab
:autocmd FileType xml setlocal foldmethod=syntax
:autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Format XML
:autocmd FileType xml nnoremap <leader>xf :%!xmllint --format -<CR>

" Validate XML
:autocmd FileType xml nnoremap <leader>xv :!xmllint --noout %<CR>

" Quick CDATA section
:autocmd FileType xml nnoremap <leader>cd i<![CDATA[]]><Esc>3hi
```
***
# Title: Configuration file syntax highlighting
# Category: File Type Specific
# Tags: config, conf, ini, properties, syntax
---
Enable proper syntax highlighting for various configuration formats.

```vim
" Auto-detect config file types
:autocmd BufNewFile,BufRead *.conf setfiletype conf
:autocmd BufNewFile,BufRead *.ini setfiletype dosini
:autocmd BufNewFile,BufRead *.properties setfiletype jproperties
:autocmd BufNewFile,BufRead .env* setfiletype sh
:autocmd BufNewFile,BufRead *.toml setfiletype toml

" Config file settings
:autocmd FileType conf,dosini setlocal commentstring=#\ %s
:autocmd FileType conf,dosini setlocal tabstop=4 shiftwidth=4 expandtab
```
***
# Title: Docker and container file editing
# Category: File Type Specific
# Tags: docker, dockerfile, container, build, syntax
---
Optimize editing Docker-related files with proper syntax and shortcuts.

```vim
" Dockerfile settings
:autocmd BufNewFile,BufRead Dockerfile* setfiletype dockerfile
:autocmd BufNewFile,BufRead *.dockerfile setfiletype dockerfile

:autocmd FileType dockerfile setlocal tabstop=2 shiftwidth=2 expandtab
:autocmd FileType dockerfile setlocal commentstring=#\ %s

" Docker build shortcut
:autocmd FileType dockerfile nnoremap <leader>db :!docker build -t my-image .<CR>

" Quick Dockerfile templates
:autocmd FileType dockerfile nnoremap <leader>df iFROM <CR>RUN <CR>COPY <CR>CMD 
```
***
# Title: Git commit message formatting
# Category: File Type Specific
# Tags: git, commit, message, format, conventional
---
Improve git commit message writing with templates and formatting.

```vim
" Git commit settings
:autocmd FileType gitcommit setlocal textwidth=72
:autocmd FileType gitcommit setlocal spell spelllang=en_us
:autocmd FileType gitcommit setlocal colorcolumn=50,72

" Start in insert mode for commit messages
:autocmd FileType gitcommit startinsert

" Conventional commit templates
:autocmd FileType gitcommit nnoremap <leader>gf ifeat: 
:autocmd FileType gitcommit nnoremap <leader>gb ifix: 
:autocmd FileType gitcommit nnoremap <leader>gd idocs: 
:autocmd FileType gitcommit nnoremap <leader>gr irefactor: 
```
***
# Title: Log file analysis and navigation
# Category: File Type Specific
# Tags: log, analysis, navigation, search, timestamp
---
Navigate and analyze log files efficiently with specialized commands.

```vim
" Log file detection and settings
:autocmd BufNewFile,BufRead *.log setfiletype log
:autocmd FileType log setlocal nowrap
:autocmd FileType log setlocal readonly

" Log navigation shortcuts
:autocmd FileType log nnoremap <leader>le /ERROR<CR>     " find errors
:autocmd FileType log nnoremap <leader>lw /WARN<CR>      " find warnings
:autocmd FileType log nnoremap <leader>lt /\d\{4\}-\d\{2\}-\d\{2\}<CR>  " find timestamps

" Highlight log levels
:autocmd FileType log syntax match logError /ERROR/
:autocmd FileType log syntax match logWarn /WARN/
:autocmd FileType log syntax match logInfo /INFO/
```
***
# Title: Binary and hex file editing
# Category: File Type Specific
# Tags: binary, hex, xxd, hexedit, file
---
Edit binary files using xxd hex editor integration.

```vim
" Binary file detection and hex mode
:autocmd BufNewFile,BufRead *.bin setfiletype xxd

" Enter hex mode
command! HexMode :%!xxd
command! HexModeReverse :%!xxd -r

" Auto hex mode for binary files
:autocmd BufReadPost *.bin silent %!xxd
:autocmd BufWritePre *.bin %!xxd -r
:autocmd BufWritePost *.bin silent %!xxd
:autocmd BufReadPost *.bin set filetype=xxd
```
***
# Title: Template file creation
# Category: File Type Specific
# Tags: template, skeleton, file, creation, boilerplate
---
Automatically insert templates for new files based on file type.

```vim
" Template insertion for new files
:autocmd BufNewFile *.py 0r ~/.config/nvim/templates/python.py
:autocmd BufNewFile *.js 0r ~/.config/nvim/templates/javascript.js
:autocmd BufNewFile *.html 0r ~/.config/nvim/templates/html5.html
:autocmd BufNewFile *.css 0r ~/.config/nvim/templates/styles.css
:autocmd BufNewFile *.sh 0r ~/.config/nvim/templates/bash.sh

" Replace template variables
:autocmd BufNewFile * %s/{{FILENAME}}/\=expand('%:t:r')/g
:autocmd BufNewFile * %s/{{DATE}}/\=strftime('%Y-%m-%d')/g
:autocmd BufNewFile * %s/{{AUTHOR}}/\=system('git config user.name')[:-2]/g
```
***
