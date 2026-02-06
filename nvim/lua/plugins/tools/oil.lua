-- Oil.nvim: Edit your filesystem like a buffer
-- URL: https://github.com/stevearc/oil.nvim

return {
  "stevearc/oil.nvim",
  -- Load Oil when opening a directory or when using the keymap
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    vim.o.splitright = true

    require("oil").setup({
      default_file_explorer = true,

      keymaps = {
        ["°"] = { "actions.select", opts = { horizontal = true }, desc = "Open in vertical split" },
        ["|"] = { "actions.select", opts = { vertical = true }, desc = "Open in horizontal split" },

        -- Quick quit
        ["q"] = "actions.close",

        --to see the more default keymaps, "g?" when you're in Oil
      },

      view_options = {
        -- Show files and directories that start with "." by default
        show_hidden = true,
        -- This function defines what is considered a "hidden" file
        is_hidden_file = function(name)
          return vim.startswith(name, ".")
        end,
        -- This function defines what will never be shown, even when `show_hidden` is set
        -- is_always_hidden = function(name, bufnr)
        is_always_hidden = function(name)
          return name == ".." or name == ".git"
        end,

      },
      float = {
        -- Padding around the floating window
        padding = 2,
        max_width =125,
        max_height = 30,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        preview_split = "right",
      },
      confirmation = {
        width = 0.3,
        border = "single",
      },
      -- to see the more defaults, go to the URL
    })
    -- Custom autocmds for Oil
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "oil",
      callback = function()
        -- Set local options for oil buffers
        vim.opt_local.colorcolumn = ""
        vim.opt_local.signcolumn = "no"

        -- Auto-save when leaving oil buffer with changes
        local oil_leave_group = vim.api.nvim_create_augroup("OilAutoSave", { clear = true })
        vim.api.nvim_create_autocmd("BufLeave", {
          group = oil_leave_group,
          buffer = 0,
          callback = function()
            if vim.bo.modified then
              vim.cmd("silent! write")
            end
          end,
        })
      end,
    })
  end
}
