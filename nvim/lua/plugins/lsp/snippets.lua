return {
  "L3MON4D3/LuaSnip",
  dependies = {"rafamadriz/friendly-snippets"},
  version = 'v2.*',
  build = "make install_jsregexp",
  config = function ()
    require("luasnip.loaders.from_lua").lazy_load({
      paths = {
        "~/.config/nvim/snippets/"
      }
    })
  end
}
