local M = {}

M.options = {
  builtin_dir = debug.getinfo(1, "S").source:sub(2):gsub("config.lua", "../../data"),
  user_file = vim.fn.stdpath("config") .. "/neovim_tips/user_tips.md",
}

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.options, opts or {})
end

return M

