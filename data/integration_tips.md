# Title: Git integration and workflow
# Category: Integration
# Tags: git, version, control, fugitive, workflow
---
Integrate Git operations seamlessly with Neovim editing workflow.

```vim
" Git status and operations
:!git status                 " check git status
:!git add %                 " add current file
:!git commit -m "message"   " commit with message
:!git diff %                " diff current file

" Using terminal integration
:terminal git log --oneline " view git log in terminal
:terminal git commit        " interactive commit
```
***
# Title: System clipboard integration
# Category: Integration
# Tags: clipboard, system, copy, paste, register
---
Seamlessly integrate with system clipboard for cross-application workflows.

```lua
-- Configure clipboard integration
vim.opt.clipboard = 'unnamedplus'  -- use system clipboard

-- Manual clipboard operations
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y')  -- copy to system clipboard
vim.keymap.set({'n', 'v'}, '<leader>p', '"+p')  -- paste from system clipboard

-- Check clipboard availability
print(vim.fn.has('clipboard'))
```
***
# Title: Terminal multiplexer integration
# Category: Integration
# Tags: tmux, screen, multiplexer, pane, session
---
Integrate with terminal multiplexers for enhanced workflow management.

```vim
" Tmux integration
:!tmux new-session -d -s work    " create tmux session
:!tmux send-keys -t work 'cd project' C-m  " send commands to tmux

" Screen integration  
:!screen -S build -d -m make    " run make in screen session
:!screen -r build              " reattach to screen session

" Neovim terminal with tmux-like behavior
vim.keymap.set('t', '<C-\\><C-n>', '<C-\\><C-n>')  -- escape terminal mode
```
***
# Title: Browser and documentation integration
# Category: Integration
# Tags: browser, documentation, help, external, web
---
Open external documentation and web resources from Neovim.

```vim
" Open URLs under cursor
:!open <cfile>              " macOS
:!xdg-open <cfile>          " Linux
:!start <cfile>             " Windows

" Language-specific documentation
:!open https://docs.python.org/3/search.html?q=<cword>  " Python docs
:!firefox "https://developer.mozilla.org/en-US/search?q=<cword>"  " MDN docs

" Custom function for smart URL opening
function! OpenURL()
  let url = expand('<cfile>')
  if url =~ '^https\?://'
    execute '!open ' . shellescape(url)
  else
    echo "Not a valid URL"
  endif
endfunction
```
***
# Title: Database integration and querying
# Category: Integration
# Tags: database, sql, query, connection, dadbod
---
Connect to and query databases directly from Neovim.

```vim
" Using vim-dadbod for database operations
:DB postgresql://user:pass@localhost/dbname
SELECT * FROM users;

" Execute SQL from buffer
:%DB                        " execute entire buffer
:'<,'>DB                   " execute visual selection

" Save connection for reuse
:let g:db = 'postgresql://localhost/mydb'
:DB g:db SELECT COUNT(*) FROM products;
```
***
# Title: REST API testing integration
# Category: Integration
# Tags: rest, api, http, curl, testing, client
---
Test REST APIs directly from Neovim using HTTP client functionality.

```vim
" Using rest.nvim or similar plugins
POST https://api.example.com/users
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com"
}

" Curl integration
:!curl -X POST -H "Content-Type: application/json" \
  -d '{"name":"test"}' https://api.example.com/users

" Save API responses
:r !curl -s https://api.github.com/users/octocat
```
***
# Title: Docker and container integration  
# Category: Integration
# Tags: docker, container, dockerfile, build, run
---
Integrate Docker operations with Neovim development workflow.

```vim
" Docker build and run
:!docker build -t myapp .
:!docker run -it myapp
:!docker ps                 " list running containers

" Docker compose integration
:!docker-compose up -d      " start services
:!docker-compose logs -f web " follow logs

" Edit files in running container
:!docker exec -it container_name vi /app/config.yml
```
***
# Title: Cloud platform integration
# Category: Integration
# Tags: cloud, aws, gcp, azure, kubectl, terraform
---
Integrate with cloud platforms and infrastructure tools.

