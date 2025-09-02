--- Centralized rendering logic for markdown preview
--- Chooses the configured renderer and renders the given buffer
local M = {}

local config = require("neovim_tips.config")

-- Run a function with the buffer set and, if available, inside a window that displays it.
-- Some renderers (like Markview) are window-sensitive and behave more reliably in a window context.
local function with_buffer_context(bufnr, fn)
  local winid = vim.fn.bufwinid(bufnr)
  if winid ~= -1 and vim.api.nvim_win_is_valid(winid) then
    vim.api.nvim_win_call(winid, function()
      if vim.api.nvim_get_current_buf() ~= bufnr then
        vim.api.nvim_set_current_buf(bufnr)
      end
      fn()
    end)
  else
    vim.api.nvim_buf_call(bufnr, fn)
  end
end

-- Open all folds and disable folding in the current window
local function open_folds()
  pcall(vim.cmd, "silent! normal! zR")
  vim.wo.foldlevel = 99
  vim.wo.foldenable = false
  vim.wo.foldmethod = "manual"
end

---Render markdown in a buffer according to configured renderer
---@param bufnr integer|nil Buffer number to render (defaults to current buffer)
function M.render(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local renderer = config.options.renderer

  if renderer == "markview" then
    -- Use markview.nvim: force refresh by disabling and enabling via user commands
    with_buffer_context(bufnr, function()
      -- Disable then enable; wrap in pcall in case commands are unavailable
      pcall(vim.cmd, "Markview disable")
      pcall(vim.cmd, "Markview enable")
      open_folds()
    end)
  else
    -- Default: render-markdown.nvim via user commands (supports lazy-loading by cmd)
    with_buffer_context(bufnr, function()
      pcall(vim.cmd, "RenderMarkdown disable")
      pcall(vim.cmd, "RenderMarkdown enable")
      open_folds()
    end)
  end
end

return M

