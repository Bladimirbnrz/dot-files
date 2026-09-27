local map = vim.keymap.set

local opts_temp = { noremap = true, silent = true }

local function opts(desc)
  return { silent = true, desc = desc }
end

-- Basics
map("n", "<leader>w", "<cmd>w<CR>", { silent = true, desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>", { silent = true, desc = "Exit" })
map("n", "<leader>Q", "<cmd>q!<CR>", { silent = true, desc = "Forced Exit" })
map("n", "<leader>x", "<cmd>x<CR>", { silent = true, desc = "Save and Exit" })

map("n", "<leader>77", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear highlighted search" })


-- Commenter

local comment = require("vim._comment")

map({ 'n', 'x' }, '<leader>c', function()
  return comment.operator()
end, { expr = true, desc = 'Comment operator' })

map('n', '<leader>cc', function()
  return comment.operator() .. '_'
end, { expr = true, desc = 'Comment toggle current line' })

map('x', '<leader>cc', function()
  return comment.operator()
end, { expr = true, desc = 'Comment toggle (visual)' })


-- Surround
-- For the delete(ds) and change(cs/cS) functions, the keymaps are the default ones
-- For the keymaps below, you can press “keys”+i (i-nsert) and edit the right and left delimiters independently.
-- Read more abut this in https://github.com/kylechui/nvim-surround
map("n", "<leader>as", "<Plug>(nvim-surround-normal)a", { desc = "Surround arround a textobject" })
map("n", "<leader>is", "<Plug>(nvim-surround-normal)iw", { desc = "Inner word surround" })
map("n", "<leader>s", "<Plug>(nvim-surround-normal-cur)", { desc = "Surround the line" })

map("n", "<leader>S", "<Plug>(nvim-surround-normal-cur-line)", { desc = "Surround the line within a block" })

map("v", "<leader>s", "<Plug>(nvim-surround-visual)", { desc = "Surround the selection" })
map("v", "<leader>S", "<Plug>(nvim-surround-visual-line)", { desc = "Surrounds the selections within a block" })


-- Diagnostic
map("n", "<leader>e", vim.diagnostic.setloclist, { desc = "Show list of diagnoses" })

-- Navigation
map("n", "<C-h>", "<C-w>h", opts_temp)
map("n", "<C-j>", "<C-w>j", opts_temp)
map("n", "<C-k>", "<C-w>k", opts_temp)
map("n", "<C-l>", "<C-w>l", opts_temp)


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
