return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kanagawa").setup({
    --       compile = false, -- enable compiling the colorscheme
    --       undercurl = true, -- enable undercurls
    --       commentStyle = { italic = true },
    --       functionStyle = {},
    --       keywordStyle = { italic = true },
    --       statementStyle = { bold = true },
    --       typeStyle = {},
      -- transparent = true, -- do not set background color
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
    --       colors = { -- add/modify theme and palette colors
    --         palette = {},
    --         theme = {
    --           wave = {},
    --           lotus = {},
    --           dragon = {},
    --           all = {
    --             ui = {
    --               bg_gutter = "none", -- set bg color for normal background
    --               bg_sidebar = "none", -- set bg color for sidebar like nvim-tree
    --               bg_float = "none", -- set bg color for floating windows
    --             },
    --           },
    --         },
    --       },
      overrides = function(colors) -- add/modify highlights
        return {
          LineNr = { bg = "none" },
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },
          TelescopeNormal = { bg = "none" },
          TelescopeBorder = { bg = "none" },
          LspInfoBorder = { bg = "none" },
          NeoTreePreviewNormal = { bg = "none" },
          StatusLine = { bg = "none" },
          StatusLineNC = { bg = "none" },
          BlinkCmpMenuSelection = { bg = "#545753"},
          BlinkCmpMenuBorder = { fg = "#5E5B82", bg = "none"},
          PmenuThumb = { bg = "#5E5B82"},
        }
      end,
    --       theme = "wave", -- Load "wave" theme
    --       background = { -- map the value of 'background' option to a theme
    --         dark = "wave", -- try "dragon" !
    --         light = "lotus",
    --       },
    })
    vim.cmd.colorscheme("kanagawa-dragon")
  end
}

