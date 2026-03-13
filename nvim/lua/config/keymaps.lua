local map = vim.keymap.set

local opts = { noremap = true, silent = true }

map("n", "<leader>w", "<cmd>w<CR>", opts)                                      --save
map("n", "<leader>q", "<cmd>q<CR>", opts)                                      --exit
map("n", "<leader>Q", "<cmd>q!<CR>", opts)                                     --forced exit
map("n", "<leader>x", "<cmd>x<CR>", opts)                                      --save and exit

map("n", "<leader>77", "<cmd>nohlsearch<CR>", opts)                            --clear highlighted search

map("n", "<leader>nt", "<cmd>Neotree left toggle filesystem reveal<CR>", opts) --toggle for tree

--Commenter
map("n", "<leader>cc", "<Plug>(comment_toggle_linewise_current)", opts)
map("x", "<leader>cc", "<Plug>(comment_toggle_linewise_visual)", opts)

--Surround
--For the delete(ds) and change(cs/cS) functions, the keymaps are the default ones
--For the keymaps below, you can press “keys”+i (i-nsert) and edit the right and left delimiters independently.
--Read more abut this in https://github.com/kylechui/nvim-surround
map("n", "<leader>as", "<Plug>(nvim-surround-normal)a", opts)        --surround around and object
map("n", "<leader>is", "<Plug>(nvim-surround-normal)iw", opts)       --inner word surround
map("n", "<leader>s", "<Plug>(nvim-surround-normal-cur)", opts)      --surround the line
map("n", "<leader>S", "<Plug>(nvim-surround-normal-cur-line)", opts) --surround the line whitin a block
map("v", "<leader>s", "<Plug>(nvim-surround-visual)", opts)          --surround the selection
map("v", "<leader>S", "<Plug>(nvim-surround-visual-line)", opts)     --surrouns the selection whitin a block


map("n", "<leader>e", vim.diagnostic.setloclist, { desc = "Show list of diagnoses" })

--Navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)


local function OpenOilFloatHere()
  if vim.bo.filetype == "oil" then
    return
  end

  local oil = require("oil")
  local cwd = vim.fn.expand("%:p:h")

  oil.open_float(cwd)
  Try_open_preview(6, 20)
end


local function GlobalOpenOil()
  if vim.bo.filetype == "oil" then
    return
  end

  local oil = require("oil")
  local current_buf = vim.api.nvim_get_current_buf()
  local current_file = vim.api.nvim_buf_get_name(current_buf)

  if current_file and current_file ~= "" then
    local dir = vim.fn.fnamemodify(current_file, ":h")
    oil.open(dir)
  else
    oil.open()
  end
  --try to open preview
  Try_open_preview(6, 30)
end

-- Global keymap to open Oil in current buffer's directory
map("n", "-", GlobalOpenOil, { desc = "Open Oil in current file's directory", silent = true })

-- Global keymap to open Oil in current buffer's directory in float mode
map("n", "<leader>-", OpenOilFloatHere, { desc = "Open Oil in current file'directory in float mode", silent = true })
