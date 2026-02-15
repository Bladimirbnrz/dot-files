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