```vim
" Kubernetes integration
:!kubectl get pods
:!kubectl logs pod-name -f  " follow logs
:!kubectl describe pod pod-name

" AWS CLI integration
:!aws s3 ls s3://bucket-name
:!aws logs tail /aws/lambda/function-name --follow

" Terraform integration
:!terraform plan
:!terraform apply
```
***
# Title: Package manager integration
# Category: Integration
# Tags: package, manager, npm, pip, cargo, gem
---
Integrate with various package managers for dependency management.

```vim
" Node.js/npm integration
:!npm install              " install dependencies
:!npm run test             " run tests
:!npm run build            " build project

" Python/pip integration
:!pip install -r requirements.txt
:!python -m pytest        " run tests

" Rust/cargo integration
:!cargo build              " build project
:!cargo test               " run tests
:!cargo run                " run project
```
***
# Title: Continuous Integration integration
# Category: Integration
# Tags: ci, cd, github, actions, jenkins, pipeline
---
Integrate with CI/CD pipelines and automation systems.

```vim
" GitHub Actions
:e .github/workflows/main.yml
:!gh workflow list         " list workflows
:!gh run list              " list workflow runs

" Jenkins integration
:!curl -X POST http://jenkins.local/job/my-job/build
:r !curl -s http://jenkins.local/job/my-job/lastBuild/api/json

" GitLab CI integration
:e .gitlab-ci.yml
:!curl --header "PRIVATE-TOKEN: token" \
  "https://gitlab.com/api/v4/projects/ID/pipelines"
```
***
# Title: Monitoring and logging integration
# Category: Integration
# Tags: monitoring, logging, logs, metrics, observability
---
Integrate with monitoring and logging systems for development insights.

```vim
" Log file monitoring
:!tail -f /var/log/app.log  " follow log file
:terminal tail -f logs/production.log

" Grep through logs
:!grep ERROR /var/log/app.log | tail -20
:!journalctl -u service-name -f  " systemd logs

" Custom log analysis
function! AnalyzeLogs()
  :r !grep -c ERROR logs/*.log
  :r !grep -c WARN logs/*.log
endfunction
```
***
# Title: Email and notification integration  
# Category: Integration
# Tags: email, notification, alert, smtp, webhook
---
Send notifications and emails from Neovim for workflow automation.

```vim
" Send email notifications
:!echo "Build completed" | mail -s "Build Status" user@example.com
:!curl -X POST -H 'Content-type: application/json' \
  --data '{"text":"Deployment finished"}' \
  https://hooks.slack.com/webhook-url

" Desktop notifications
:!notify-send "Neovim" "Operation completed"  " Linux
:!osascript -e 'display notification "Done" with title "Neovim"'  " macOS
```
***
# Title: SSH and remote development integration
# Category: Integration
# Tags: ssh, remote, development, server, connection
---
Integrate SSH operations for remote development workflows.

```vim
" SSH operations
:!ssh user@server 'ls -la /project'
:!scp % user@server:/path/to/destination/

" Remote editing with netrw
:e scp://user@server//path/to/file
:browse scp://user@server//home/user/

" SSH tunnel management
:!ssh -L 8080:localhost:80 user@server -N -f  " create tunnel
:!kill $(ps aux | grep 'ssh.*8080' | awk '{print $2}')  " close tunnel
```
***
# Title: External editor integration
# Category: Integration  
# Tags: editor, external, gui, comparison, merge
---
Integrate with external editors for specific tasks and workflows.

```vim
" Open in external editor
:!code %                   " VS Code
:!subl %                   " Sublime Text
:!atom %                   " Atom

" Merge tool integration
:!meld % file2.txt         " visual diff/merge
:!vimdiff % backup/%       " vim diff mode

" GUI text editor for complex formatting
:!libreoffice --writer %   " word processing
:!typora %                 " markdown editor
```
***
# Title: Build system integration
# Category: Integration
# Tags: build, make, cmake, gradle, maven, build
---
Integrate with various build systems and compilation tools.

