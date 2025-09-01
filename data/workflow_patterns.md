# Title: Project workspace initialization
# Category: Workflow Patterns
# Tags: workspace, project, initialize, setup, session
---
Establish consistent project workspace patterns for efficient development.

```lua
-- Auto-detect project root and setup workspace
local function setup_project_workspace()
  local root_patterns = {'.git', 'package.json', 'Cargo.toml', 'go.mod', 'requirements.txt'}
  local root = vim.fs.dirname(vim.fs.find(root_patterns, {upward = true})[1])
  
  if root then
    vim.cmd('cd ' .. root)
    -- Load project-specific settings
    local project_config = root .. '/.nvimrc'
    if vim.fn.filereadable(project_config) == 1 then
      vim.cmd('source ' .. project_config)
    end
  end
end

vim.api.nvim_create_autocmd('VimEnter', { callback = setup_project_workspace })
```
===
# Title: Multi-file editing workflow
# Category: Workflow Patterns
# Tags: multi-file, editing, buffer, window, navigation
---
Efficient patterns for working with multiple files simultaneously.

```vim
" Quick file switching workflow
nnoremap <leader>b :buffers<CR>:buffer<Space>
nnoremap <leader>f :find<Space>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Split and tab workflow
nnoremap <leader>v :vsplit<CR>:find<Space>
nnoremap <leader>s :split<CR>:find<Space>  
nnoremap <leader>t :tabnew<CR>:find<Space>

" Quick jump between related files
nnoremap <leader>a :find %:r.*<CR>  " find files with same basename
```
===
# Title: Search and replace workflow
# Category: Workflow Patterns
# Tags: search, replace, refactor, pattern, workflow
---
Systematic approach to search and replace operations across projects.

```vim
" Progressive search and replace workflow
" 1. Search and review
:vimgrep /old_function/j **/*.py
:copen

" 2. Confirm matches visually
:cfdo %s/old_function/new_function/gc

" 3. Save all changed files
:cfdo update

" Macro for complex replacements
:let @r = 'ciwnew_name<Esc>n'  " record replacement macro
:argdo normal @r               " apply to all files in arglist
:argdo update                  " save all changes
```
===
# Title: Code review and annotation workflow
# Category: Workflow Patterns
# Tags: review, annotation, comment, feedback, collaboration
---
Systematic code review and annotation patterns for collaboration.

```vim
" Code review annotations
:nnoremap <leader>rc A  // REVIEW: 
:nnoremap <leader>rt A  // TODO: 
:nnoremap <leader>rf A  // FIXME: 
:nnoremap <leader>rq A  // QUESTION: 

" Extract review comments
:vimgrep /\/\/ REVIEW:/j **/*.py
:vimgrep /\/\/ TODO:/j **/*.py

" Review checklist workflow
function! ReviewChecklist()
  :tabnew REVIEW.md
  :put ='## Code Review Checklist'
  :put ='- [ ] Logic correctness'
  :put ='- [ ] Performance considerations'
  :put ='- [ ] Error handling'
  :put ='- [ ] Test coverage'
endfunction
```
===
# Title: Testing and debugging workflow
# Category: Workflow Patterns
# Tags: testing, debugging, workflow, development, tdd
---
Integrated testing and debugging workflow patterns.

```vim
" Test-driven development workflow
:nnoremap <leader>tt :!npm test %<CR>      " test current file
:nnoremap <leader>ta :!npm test<CR>        " test all
:nnoremap <leader>tw :!npm test -- --watch<CR>  " watch mode

" Debugging workflow
:nnoremap <leader>db Oprint(f"DEBUG: {}")<Left><Left>
:nnoremap <leader>dl :g/print.*DEBUG/d    " remove debug lines

" Error navigation workflow
:nnoremap <leader>en :cnext<CR>
:nnoremap <leader>ep :cprevious<CR>
:nnoremap <leader>el :clist<CR>
```
===
# Title: Documentation workflow
# Category: Workflow Patterns  
# Tags: documentation, writing, markdown, workflow, notes
---
Efficient documentation and note-taking workflow patterns.

