local M = {}
local config = require("neovim_tips.config")
local loader = require("neovim_tips.loader")
local ui = require("neovim_tips.ui")

local tmp_file = config.options.tmp_file
local user_file = config.options.user_file

function M.setup(opts)
  config.setup(opts)
  loader.load()

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

  vim.api.nvim_create_autocmd("VimLeave", {
    callback = function()
      local fd = io.open(tmp_file, "r")
      if fd then
        fd:close()
        os.remove(tmp_file)
      end
    end,
  })

  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = user_file,
    callback = function(_)
      loader.load()
    end,
  })

end

return M
