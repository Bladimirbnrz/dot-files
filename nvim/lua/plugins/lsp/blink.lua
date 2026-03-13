return {
  'saghen/blink.cmp',
  lazy = false,
  -- optional: provides snippets for the snippet source
  -- use a release tag to download pre-built binaries
  version = '1.*',

  dependencies = {
    { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    -- {
    --   "micangl/cmp-vimtex",
    --   dependencies = {
    --     {
    --       "saghen/blink.compat",
    --       version = "*",
    --       lazy = true,
    --       opts = {},
    --     },
    --   },
    -- }
  },

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "buffer", "path", "snippets" },

      providers = {
        -- to add Vimtex as an autocomplete source see
        -- https://github.com/micangl/cmp-vimtex/issues/30#issuecomment-3084686827
        -- vimtex = {
        --   name = "vimtex",
        --   min_keyword_length = 2,
        --   module = "blink.compat.source",
        --   score_offset = 80,
        -- },
        snippets = {
          min_keyword_length = 2,
          score_offset = 30
        },
        lsp = {
          transform_items = function(_, items)
            local ft = vim.bo.filetype
            local kinds = require("blink.cmp.types").CompletionItemKind

            -- FORTRAN
            if ft == "fortran" then
              local allowed = {
                [kinds.Variable] = true,
                [kinds.Field] = true,
              }

              local filtered = {}

              for _, item in ipairs(items) do
                if allowed[item.kind] then
                  filtered[#filtered + 1] = item
                end
              end

              return filtered
            end

            -- LaTeX
            if ft == "tex" then
              for _, item in ipairs(items) do
                -- Change the completion type and avoid automatic brackets “{...}” in \commands
                if item.kind == kinds.Function then
                  item.kind = kinds.Keyword
                end
              end
              return items
            end

            -- Other languages
            return items
          end,
          score_offset = 35
        },

        buffer = {
          min_keyword_length = 3,
          score_offset = 20
        }
      }
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
        auto_show_delay_ms = 150,
        border = "single",
        winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection",
      },

      -- enable ghost_text
      ghost_text = {
        enabled = function() -- disable ghost_text in buffer completion
          local excluded_sources = {
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
        -- Keyword       = " ",
        Keyword       = "󰘎 ",
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
