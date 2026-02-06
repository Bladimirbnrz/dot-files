return {
  'saghen/blink.cmp',
  lazy = false,
  -- optional: provides snippets for the snippet source
  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- snippets = { preset = "luasnip"},
    sources = {
      -- default = { "lsp", "path", "snippets", "buffer" },
      default = { "lsp", "buffer" },
    },
    keymap = {
      preset = 'default',
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
        -- ['<Up>'] = { 'snippet_backward' },
        -- ['<Down>'] = { 'snippet_forward' },
    },
    -- (Default) Only show the documentation popup when manually triggered
    completion = {
      menu = {
        border = "single",
        winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection",
      },
      documentation = {
        auto_show = true,
        window = {
          border = "rounded",
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder",
        },
      }
    },
    appearance = {
      nerd_font_variant = "normal",  -- o lo que ya tenías
      kind_icons = {
        Text         = "󱀍 ",
        Method       = " ",
        Function     = "󰊕",
        Variable     = "󰫧 ",
        Field        = " ",
        TypeParameter= " ",
        Constant     = " ",
        Class        = " ",
        Interface    = " ",
        Struct       = " ",
        Event        = "",
        Operator     = "󱓉 ",
        Module       = "󱒌 ",
        Property     = " ",
        Enum         = " ",
        Reference    = " ",
        Keyword      = " ",
        File         = " ",
        Folder       = " ",
        Color        = " ",
        Unit         = " ",
        Constructor  = " ",
        Value        = "󰎠 ",
        EnumMember   = " ",
        Snippet      = " ",
      },
    },
  },
  opts_extend = { "sources.default" },
  config = function(_, opts)
    require("blink-cmp").setup(opts)
  end,
}
