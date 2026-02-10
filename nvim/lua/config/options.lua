local o = vim.opt
local g = vim.g

o.number = true
o.relativenumber = true
o.showmode = false
-- o.termguicolors = true
-- vim.cmd.colorscheme("kanagawa-dragon")

o.incsearch = true
o.ignorecase = true
o.smartcase = true

o.shiftwidth = 2
o.softtabstop = 2
o.tabstop = 2
o.expandtab = true
o.smartindent = true

g.mapleader = " "

vim.o.title = true

vim.api.nvim_create_augroup("TitleUpdate", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost" }, {
  group = "TitleUpdate",
  callback = function()
    vim.o.titlestring = vim.fn.expand("%:t")
  end,
})

-- local function update_wezterm_title()
--   local file = vim.fn.expand("%:t")
--   if file == "" then file = "nvim" end
--   -- Enviamos una secuencia de escape que WezTerm entiende
--   io.write(string.format("\027]1337;SetUserVar=%s=%s\007", "IS_NVIM", "true"))
--   io.write(string.format("\027]1337;SetUserVar=%s=%s\007", "BUFFER_NAME", b64(file)))
-- end
--
-- -- Función auxiliar para codificar en Base64 (requerido por el protocolo)
-- function b64(data)
--   return ((wezterm_b64 or require("mime").b64)(data))
-- end
--
-- -- Si no tienes una librería de b64 a mano, usa esta versión simple:
-- function b64(data)
--   local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
--   return ((data:gsub('.', function(x)
--     local r, b = '', x:byte()
--     for i = 8, 1, -1 do r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and '1' or '0') end
--     return r;
--   end) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
--     if (#x < 6) then return '' end
--     local c = 0
--     for i = 1, 6 do c = c + (x:sub(i, i) == '1' and 2 ^ (6 - i) or 0) end
--     return b:sub(c + 1, c + 1)
--   end) .. ({ '', '==', '=' })[#data % 3 + 1])
-- end
--
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "DirChanged" }, {
--   callback = update_wezterm_title
-- })











local four_space_filetypes = {
  "python", "c", "cpp", "rust", "go", "java", "fortran"
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = four_space_filetypes,
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "make" },
  callback = function()
    vim.opt_local.expandtab = false -- tabs reales
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end
})



o.encoding = "utf-8"
o.clipboard:append('unnamedplus')

-- if you use nvim on WSL
if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = 'win32yank-wsl',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = 0,
  }
end
-- if vim.fn.has('wsl') == 1 then
--   vim.g.clipboard = {
--     name = "win32yank",
--     copy = {
--       ["+"] = "/usr/local/bin/win32yank.exe -i --crlf",
--       ["*"] = "/usr/local/bin/win32yank.exe -i --crlf",
--     },
--     paste = {
--       ["+"] = "/usr/local/bin/win32yank.exe -o --lf",
--       ["*"] = "/usr/local/bin/win32yank.exe -o --lf",
--     },
--   }
-- end
return {
  opts = o,
  g = g,
}
