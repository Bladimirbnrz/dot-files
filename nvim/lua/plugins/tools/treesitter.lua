return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  event = { "VeryLazy" },
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = { "python", "lua", "vim", "vimdoc", "query" }, -- Parsers to install
    sync_install = false,
    -- auto_install = true,
    install_info = {
      prefer_git = true,
    },
    highlight = {
      enable = true,
    },
    indent = {
      enable = false, -- indent disabled
    },
  },
}