```vim
" Documentation templates
function! InsertDocTemplate()
  :put ='# ' . expand('%:t:r')
  :put =''
  :put ='## Overview'
  :put =''
  :put ='## Usage'
  :put =''
  :put ='## Examples'
  :put =''
  :put ='## API'
endfunction

" Quick note-taking
:nnoremap <leader>nd :edit ~/notes/daily/<C-R>=strftime('%Y-%m-%d')<CR>.md<CR>
:nnoremap <leader>np :edit ~/notes/projects/<C-R>=expand('%:h:t')<CR>.md<CR>

" Link insertion for markdown
:nnoremap <leader>ml i[]()<Left><Left><Left>
```
===
# Title: Git workflow integration  
# Category: Workflow Patterns
# Tags: git, workflow, version, control, branch, merge
---
Comprehensive Git workflow patterns integrated with editing.

```vim
" Git workflow commands
:nnoremap <leader>gs :!git status<CR>
:nnoremap <leader>ga :!git add %<CR>
:nnoremap <leader>gc :!git commit -v<CR>
:nnoremap <leader>gd :!git diff %<CR>
:nnoremap <leader>gl :!git log --oneline -10<CR>

" Branch workflow
:nnoremap <leader>gb :!git checkout -b feature/
:nnoremap <leader>gm :!git checkout main && git pull<CR>

" Commit message templates
function! CommitTemplate(type)
  :tabnew
  :put =a:type . ': '
  :put =''
  :put ='## What'
  :put =''
  :put ='## Why'
  :startinsert!
endfunction

:command! -nargs=1 Commit call CommitTemplate(<args>)
```
===
# Title: Configuration management workflow
# Category: Workflow Patterns
# Tags: configuration, dotfiles, settings, management, sync
---
Systematic configuration and dotfile management patterns.

```vim
" Configuration editing shortcuts  
:nnoremap <leader>ev :edit $MYVIMRC<CR>
:nnoremap <leader>sv :source $MYVIMRC<CR>
:nnoremap <leader>ep :edit ~/.zshrc<CR>
:nnoremap <leader>et :edit ~/.tmux.conf<CR>

" Configuration backup workflow
function! BackupConfig()
  :!cp $MYVIMRC ~/.config/backup/init.vim.$(date +%Y%m%d)
  echo "Configuration backed up"
endfunction

" Dotfile synchronization
:nnoremap <leader>ds :!cd ~/dotfiles && git add . && git commit -m "Update config" && git push<CR>
```
===
# Title: Refactoring workflow patterns
# Category: Workflow Patterns
# Tags: refactoring, code, restructure, improve, workflow
---
Systematic code refactoring and improvement workflow patterns.

```vim
" Extract function refactoring
function! ExtractFunction() range
  let function_name = input('Function name: ')
  if !empty(function_name)
    '<,'>delete
    put ='def ' . function_name . '():'
    put ='    # extracted code here'
    put =''
    normal! O    return result
  endif
endfunction

" Rename variable workflow  
:nnoremap <leader>rr :%s/\<<C-r><C-w>\>//g<Left><Left>
:nnoremap <leader>rf :bufdo %s/\<<C-r><C-w>\>//ge | update<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" Refactoring checklist
function! RefactorChecklist()
  :put ='## Refactoring Checklist'
  :put ='- [ ] Tests still pass'
  :put ='- [ ] No functionality changes'  
  :put ='- [ ] Code is cleaner/more readable'
  :put ='- [ ] Performance maintained'
endfunction
```
===
# Title: Build and deployment workflow
# Category: Workflow Patterns
# Tags: build, deployment, release, workflow, automation
---
Integrated build and deployment workflow patterns.

```vim
" Build workflow shortcuts
:nnoremap <leader>bb :!make build<CR>
:nnoremap <leader>bt :!make test<CR>
:nnoremap <leader>bc :!make clean<CR>
:nnoremap <leader>br :!make run<CR>

" Deployment workflow
function! DeploymentChecklist()
  :put ='## Deployment Checklist'
  :put ='- [ ] Tests pass'
  :put ='- [ ] Version bumped'
  :put ='- [ ] Changelog updated'
  :put ='- [ ] Documentation updated'
  :put ='- [ ] Backup created'
endfunction

" Release workflow
:nnoremap <leader>rv :!git tag v<C-R>=input('Version: ')<CR><CR>
:nnoremap <leader>rp :!git push --tags<CR>
```
===
# Title: Learning and experimentation workflow
# Category: Workflow Patterns
# Tags: learning, experiment, playground, practice, workflow
---
Structured learning and experimentation workflow patterns.

