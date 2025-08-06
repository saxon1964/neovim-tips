local M = {}
local _tips = {}

function M.set(tip_list)
  _tips = tip_list
end

function M.get_all()
  return _tips
end

return M

