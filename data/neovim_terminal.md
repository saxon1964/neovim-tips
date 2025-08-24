# Title: Terminal buffer job control
# Category: Terminal
# Tags: terminal, job, control, process
---
Use `jobstart()` and `jobstop()` to manage background processes and communicate with terminal jobs.

#### Example

```vim
:lua local job_id = vim.fn.jobstart({'python', 'script.py'}, {
  on_stdout = function(id, data) print(table.concat(data, '\n')) end
})
:lua vim.fn.jobstop(job_id)
```
===
# Title: Terminal mode key mappings
# Category: Terminal
# Tags: terminal, mode, mappings, tnoremap
---
Use terminal mode mappings to customize key behavior inside built-in terminal emulator.

#### Example

```vim
:tnoremap <Esc> <C-\><C-n>                    " easier normal mode
:tnoremap <C-w>h <C-\><C-n><C-w>h            " window navigation
:tnoremap <A-h> <C-\><C-n><C-w>h            " alt+h navigation
:tnoremap <C-]> <C-\><C-n>:q<CR>            " quick close
```
===
# Title: Terminal scrollback and history
# Category: Terminal
# Tags: terminal, scrollback, history, buffer
---
Use `scrollback` option to control terminal history and access previous output in terminal buffers.

#### Example

```vim
:set termguicolors        " enable 24-bit colors
:let g:terminal_scrollback_buffer_size = 10000
:terminal                 " open terminal
" In terminal: <C-\><C-n> then /pattern to search history
```
===
# Title: Split terminal workflows
# Category: Terminal
# Tags: terminal, split, workflow, development
---
Use terminal splits for integrated development workflows without leaving Neovim.

#### Example

```vim
:split | terminal         " horizontal split terminal
:vsplit | terminal        " vertical split terminal  
:tabnew | terminal        " terminal in new tab
" Create persistent terminal splits for common tasks
```
===
# Title: Terminal with specific shell
# Category: Terminal
# Tags: terminal, shell, specific, custom
---
Use `:terminal` with specific shell or command for customized terminal environments.

#### Example

```vim
:terminal bash            " specific shell
:terminal python3         " Python REPL
:terminal node            " Node.js REPL
:terminal zsh -c 'cd ~/project && zsh'  " custom environment
```
===
# Title: Terminal buffer naming
# Category: Terminal
# Tags: terminal, buffer, naming, identification
---
Use buffer naming to identify and switch between multiple terminal instances easily.

#### Example

```vim
:terminal ++title=server " named terminal buffer
:terminal ++title=build
:ls                      " shows named terminal buffers
:buffer server           " switch to named terminal
```
===
# Title: Terminal environment variables
# Category: Terminal
# Tags: terminal, environment, variables, env
---
Use environment variable control for terminal processes launched from Neovim.

#### Example

```vim
:let $EDITOR = 'nvim'
:let $TERM = 'xterm-256color'
:terminal env              " show environment
:terminal ENV_VAR=value command  " set env var for command
```
===
# Title: Terminal with working directory
# Category: Terminal
# Tags: terminal, working, directory, cwd
---
Use `++cwd` to start terminals in specific working directories for project-based workflows.

#### Example

```vim
:terminal ++cwd=~/project " start in specific directory
:split | terminal ++cwd=%:h " terminal in current file's directory
:lua vim.cmd('terminal ++cwd=' .. vim.fn.expand('%:h'))
```
===
# Title: Terminal size and dimensions
# Category: Terminal
# Tags: terminal, size, dimensions, rows, cols
---
Use terminal size options to create terminals with specific dimensions for different tasks.

#### Example

```vim
:terminal ++rows=20       " terminal with 20 rows
:terminal ++cols=80       " terminal with 80 columns
:20split | terminal       " split with specific height
:vertical 80split | terminal  " split with specific width
```
===
# Title: Terminal process communication
# Category: Terminal
# Tags: terminal, process, communication, stdin
---
Use `chansend()` to send input to terminal processes programmatically.

#### Example

```vim
:lua local term_id = vim.fn.bufnr()
:lua vim.fn.chansend(term_id, "ls -la\n")
:lua vim.fn.chansend(term_id, {"python", "-c", "print('hello')", "\n"})
" Send commands to terminal buffer programmatically
```
===
# Title: Terminal output processing
# Category: Terminal
# Tags: terminal, output, processing, callback
---
Use terminal output callbacks to process terminal output and integrate with editor workflows.