```vim
" Learning workspace setup
function! SetupPlayground(language)
  let playground_dir = '~/playground/' . a:language
  execute 'edit' playground_dir . '/experiment.py'
  
  " Insert learning template
  :put ='# Learning ' . a:language . ' - ' . strftime('%Y-%m-%d')
  :put ='# Goal: '
  :put =''
  :put ='# Experiment:'
  :put =''
  :put ='# Notes:'
  :put =''
  :put ='# Resources:'
endfunction

:command! -nargs=1 Playground call SetupPlayground(<args>)

" Quick snippet testing
:nnoremap <leader>lt :tabnew /tmp/test.<C-R>=input('Extension: ')<CR><CR>
```
===
# Title: Focus and distraction management
# Category: Workflow Patterns
# Tags: focus, distraction, productivity, workflow, zen
---
Patterns for maintaining focus and minimizing distractions during coding.

```vim
" Focus mode - minimize distractions
function! FocusMode()
  :set nonumber
  :set norelativenumber
  :set signcolumn=no
  :set laststatus=0
  :set noshowcmd
  :set noshowmode
  :set colorcolumn=
  echo "Focus mode enabled"
endfunction

:command! Focus call FocusMode()

" Pomodoro integration
function! StartPomodoro(minutes)
  echo "Starting " . a:minutes . " minute focus session"
  execute "!timer " . (a:minutes * 60) . " &"
endfunction

:command! -nargs=? Pomodoro call StartPomodoro(<args> ? <args> : 25)
```
===
# Title: Session and workspace persistence
# Category: Workflow Patterns
# Tags: session, workspace, persistence, restore, save
---
Patterns for saving and restoring work sessions and workspace state.

```vim
" Automatic session management
function! SaveSession()
  let session_dir = '~/.config/nvim/sessions/'
  let session_name = substitute(getcwd(), '/', '_', 'g')
  execute 'mksession! ' . session_dir . session_name . '.vim'
endfunction

function! LoadSession()
  let session_dir = '~/.config/nvim/sessions/'
  let session_name = substitute(getcwd(), '/', '_', 'g')
  let session_file = session_dir . session_name . '.vim'
  
  if filereadable(expand(session_file))
    execute 'source ' . session_file
  endif
endfunction

" Auto-save session on exit
:autocmd VimLeave * call SaveSession()
:autocmd VimEnter * call LoadSession()
```
===
# Title: Code review and collaboration workflow
# Category: Workflow Patterns
# Tags: collaboration, review, feedback, team, workflow
---
Systematic collaboration and code review workflow patterns.

```vim
" Collaboration markers
:nnoremap <leader>cr A  // CR: 
:nnoremap <leader>ca A  // APPROVED: 
:nnoremap <leader>cq A  // QUESTION: 
:nnoremap <leader>cs A  // SUGGESTION: 

" Review workflow
function! StartReview(branch)
  execute '!git checkout ' . a:branch
  :tabnew REVIEW_NOTES.md
  :put ='# Code Review: ' . a:branch
  :put ='## Files Changed:'
  :r !git diff --name-only HEAD~1
  :put =''
  :put ='## Comments:'
endfunction

:command! -nargs=1 Review call StartReview(<args>)
```
===
# Title: Error handling and debugging patterns
# Category: Workflow Patterns
# Tags: error, debugging, troubleshoot, workflow, pattern
---
Systematic error handling and debugging workflow patterns.

```vim
" Debug logging workflow
function! AddDebugLogging()
  let line_num = line('.')
  let debug_line = 'console.log("DEBUG line ' . line_num . ':", );'
  call append(line('.'), '    ' . debug_line)
  normal! j$F:
  startinsert!
endfunction

:nnoremap <leader>dl :call AddDebugLogging()<CR>

" Error investigation workflow
function! InvestigateError()
  :tabnew ERROR_INVESTIGATION.md
  :put ='# Error Investigation - ' . strftime('%Y-%m-%d')
  :put ='## Problem:'
  :put ='## Steps to Reproduce:'
  :put ='## Expected vs Actual:'
  :put ='## Investigation:'
  :put ='## Solution:'
endfunction

:nnoremap <leader>ei :call InvestigateError()<CR>
```
===
# Title: Performance profiling workflow
# Category: Workflow Patterns
# Tags: performance, profiling, optimization, workflow, analysis
---
Systematic performance analysis and optimization workflow patterns.

