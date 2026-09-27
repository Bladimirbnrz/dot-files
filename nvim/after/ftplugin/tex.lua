local map = vim.keymap.set


-- Basic commands
map('n', '<localleader>c', '<Plug>(vimtex-compile-ss)', { desc = 'Compile', silent = true })
map('n', '<localleader>C', '<Plug>(vimtex-compile)', { desc = 'Compile in Continuous Mode', silent = true })
map('n', '<localleader>v', '<Plug>(vimtex-view)', { desc = 'PDF Viewer', silent = true })
map('n', '<localleader>e', '<Plug>(vimtex-errors)', { desc = 'Errors', silent = true })
map('n', '<localleader>lc', '<Plug>(vimtex-clean)', { desc = 'Clean Aux Files' })


-- Change and delete stuff
map('n', 'dse', '<Plug>(vimtex-env-delete)', { desc = 'Delete Surround Environment' })
map('n', 'cse', '<Plug>(vimtex-env-change)', { desc = 'Change Surround Environment' })

map('n', 'dsc', '<Plug>(vimtex-cmd-delete)', { desc = 'Delete Surround Command' })
map('n', 'csc', '<Plug>(vimtex-cmd-chane)', { desc = 'Change Surround Command' })

map('n', 'dsd', '<Plug>(vimtex-delim-delete)', { desc = 'Delete Surround Delimiter' })
map('n', 'tsd', '<Plug>(vimtex-delim-toggle-modifier)', { desc = 'Toggle Surround Delimiters' })

map('n', 'dsm', '<Plug>(vimtex-env-delete-math)', { desc = 'Delete Surround Math Environment' })
map('n', 'csd', '<Plug>(vimtex-delim-change-math)', { desc = 'Change Surround Math Delimiter' })
map('n', 'tsm', '<Plug>(vimtex-env-toggle-math)', { desc = 'Toggle Surround Math Environment' })


-- Motion maps
map({ 'n', 'o', 'x' }, '%', '<Plug>(vimtex-%)', { desc = 'Move between matching delimiter' })
map({ 'n', 'o', 'x' }, ']]', '<Plug>(vimtex-]])', { desc = 'Jump to the begginng of next (sub)(sub)section' })
map({ 'n', 'o', 'x' }, '[[', '<Plug>(vimtex-[[)', { desc = 'Jump to the begginng of the current (sub)(sub)section' })


-- TeXpresso maps
map('n', '<localleader>lt', '<Plug>(vimtex-toc-open)', { desc = 'Open Table of Contents' })


-- TeXpresso maps
map('n', '<localleader>tx', '<cmd>TeXpresso %<CR>', { desc = 'Open TeXpresso on current file' })
map('n', '<localleader>tc', '<cmd>TeXpressoClose<CR>', { desc = 'Close TeXpresso' })

-- Folding
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "vimtex#fold#level(v:lnum)"


-- Highlighting Overrides

local hl = vim.api.nvim_set_hl

local function hl_from(source, target, overrides)
  local get_hl = vim.api.nvim_get_hl(0, { name = source, link = false })

  for attr, value in pairs(overrides or {}) do
    get_hl[attr] = (value == false) and nil or value
  end
  vim.api.nvim_set_hl(0, target, get_hl --[[@as vim.api.keyset.highlight]])
end


hl(0, "@markup.math.latex", { link = "Special" })
hl(0, "@normal.text", { link = "Normal" })

hl(0, "@module.latex", { link = "Type" })
hl(0, "@label.latex", { link = "PreProc" })


hl(0, "@markup.heading", { link = "PreProc" })
hl(0, "@markup.heading.cmd", { link = "String" })

hl(0, "@function.macro.latex", { link = "Number" })
hl(0, "@markup.is_not_cmd", { link = "Special" })
hl_from("Statement", "@function.latex", { bold = false })


hl(0, "@markup.textformat", { link = "Type" })
hl(0, "@enum.item", { link = "Identifier" })
hl(0, "@markup.arg.cmd", { link = "Number" })


hl(0, "@punctuation.delimiter", { link = "Type" })
hl(0, "@delim.mine.math", { link = "@punctuation.delimiter" })
-- hl(0, "@name.mine.env.math", { link = "@punctuation.brace.delimiter" })
