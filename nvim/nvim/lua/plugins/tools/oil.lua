-- Oil.nvim: Edit your filesystem like a buffer
-- URL: https://github.com/stevearc/oil.nvim

return {
  "stevearc/oil.nvim",
  -- Load Oil when opening a directory or when using the keymap
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  -- keys = {
    --   { "-", "<CMD>Oil<CR>", desc = "Open Oil (parent dir)" }
    -- },

    config = function()
      vim.o.splitright = true
      require("oil").setup({
        default_file_explores = true,

        columns = {
          "icon",
          -- "size",
        },
        keymaps = {
          ["g?"] = "actions.show_help",
          ["l"] = "actions.select",
          ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open in vertical split" },
          ["<C-v>"] = { "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" },
          ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open in new tab" },
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-r>"] = "actions.refresh",
          ["h"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
          ["g\\"] = "actions.toggle_trash",
          -- Window navigation without conflicts
          ["<C-h>"] = function()
            vim.cmd("wincmd h")
          end,
          ["<C-j>"] = function()
            vim.cmd("wincmd j")
          end,
          ["<C-k>"] = function()
            vim.cmd("wincmd k")
          end,
          ["<C-l>"] = function()
            vim.cmd("wincmd l")
          end,
          -- Quick quit
          ["q"] = "actions.close",
        },

        -- Set to false to disable all of the above keymaps
        use_default_keymaps = true,

        view_options = {
          -- Show files and directories that start with "." by default
          show_hidden = true,
          -- This function defines what is considered a "hidden" file
          is_hidden_file = function(name, bufnr)
            return vim.startswith(name, ".")
          end,
          -- This function defines what will never be shown, even when `show_hidden` is set
          is_always_hidden = function(name, bufnr)
            return name == ".." or name == ".git"
          end,
          natural_order = true,
          case_insensitive = false,
          sort = {
            -- sort order can be "asc" or "desc"
            { "type", "asc" },
            { "name", "asc" },
          },
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
          -- preview_split: Split direction: "auto", "left", "right", "above", "below".
          preview_split = "right",
          -- This is the config that will be passed to nvim_open_win.
          -- Change values here to customize the layout
          override = function(conf)
            return conf
          end,
        },
        preview_win = {
          -- Whether the preview window is automatically updated when the cursor is moved
          update_on_cursor_moved = true,
          -- How to open the preview window "load"|"scratch"|"fast_scratch"
          preview_method = "fast_scratch",
          -- Window-local options to use for preview window buffers
          win_options = {
            winblend = 0,
          },
        },

        -- Configuration for the floating progress window
        progress = {
          max_width = 0.9,
          min_width = { 40, 0.4 },
          width = nil,
          max_height = { 10, 0.9 },
          min_height = { 5, 0.1 },
          height = nil,
          border = "rounded",
          minimized_border = "none",
          win_options = {
            winblend = 0,
          },
        },

        -- Configuration for the floating SSH window
        ssh = {
          border = "rounded",
        },
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

      -- Global keymap to open Oil in current buffer's directory
      vim.keymap.set("n", "<leader>-", function()
        local oil = require("oil")
        local current_buf = vim.api.nvim_get_current_buf()
        local current_file = vim.api.nvim_buf_get_name(current_buf)

        if current_file and current_file ~= "" then
          local dir = vim.fn.fnamemodify(current_file, ":h")
          oil.open(dir)
        else
          oil.open()
        end
      end, { desc = "Open Oil in current file's directory" })
    end
}
