return {
  "lervag/vimtex",

  ft = { "tex" },
  -- lazy = false,
  init = function()
    vim.gvimtex_syntax_conceal_disable = 1
    vim.g.vimtex_view_forward_search_on_start = 0
    vim.g.vimtex_syntax_enabled = 0
    -- vim.g.vimtex_matchparen_enabled = 0

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

    -- vim.g.vimtex_fold_enabled = 1

    -- Some common errors or warnings you might want to ignore
    vim.g.vimtex_quickfix_ignore_filters = {
      [[Overfull \\vbox]],
      [[Underfull \\hbox]],
      [[Overfull \\hbox]],
      --   [[LaTeX Warning: .\+ float specifier changed to]],
      --   [[LaTeX hooks Warning]],
      --   [[Package siunitx Warning: Detected the "physics" package:]],
      --   [[Package hyperref Warning: Token not allowed in a PDF string]],
    }

    -- ToC config
    vim.g.vimtex_toc_config = {
      name = 'TOC',
      layers = { 'content' },
      show_help = false
    }

    vim.cmd([[
      function! s:Vimtex_usection_entry(context) abort dict
        let l:title = matchstr(a:context.line, self.title_re)
        call a:context.level.set_current(self.base_level)
        return {
          \ 'title'  : l:title,
          \ 'number' : '',
          \ 'file'   : a:context.file,
          \ 'line'   : a:context.lnum,
          \ 'rank'   : a:context.lnum_total,
          \ 'level'  : a:context.max_level - a:context.level.current,
          \ 'type'   : 'content',
          \}
      endfunction
      let g:vimtex_toc_custom_matchers = [
        \ {
        \   'name': 'usection',
        \   're': '^\s*\\usection\*\?{',
        \   'prefilter_cmds': ['usection'],
        \   'title_re': '\\usection\*\?{\zs.\{-}\ze}',
        \   'base_level': 'section',
        \   'get_entry': function('s:Vimtex_usection_entry'),
        \ },
        \ {
        \   'name': 'usubsection',
        \   're': '^\s*\\usubsection\*\?{',
        \   'prefilter_cmds': ['usubsection'],
        \   'title_re': '\\usubsection\*\?{\zs.\{-}\ze}',
        \   'base_level': 'subsection',
        \   'get_entry': function('s:Vimtex_usection_entry'),
        \ },
        \ {
        \   'name': 'usubsubsection',
        \   're': '^\s*\\usubsubsection\*\?{',
        \   'prefilter_cmds': ['usubsubsection'],
        \   'title_re': '\\usubsubsection\*\?{\zs.\{-}\ze}',
        \   'base_level': 'subsubsection',
        \   'get_entry': function('s:Vimtex_usection_entry'),
        \ },
        \]
    ]])
  end,
}
