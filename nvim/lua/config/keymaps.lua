local map = vim.keymap.set

local opts = { noremap = true, silent = true }

map("n", "<leader>w", "<cmd>w<CR>", opts)               --save
map("n", "<leader>q", "<cmd>q<CR>", opts)               --exit
map("n", "<leader>Q", "<cmd>q!<CR>", opts)              --forced exit
map("n", ",", "$xx", opts)

map("n", "<leader>77", "<cmd>nohlsearch<CR>", opts)     --clear highlighted search

map("n", "<leader>nt", "<cmd>Neotree left toggle filesystem reveal<CR>", opts) --toggle for tree

--Commenter
map("n", "<leader>cc", "<Plug>(comment_toggle_linewise_current)", opts)
map("x", "<leader>cc", "<Plug>(comment_toggle_linewise_visual)", opts)

--Surround
--For delete and change functions, the keymaps are the default ones
--Read more abut this in https://github.com/kylechui/nvim-surround
map("n", "<leader>as", "<Plug>(nvim-surround-normal)a", opts)        --surround around
map("n", "<leader>is", "<Plug>(nvim-surround-normal)iw", opts)       --inner word surround
map("n", "<leader>s", "<Plug>(nvim-surround-normal-cur)", opts)      --surround the line
map("n", "<leader>S", "<Plug>(nvim-surround-normal-cur-line)", opts) --surround the line whitin a block
map("v", "<leader>s", "<Plug>(nvim-surround-visual)", opts)          --surround the selection
map("v", "<leader>S", "<Plug>(nvim-surround-visual-line)", opts)    --surrouns the selection whitin a block

map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Mostrar diagnóstico flotante" })
-- map("n", "<leader>e", vim.diagnostic.setloclist, { desc = "Mostrar lista de diagnóstico" })

--Navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

function OpenOilFloatHere()
  if vim.bo.filetype == "oil" then
    return
  end

  local oil = require("oil")
  local cwd = vim.fn.expand("%:p:h")

  oil.open_float(cwd)
  vim.defer_fn(function()
    local seq = vim.api.nvim_replace_termcodes("<C-p>", true, false, true)
    vim.api.nvim_feedkeys(seq, 'm', false)
  end, 100)
end

map("n", "-", OpenOilFloatHere, { desc = "Abrir Oil flotante en carpeta actual" })
