local M = {}

M.options = {
  builtin_file = debug.getinfo(1, "S").source:sub(2):gsub("config.lua", "../../data/builtin_tips.md"),
  user_file = vim.fn.stdpath("config") .. "/neovim_tips/user_tips.md",
  md_preview_cmd = "CLICOLOR_FORCE=1 COLORTERM=truecolor glow %s",
  tmp_file = vim.fn.expand("~/neovim_tips_tmp.md")
}

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.options, opts or {})
end

return M

