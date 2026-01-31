return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = { "python", "lua" }, -- Parsers to install
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false, -- Disable legacy regex highlighters
            },
            indent = {
                enable = false, -- indent disabled
            },
        }
    end,
}

