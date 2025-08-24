local M = {}

M.options = {
  user_file = vim.fn.stdpath("config") .. "/neovim_tips/user_tips.md",
  user_tip_prefix = "[User] ",  -- Configurable prefix for user tips
  warn_on_conflicts = true,     -- Show warnings when user tips conflict with builtin
  picker = "fzf-lua",           -- Options: "fzf-lua", "nui" 
  -- for internal use only
  builtin_dir = debug.getinfo(1, "S").source:sub(2):gsub("config.lua", "../../data"),
  user_tips_tag = "user",
}

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.options, opts or {})
end

return M

