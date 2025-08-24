local M = {}

local config = require("neovim_tips.config")
local loader = require("neovim_tips.loader")
local fzf_lua_picker = require("neovim_tips.fzf_lua")
local nui_picker = require("neovim_tips.picker_nui")
local utils = require("neovim_tips.utils")

function M.setup(opts)
  -- Merge configurations
  config.setup(opts)

  -- Create file for user tips if it doesn't exist
  local user_file = config.options.user_file
  utils.create_file_and_dirs(user_file, "# Your personal Neovim tips\n\n")

  -- Create commands
  vim.api.nvim_create_user_command("NeovimTipsLoad",
    function()
      utils.run_async(loader.load,
        function(ok, result)
          if ok then
            if result then
              vim.notify("Neovim tips loaded silently", vim.log.levels.INFO)
            end
          else
            vim.notify("Failed to load Neovim tips: " .. result, vim.log.levels.ERROR)
          end
        end
      )
    end,
    { desc = "Load Neovim tips silently without showing picker" }
  )

  vim.api.nvim_create_user_command("NeovimTips",
    function()
      utils.run_async(loader.load,
        function(ok, result)
          if ok then
            if result then
              vim.notify("Neovim tips loaded", vim.log.levels.INFO)
            end
            
            -- Choose picker based on configuration
            if config.options.picker == "nui" then
              nui_picker.show()
            else
              fzf_lua_picker.show_fzf()
            end
          else
            vim.notify("Failed to load Neovim tips: " .. result, vim.log.levels.ERROR)
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
        "", -- code placeholder
        "```",
        "===",
        ""
      }
      vim.cmd("edit " .. user_file)
      vim.api.nvim_buf_set_lines(0, -1, -1, false, lines)
      vim.cmd("normal G")
    end,
    { desc = "Add new tip to the file with custom tips" }
  )

  vim.api.nvim_create_user_command("NeovimTipsHelp",
    function()
      local plugin_path = debug.getinfo(1, "S").source:sub(2):gsub("init.lua", "../../README.md")
      if vim.fn.filereadable(plugin_path) == 1 then
        vim.cmd("split " .. plugin_path)
        vim.cmd("setlocal readonly")
        vim.cmd("setlocal nomodifiable")
        vim.cmd("setlocal filetype=markdown")
      else
        vim.notify("README not found: " .. plugin_path, vim.log.levels.ERROR)
      end
    end,
    { desc = "Open Neovim tips README file" }
  )

  -- Test command for nui picker
  vim.api.nvim_create_user_command("NeovimTipsNui",
    function()
      utils.run_async(loader.load,
        function(ok, result)
          if ok then
            if result then
              vim.notify("Tips loaded - using nui picker", vim.log.levels.INFO)
            end
            nui_picker.show()
          else
            vim.notify("Failed to load tips: " .. result, vim.log.levels.ERROR)
          end
        end
      )
    end,
    { desc = "Open Neovim tips with nui picker" }
  )

  -- Reload tips on user file save
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = user_file,
    callback = function()
      utils.run_async(loader.reload,
        function(ok, result)
          if ok and result then
            vim.notify("Neovim tips reloaded", vim.log.levels.INFO)
          else
            vim.notify("Failed to reload Neovim tips: " .. result, vim.log.levels.ERROR)
          end
        end
      )
    end
  })
end

return M

