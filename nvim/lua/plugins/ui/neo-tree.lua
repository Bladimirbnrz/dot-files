return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false,
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      auto_expand_width = false,
      popup_border_style = "", -- or "" to use 'winborder' on Neovim v0.11+
      enable_git_status = true,
      enable_diagnostics = true,
      mappings = {
        ["<CR>"] = "open",
        ["<BS>"] = "navigate_up",
      },
      default_component_configs = {
        indent = {
          indent_size = 2,
          padding = 0,
          with_markers = true,
        },
      },
      filesystem = {
        hijack_netrw_behavior = "disabled",
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
      },
      window = {
        position = "left",
        width = 25,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            require("neo-tree.command").execute({ action = "close" })
          end
        },
      },
    })
  end
}
