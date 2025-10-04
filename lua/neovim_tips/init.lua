---@class NeovimTipsInit
---Main plugin initialization and command setup
local M = {}

local config = require("neovim_tips.config")
local loader = require("neovim_tips.loader")
local picker = require("neovim_tips.picker")
local utils = require("neovim_tips.utils")
local daily_tip = require("neovim_tips.daily_tip")

---Setup the Neovim tips plugin
---Configures options, creates user commands, and sets up autocmds for tips management
---@param opts NeovimTipsOptions|nil User configuration options
---@return nil
function M.setup(opts)
  -- Merge configurations
  config.setup(opts)

  -- Create file for user tips if it doesn't exist
  local user_file = config.options.user_file
  utils.create_file_and_dirs(user_file, "# Your personal Neovim tips\n\n")

  -- Create commands
  vim.api.nvim_create_user_command("NeovimTips",
    function()
      -- Close any plugin windows first to prevent layering issues
      utils.close_plugin_windows()

      utils.run_async(loader.load,
        function(ok, result)
          if ok then
            if result then
              utils.info("Neovim tips loaded")
            end
            -- Show picker
            picker.show()
          else
            utils.error("Failed to load Neovim tips: " .. result)
          end
        end
      )
    end,
    { desc = "Open Neovim tips" }
  )

  vim.api.nvim_create_user_command("NeovimTipsEdit",
    function()
      vim.cmd("edit " .. user_file)
    end,
    { desc = "Edit file with custom Neovim tips" }
  )

  vim.api.nvim_create_user_command("NeovimTipsAdd",
    function()
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
        "",
        "***",
      }
      vim.cmd("edit " .. user_file)
      vim.api.nvim_buf_set_lines(0, -1, -1, false, lines)
      local moveToTitle = string.format("G%dk$i ", #lines - 1)
      vim.api.nvim_feedkeys(moveToTitle, 'n', false)
    end,
    { desc = "Add new tip to the file with custom tips" }
  )

  vim.api.nvim_create_user_command("NeovimTipsRandom",
    function()
      daily_tip.show()
    end,
    { desc = "Open random tip" }
  )

  vim.api.nvim_create_user_command("NeovimTipsPdf",
    function()
      local pdf_path = vim.fn.fnamemodify(debug.getinfo(1).source:sub(2), ":h:h:h") .. "/pdf/book/NeovimTips.pdf"

      -- Check if PDF exists
      if vim.fn.filereadable(pdf_path) == 0 then
        utils.error("PDF not found at: " .. pdf_path)
        return
      end

      -- Detect OS and use appropriate command
      local open_cmd
      if vim.fn.has("mac") == 1 then
        open_cmd = "open"
      elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
        open_cmd = "start"
      else
        -- Linux/Unix - try xdg-open first, fallback to others
        if vim.fn.executable("xdg-open") == 1 then
          open_cmd = "xdg-open"
        elseif vim.fn.executable("gnome-open") == 1 then
          open_cmd = "gnome-open"
        elseif vim.fn.executable("kde-open") == 1 then
          open_cmd = "kde-open"
        else
          utils.error("No suitable PDF viewer command found")
          return
        end
      end

      -- Open PDF
      local cmd = string.format('%s "%s"', open_cmd, pdf_path)
      vim.fn.system(cmd)
      utils.info("Opening PDF: " .. pdf_path)
    end,
    { desc = "Open Neovim Tips PDF book" }
  )

  -- Reload tips on user file save
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = user_file,
    callback = function()
      utils.run_async(loader.reload,
        function(ok, result)
          if ok and result then
            utils.info("Neovim tips reloaded")
          else
            utils.error("Failed to reload Neovim tips: " .. result)
          end
        end
      )
    end
  })

  -- Set up daily tip on VimEnter
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      -- Load tips first, then check for daily tip
      utils.run_async(loader.load, function(ok, _)
        if ok then
          daily_tip.check_and_show()
        end
      end)
    end,
    once = true -- Only run once per session
  })
end

return M
