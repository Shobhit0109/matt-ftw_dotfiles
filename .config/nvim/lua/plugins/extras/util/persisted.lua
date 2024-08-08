local group = vim.api.nvim_create_augroup("PersistedHooks", {})

vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "PersistedTelescopeLoadPre",
  group = group,
  callback = function(session)
    -- Save the currently loaded session using a global variable
    require("persisted").save({ session = vim.g.persisted_loaded_session })

    -- Delete all of the open buffers
    vim.api.nvim_input("<ESC>:%bd!<CR>")
  end,
})

return {
  {
    "folke/persistence.nvim",
    enabled = false,
  },
  {
    "olimorris/persisted.nvim",
    lazy = false,
    config = function()
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").setup({
          extensions = {
            persisted = {
              layout_config = {
                height = 0.6,
                width = 0.6,
              },
            },
          },
        })
        require("telescope").load_extension("persisted")
      end)
      require("persisted").setup({
        use_git_branch = true,
        autoload = false,
        should_autosave = function()
          if vim.bo.filetype == "dashboard" then
            return false
          end
          return true
        end,
      })
    end,
    keys = {
      {
        "<leader>ql",
        function()
          require("persisted").load()
        end,
        desc = "Load Session",
      },
      {
        "<leader>qL",
        function()
          require("persisted").load({ last = true })
        end,
        desc = "Load Last Session",
      },
      {
        "<leader>qS",
        function()
          require("persisted").stop()
        end,
        desc = "Stop Current Session",
      },
      {
        "<leader>qs",
        function()
          require("persisted").save()
        end,
        desc = "Save Current Session (Telescope)",
      },
      {
        "<leader>qT",
        function()
          require("persisted").start()
        end,
        desc = "Start Recording Current Session",
      },
      {
        "<leader>qt",
        "<cmd>Telescope persisted<cr>",
        desc = "Search Sessions (Telescope)",
      },
    },
  },
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      -- Remove the older session plugin entry
      for i, section in ipairs(opts.config.center) do
        if section.key == "s" then
          table.remove(opts.config.center, i)
          break
        end
      end

      local session = {
        action = 'lua require("persisted").load()',
        desc = " Restore Session",
        icon = " ",
        key = "s",
      }

      session.desc = session.desc .. string.rep(" ", 43 - #session.desc)
      session.key_format = "  %s"

      table.insert(opts.config.center, 9, session)
    end,
  },
}