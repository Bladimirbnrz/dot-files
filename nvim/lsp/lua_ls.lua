return {
  cmd = { 'lua-language-server' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  filetypes = { 'lua' },
  settings = {
    Lua = {
      diagnostics = { 
        globals = { "vim" }, 
        disable = {"missing-fields"},
      },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
    },
  },
}
