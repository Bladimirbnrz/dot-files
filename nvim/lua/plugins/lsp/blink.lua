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
    sources = {
      default = { "lsp", "buffer", "path" },
    },
    keymap = {
      preset = 'none', -- or set to default for default keymaps

      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },

      -- to move through snipppet's placeholders
      ['<C-n>'] = { 'snippet_forward', 'fallback' },
      ['<C-p>'] = { 'snippet_backward', 'fallback' },

      -- accept with CR
      ['<CR>'] = { 'accept', 'fallback' },

      -- accept with shift space (you can enable both of accept-keymap)
      --------> for this, you need to configure .wezterm.lua or similar because shift space is not valid
      -- ['<C-y>'] = { "accept", "fallback" },

      ['<C-space>'] = { 'cancel', 'hide', 'show', 'fallback' }

    },
    completion = {
      list = {
        selection = { auto_insert = false }
      },
      menu = {
        border = "single",
        winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection",
      },

      -- enable ghost_text
      ghost_text = {
        -- enabled = true,
        enabled = function()
          local excluded_sources = {
            snippets = true,
            buffer = true,
          }

          local item = require("blink.cmp").get_selected_item()
          if not item then
            return false
          end

          if excluded_sources[item.source_id] then
            return false
          end

          return true
        end,

        show_without_selection = false,
        -- show_without_menu = false,
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = {
          border = "rounded",
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder",
        },
      }
    },

    appearance = {
      nerd_font_variant = "normal",
      kind_icons = {
        Text          = "󱀍 ",
        Method        = " ",
        Function      = "󰊕",
        Variable      = "󰫧 ",
        Field         = " ",
        TypeParameter = " ",
        Constant      = " ",
        Class         = " ",
        Interface     = " ",
        Struct        = " ",
        Event         = "",
        Operator      = "󱓉 ",
        Module        = "󱒌 ",
        Property      = " ",
        Enum          = " ",
        Reference     = " ",
        Keyword       = " ",
        File          = " ",
        Folder        = " ",
        Color         = " ",
        Unit          = " ",
        Constructor   = " ",
        Value         = "󰎠 ",
        EnumMember    = " ",
        Snippet       = " ",
      },
    },
  },

  opts_extend = { "sources.default" },
  config = function(_, opts)
    require("blink-cmp").setup(opts)
  end,
}
