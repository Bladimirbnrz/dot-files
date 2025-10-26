return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
        local lualine = require("lualine")
        lualine.setup({
            theme = {"kanagawa"},
          extensions = { 'neo-tree', 'oil' },
          options = {
    disabled_filetypes = { statusline = {'neo-tree', 'oil'} },
    ignore_focus = { 'neo-tree',  },
    -- globalstatus can be enable for only one stautus line
    globalstatus = true,
  },
            sections = {
                lualine_c = {
                    {
                        "filename",
                        path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path, 3 = ~ for home
                    }
                }
            }
        })
    end,
}
