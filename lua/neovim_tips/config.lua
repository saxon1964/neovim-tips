local M = {}

M.options = {
  user_file = vim.fn.stdpath("config") .. "/neovim_tips/user_tips.txt",
}

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.options, opts or {})
end

return M

