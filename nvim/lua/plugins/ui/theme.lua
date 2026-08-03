return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      -- transparent = true, -- do not set background color
      dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      overrides = function() -- add/modify highlights
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
          BlinkCmpMenuSelection = { bg = "#545753" },
          BlinkCmpMenuBorder = { fg = "#5E5B82", bg = "none" },
          PmenuThumb = { bg = "#5E5B82" },
        }
      end,
    })
    vim.cmd.colorscheme("kanagawa")
  end
}
