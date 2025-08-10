local M = {}

local config = require("neovim_tips.config")
local loader = require("neovim_tips.loader")
local ui = require("neovim_tips.ui")
local utils = require("neovim_tips.utils")

function M.setup(opts)
  -- Merge configurations
  config.setup(opts)

  -- Create file for user tips if it doesn't exist
  local user_file = config.options.user_file
  utils.create_file_and_dirs(user_file, "# Your personal Neovim tips\n\n")

  -- Load tips
  loader.load()

  -- Create commands
  vim.api.nvim_create_user_command("NeovimTips", ui.show_fzf, {})

  vim.api.nvim_create_user_command("NeovimTipsEdit", function()
    vim.cmd("edit " .. user_file)
  end, {})

  vim.api.nvim_create_user_command("NeovimTipsAdd", function()
    local lines = {
      "# Title: ",
      "# Category: ",
      "# Tags: ",
      "---",
      "", -- description placeholder
      "", -- description placeholder
      "```vim",
      "", -- code placeholder
      "```",
      "===",
      ""
    }
    vim.cmd("edit " .. user_file)
    vim.api.nvim_buf_set_lines(0, -1, -1, false, lines)
    vim.cmd("normal G")
  end, {})

  -- Reload tips on user file save
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = user_file,
    callback = function(_)
      loader.load()
    end,
  })

end

return M

