---@class NeovimTipsPicker
---Main picker interface - delegates to the modular picker implementation
local M = {}

-- Forward to the new modular picker init
local picker_init = require("neovim_tips.tips_picker.init")

-- Export the same interface
M.new = picker_init.new
M.show = picker_init.show

return M