---@class NeovimTipsConfig
---@field options NeovimTipsOptions Global configuration options
local M = {}

local github_root = "https://github.com/saxon1964/neovim-tips"
local guthub_issues = github_root .. "/issues/new"

---@class NeovimTipsOptions
---@field user_file string Path to user's custom tips file
---@field user_tip_prefix string Prefix for user tips to avoid conflicts
---@field warn_on_conflicts boolean Show warnings when user tips conflict with builtin tips
---@field daily_tip integer Daily tip mode: 0=off, 1=once per day, 2=every startup
---@field bookmark_symbol string Symbol to display for bookmarked tips
---@field use_cache boolean Enable caching of parsed tips for faster loading
---@field builtin_dir string Internal: path to builtin tips data directory
---@field user_tips_tag string Internal: tag for user tips identification
---@field github table Internal: various github urls
---@field messages table Internal: various messages
---Default configuration options
M.options = {
  user_file = vim.fn.stdpath("config") .. "/neovim_tips/user_tips.md",
  user_tip_prefix = "[User] ",  -- Configurable prefix for user tips
  warn_on_conflicts = true,     -- Show warnings when user tips conflict with builtin
  daily_tip = 1,                -- Daily tip mode: 0=off, 1=once per day, 2=every startup
  bookmark_symbol = "🌟 ",       -- Bookmark symbol (colorful Unicode symbols work great!)
  use_cache = true,             -- Enable caching for faster loading (recommended)
  ---------------------------------------------------
  --             for internal use only             --
  ---------------------------------------------------
  builtin_dir = debug.getinfo(1, "S").source:sub(2):gsub("config.lua", "../../data"),
  user_tips_tag = "user",
  github = {
    home = github_root,
    issues = guthub_issues,
  },
  messages = {
    picker = {
      footer = "**Examples:** `motion c:edit t:operator`, `b:` (bookmarks), `b:delete` | **Bookmark:** `Ctrl+b` | **Help:** `t:?` `c:?` | [**Issues**](" .. guthub_issues .. ") 🚀",
    },
    daily_tip = {
      footer1 = "**Bookmark:** `Ctrl+b` | Having a **favorite tip**? Found an **error**? Just Shift+Click on the [**Issues**](" .. guthub_issues .. ") link. 🚀",
      footer2 = "For daily tip setup refer to [**README**](" .. github_root .. ") file.",
    }
  },
}

---Setup configuration with user overrides
---@param opts NeovimTipsOptions|nil User configuration options to merge
---@return nil
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.options, opts or {})
end

return M