#### Example

```vim
:lua vim.fn.termopen('make', {
  on_exit = function(job_id, exit_code, event_type)
    if exit_code == 0 then 
      vim.cmd('echo "Build successful!"')
    else
      vim.cmd('copen')
    end
  end
})
```
===
# Title: Hidden terminal processes
# Category: Terminal
# Tags: terminal, hidden, background, process
---
Use hidden terminals to run background processes while maintaining editor workflow.

#### Example

```vim
:lua local buf = vim.api.nvim_create_buf(false, true)
:lua local job = vim.fn.termopen('tail -f logfile.log', {
  stdout_buffered = true,
  on_stdout = function(id, data) 
    -- Process log data
  end
})
```
===
# Title: Terminal color and appearance
# Category: Terminal
# Tags: terminal, color, appearance, highlight
---
Use terminal-specific highlighting and color configuration for better visual integration.

#### Example

```vim
:hi Terminal ctermfg=white ctermbg=black
:hi TermCursor ctermfg=red ctermbg=red
:hi TermCursorNC ctermfg=white ctermbg=darkgray
:set termguicolors  " enable 24-bit colors in terminal
```
===
# Title: Terminal autocmd events
# Category: Terminal
# Tags: terminal, autocmd, events, TermOpen
---
Use terminal-specific autocommand events to customize terminal behavior and appearance.

#### Example

```vim
:autocmd TermOpen * setlocal nonumber norelativenumber
:autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
:autocmd TermClose * echo "Terminal closed"
:autocmd TermEnter * startinsert  " enter insert mode
```
===
# Title: Terminal and quickfix integration
# Category: Terminal
# Tags: terminal, quickfix, integration, errors
---
Use terminal output parsing to populate quickfix list with build errors and navigation.

#### Example

```vim
:set errorformat=%f:%l:%m  " set error format
:terminal make 2>&1 | tee build.log
" Then: :cfile build.log to load errors into quickfix
:lua vim.api.nvim_create_autocmd('TermClose', {
  callback = function() vim.cmd('cfile build.log') end
})
```
===
# Title: Terminal session persistence
# Category: Terminal
# Tags: terminal, session, persistence, restore
---
Use terminal session restoration to maintain terminal state across Neovim sessions.

#### Example

```vim
" In session file, terminals are saved as:
:terminal ++restore
" Or create custom session saving:
:lua function save_terminals()
  -- Custom logic to save terminal commands/state
end
```
===
# Title: Terminal window management
# Category: Terminal
# Tags: terminal, window, management, layout
---
Use advanced window management for terminal-focused layouts and workflows.

#### Example

```vim
:tabnew | terminal        " dedicated terminal tab
:only | split | terminal  " editor above, terminal below
:vsplit | terminal | vertical resize 80  " side terminal
" Create terminal-focused layout commands
```
===
# Title: Terminal plugin integration
# Category: Terminal
# Tags: terminal, plugin, integration, compatibility
---
Use terminal integration patterns that work well with common Neovim plugins and workflows.

#### Example

```vim
" Terminal-friendly settings
:autocmd TermOpen * setlocal statusline=%{b:term_title}
:autocmd TermOpen * lua vim.wo.winhighlight = "Normal:TermNormal"
:autocmd BufEnter term://* startinsert  " auto enter insert mode
```
===
# Title: Terminal debugging integration
# Category: Terminal
# Tags: terminal, debugging, gdb, integration
---
Use terminal for integrated debugging sessions with GDB, Python debugger, or other CLI debuggers.

#### Example

```vim
:terminal gdb ./program   " GDB in terminal
:terminal python -m pdb script.py  " Python debugger
" Use terminal splits to debug while viewing source
:split | edit source.c | split | terminal gdb ./program
```
===
# Title: Terminal REPL workflows
# Category: Terminal
# Tags: terminal, repl, workflow, interactive
---
Use terminal for REPL-driven development with language-specific interactive environments.

#### Example

```vim
:terminal python3         " Python REPL
:terminal node            " Node.js REPL
:terminal irb             " Ruby IRB  
:terminal ghci            " Haskell GHCi
" Send code from buffer to REPL using mappings
```
===