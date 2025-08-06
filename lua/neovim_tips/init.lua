local M = {}
local config = require("neovim_tips.config")
local loader = require("neovim_tips.loader")
local ui = require("neovim_tips.ui")

function M.setup(opts)
  config.setup(opts)
  loader.load()

  vim.api.nvim_create_user_command("NeovimTips", ui.show_fzf, {})

  vim.api.nvim_create_user_command("NeovimTipsEdit", function()
    vim.cmd("edit " .. config.options.user_file)
  end, {})

  vim.api.nvim_create_user_command("NeovimTipsAdd", function()
    local path = config.options.user_file
    local lines = {
      "# Title: ",
      "# Category: ",
      "# Tags: ",
      "---",
      "",  -- description placeholder
      "```vim",
      "",  -- code placeholder
      "```",
      "===",
      ""
    }
    vim.cmd("edit " .. path)
    vim.api.nvim_buf_set_lines(0, -1, -1, false, lines)
    vim.cmd("normal G")
  end, {})
end

return M
