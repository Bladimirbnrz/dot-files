return {
  "lervag/vimtex",
  ft = { "tex" },
  -- lazy = false,
  init = function()
    vim.g.vimtex_view_forward_search_on_start = 0
    -- vim.g.vimtex_syntax_enabled = 0

    vim.g.vimtex_view_method = "general"

    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
      aux_dir = "build",
      -- continuous = 0,
      executable = "latexmk",
    }

    vim.g.vimtex_view_automatic = 0

    -- You need to add SumatraPDF to your windows path.
    -- Steps:
    -- Windows + r and sysdm.cpl, then CR.
    -- See advanced options
    -- Go to “environment variables”
    -- Search for the "PATH" variable
    -- Edit it and add the path where you installed Sumatra
    -- Also, see :help vimtex-faq-sumatrapdf-wsl

    -- vim.g.vimtex_view_general_viewer = 'SumatraPDF.exe' --- if you didn't copy the script
    vim.g.vimtex_view_general_viewer = vim.fn.expand("~/.local/bin/sumatrapdf.sh")
    vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'

    -- vim.g.vimtex_view_general_viewer = 'okular'
    -- vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'

    vim.g.vimtex_mappings_enabled = 0 -- Go to .../after/ftplugin/tex.lua to see the custom keymaps
    vim.g.vimtex_imaps_enabled = 0    -- Disable insert keymaps


    vim.g.vimtex_fold_enabled = 1

    -- vim.g.vimtex_quickfix_ignore_filters = {
    --   [[Overfull \\vbox]],
    --   [[Underfull \\hbox]],
    --   [[Overfull \\hbox]],
    --   [[LaTeX Warning: .\+ float specifier changed to]],
    --   [[LaTeX hooks Warning]],
    --   [[Package siunitx Warning: Detected the "physics" package:]],
    --   [[Package hyperref Warning: Token not allowed in a PDF string]],
    -- }
  end,
}