```vim
" Performance profiling setup
function! StartProfiling()
  :put ='# Performance Analysis - ' . strftime('%Y-%m-%d')
  :put ='## Baseline Measurements:'
  :put ='## Bottleneck Areas:'
  :put ='## Optimization Plan:'
  :put ='## Results:'
endfunction

" Performance markers
:nnoremap <leader>ps A  # PERF_START
:nnoremap <leader>pe A  # PERF_END  
:nnoremap <leader>pt A  # TODO: Optimize this section

" Benchmark workflow
:nnoremap <leader>pb :!time python %<CR>
:nnoremap <leader>pm :!python -m cProfile %<CR>
```
===
# Title: Knowledge management workflow
# Category: Workflow Patterns
# Tags: knowledge, documentation, notes, learning, workflow
---
Systematic knowledge capture and documentation workflow patterns.

```vim
" Knowledge base organization
function! CreateNote(category, title)
  let note_path = '~/knowledge/' . a:category . '/' . a:title . '.md'
  execute 'edit ' . note_path
  :put ='# ' . substitute(a:title, '_', ' ', 'g')
  :put ='Created: ' . strftime('%Y-%m-%d')
  :put ='Tags: '
  :put =''
  :put ='## Summary'
  :put =''
  :put ='## Details'
  :put =''
  :put ='## Examples'
  :put =''
  :put ='## References'
endfunction

:command! -nargs=* Note call CreateNote(<f-args>)

" Quick research capture
:nnoremap <leader>nq :put ='**Q: ' . input('Question: ') . '**'<CR>
:nnoremap <leader>na :put ='**A: ' . input('Answer: ') . '**'<CR>
```
===
# Title: Code quality and standards workflow
# Category: Workflow Patterns
# Tags: quality, standards, lint, format, workflow
---
Systematic code quality and standards enforcement workflow patterns.

```vim
" Code quality checks
:nnoremap <leader>ql :!eslint %<CR>        " JavaScript linting
:nnoremap <leader>qf :!prettier --write %<CR>  " Format file
:nnoremap <leader>qp :!pylint %<CR>       " Python linting
:nnoremap <leader>qr :!rubocop %<CR>      " Ruby linting

" Pre-commit quality workflow
function! PreCommitChecks()
  :!eslint .
  :!prettier --check .
  :!npm test
  echo "Pre-commit checks completed"
endfunction

:command! PreCommit call PreCommitChecks()

" Quality metrics tracking
function! QualityReport()
  :put ='# Code Quality Report - ' . strftime('%Y-%m-%d')
  :put ='## Lint Issues:'
  :r !eslint . --format compact | wc -l
  :put ='## Test Coverage:'
  :r !npm run coverage | tail -1
endfunction
```
===
# Title: Backup and recovery workflow
# Category: Workflow Patterns
# Tags: backup, recovery, safety, workflow, protection
---
Systematic backup and recovery workflow patterns for data protection.

```vim
" Automatic backup workflow
function! CreateBackup()
  let backup_dir = expand('~/.local/share/nvim/backups/')
  let timestamp = strftime('%Y%m%d_%H%M%S')
  let backup_file = backup_dir . expand('%:t') . '.' . timestamp
  
  if !isdirectory(backup_dir)
    call mkdir(backup_dir, 'p')
  endif
  
  execute 'write ' . backup_file
  echo "Backup saved: " . backup_file
endfunction

:command! Backup call CreateBackup()

" Recovery workflow
function! ShowBackups()
  let backup_dir = expand('~/.local/share/nvim/backups/')
  let current_file = expand('%:t')
  execute 'edit ' . backup_dir
  execute '/' . current_file
endfunction

:command! Recovery call ShowBackups()

" Auto-backup on save
:autocmd BufWritePre *.{py,js,lua,vim} call CreateBackup()
```
===