```vim
" Make integration
:make                      " run make with error parsing
:make clean               " clean build
:make install             " install build

" CMake integration  
:!cmake -B build .        " configure build
:!cmake --build build     " compile
:!ctest --test-dir build  " run tests

" Gradle/Maven integration
:!./gradlew build         " gradle build
:!mvn compile test        " maven compile and test
```
***
# Title: Version control system integration
# Category: Integration
# Tags: vcs, svn, mercurial, bazaar, perforce
---
Integrate with various version control systems beyond Git.

```vim
" Subversion integration
:!svn status              " check status
:!svn diff %              " diff current file
:!svn commit -m "message" " commit changes

" Mercurial integration
:!hg status               " check status
:!hg diff %               " diff current file
:!hg commit -m "message"  " commit changes

" Perforce integration
:!p4 edit %               " check out for edit
:!p4 diff %               " show differences
:!p4 submit               " submit changelist
```
***
# Title: API and webhook integration
# Category: Integration
# Tags: api, webhook, http, rest, automation
---
Integrate with APIs and webhooks for automation and data exchange.

```vim
" Webhook notifications
function! NotifyWebhook(message)
  let payload = '{"text": "' . a:message . '"}'
  call system('curl -X POST -H "Content-Type: application/json" -d ' 
    \ . shellescape(payload) . ' https://hooks.example.com/webhook')
endfunction

" API data fetching
:r !curl -s "https://api.github.com/repos/owner/repo/issues"
:r !curl -H "Authorization: token TOKEN" "https://api.github.com/user"

" Auto-update from API
autocmd BufWritePost *.md call NotifyWebhook("Documentation updated")
```
***
# Title: Development server integration
# Category: Integration
# Tags: server, development, hot, reload, livereload
---
Integrate with development servers and hot reload systems.

```vim
" Start development servers
:!npm start &             " start Node.js server in background
:!python -m http.server 8000 &  " start Python HTTP server
:!php -S localhost:8000 & " start PHP development server

" Auto-reload on save
autocmd BufWritePost *.js !kill -USR2 $(cat .pid)  " reload Node.js
autocmd BufWritePost *.py !touch /tmp/reload      " trigger reload

" LiveReload integration
:!livereload --wait 200 --extraExts 'vue,jsx'
```
***
# Title: Issue tracking integration
# Category: Integration
# Tags: issue, tracking, jira, github, gitlab, bug
---
Integrate with issue tracking systems for development workflow.

```vim
" GitHub Issues integration
:!gh issue list           " list open issues
:!gh issue create --title "Bug report" --body "Description"
:!gh issue close 123      " close issue

" JIRA integration (via CLI)
:!jira list               " list issues
:!jira create --project=PROJ --type=Bug --summary="Title"

" Custom issue templates
:r ~/.config/nvim/templates/bug-report.md
:r ~/.config/nvim/templates/feature-request.md
```
***
# Title: Documentation generation integration
# Category: Integration
# Tags: documentation, generate, doxygen, sphinx, javadoc
---
Integrate documentation generation tools with editing workflow.

```vim
" Doxygen integration
:!doxygen Doxyfile        " generate documentation
:!open docs/html/index.html  " view generated docs

" Sphinx integration (Python)
:!make html               " build Sphinx docs
:!sphinx-autobuild . _build/html  " auto-rebuild on changes

" JSDoc integration
:!jsdoc -d docs/ src/     " generate JavaScript docs
:!npm run docs            " run documentation build script
```
***
# Title: Testing framework integration
# Category: Integration
# Tags: testing, framework, jest, pytest, rspec, junit
---
Integrate with various testing frameworks for efficient testing workflow.

```vim
" Jest integration (JavaScript)
:!npm test                " run all tests
:!npx jest %              " test current file
:!npx jest --watch        " watch mode

" pytest integration (Python)
:!python -m pytest %     " test current file
:!python -m pytest -v    " verbose test output
:!python -m pytest --cov " coverage report

" Go test integration
:!go test                 " run tests in current package
:!go test -v ./...        " verbose tests for all packages
```
***
