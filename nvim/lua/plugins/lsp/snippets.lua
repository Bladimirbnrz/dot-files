return {
  -- { "rafamadriz/friendly-snippets" },
  {
    "L3MON4D3/LuaSnip",
    -- You can load the snippets from friendly-snippets:
    -- (friendly-snippets is only a data repository)
    -- dependencies = { "rafamadriz/friendly-snippets" },
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({
        -- Or you can load the snippets from your own paths
        paths = { "./snippets" }
      })
      require('luasnip').config.set_config({
        update_events = "TextChanged,TextChangedI",
      })
    end
  }
}
