local M = { active_renderer_index = 0 }

--- Supported renderers
M.renderers = {
  { name = "markview", package = "markview",          render = function(bufnr) M.render_markview(bufnr) end },
  { name = "markdown", package = "render-markdown", render = function(bufnr) M.render_markdown(bufnr) end },
}

--- Returns renderer if one is found from the list of supported renderers
function M.select_renderer()
  for index, renderer in ipairs(M.renderers) do
    local ok, _ = pcall(require, renderer.package)
    if ok then
      M.active_renderer_index = index
      -- Select only one
      break
    end
  end
end

--- Retuns active renderer
--- @return table|nil # renderer properties if supported renderer is found
function M.get_active_renderer()
  if M.active_renderer_index > 0 then
    return M.renderers[M.active_renderer_index]
  else
    return nil
  end
end

--- Checks is markdown renderer is renderer_available
--- @return boolean #true if markdown renderer is found, false otherwise
function M.renderer_available()
  return M.active_renderer_index > 0
end

--- Get window options with appropriate conceal settings for the active renderer
--- @param base_options table Base window options to extend
--- @return table win_options Window options with renderer-specific settings
function M.get_win_options(base_options)
  local win_options = vim.deepcopy(base_options or {})
  
  -- Add conceal settings for renderers that need them
  local active_renderer = M.get_active_renderer()
  if active_renderer and active_renderer.name == "markview" then
    win_options.conceallevel = 2
    win_options.concealcursor = "nc"
  end
  
  return win_options
end

---Main entry point: Renders markdown for the given buffer
---@parm bufnr integer Buffer number
function M.render(bufnr)
  local renderer = M.get_active_renderer()
  if renderer then
    renderer.render(bufnr)
  end
end

---Renders markdown in the given buffer using render-markdown plugin
---@param bufnr integer Buffer number
function M.render_markdown(bufnr)
  local markdown = require("render-markdown")
  vim.api.nvim_buf_call(bufnr, function() markdown.enable() end)
end

---Renders markdown in the given buffer using markview plugin
---@param bufnr integer Buffer number
function M.render_markview(bufnr)
  local markview = require("markview")
  markview.render(bufnr, { enable = true, hybrid_mode = false })
end

-- Select markdown renderer, if one is available
M.select_renderer()

return M
