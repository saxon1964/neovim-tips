---@class NeovimTipsConfig
---@field options NeovimTipsOptions Global configuration options
local M = {}

---@class NeovimTipsOptions
---@field user_file string Path to user's custom tips file
---@field user_tip_prefix string Prefix for user tips to avoid conflicts
---@field warn_on_conflicts boolean Show warnings when user tips conflict with builtin tips
---@field daily_tip integer Daily tip mode: 0=off, 1=once per day, 2=every startup
---@field builtin_dir string Internal: path to builtin tips data directory
---@field user_tips_tag string Internal: tag for user tips identification
---@field github_url string URL to the project repository

---Default configuration options
M.options = {
  user_file = vim.fn.stdpath("config") .. "/neovim_tips/user_tips.md",
  user_tip_prefix = "[User] ",  -- Configurable prefix for user tips
  warn_on_conflicts = true,     -- Show warnings when user tips conflict with builtin
  daily_tip = 1,                -- Daily tip mode: 0=off, 1=once per day, 2=every startup
  -- for internal use only
  builtin_dir = debug.getinfo(1, "S").source:sub(2):gsub("config.lua", "../../data"),
  user_tips_tag = "user",
  github_url = "https://github.com/saxon1964/neovim-tips",
}

---Setup configuration with user overrides
---@param opts NeovimTipsOptions|nil User configuration options to merge
---@return nil
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.options, opts or {})
end

return M

