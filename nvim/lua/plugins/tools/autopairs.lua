return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup({
            check_ts = true, -- enable treesitter integration (better pairing in complex syntaxes)
            disable_filetype = { "TelescopePrompt", "vim", "help" }, -- disable in these filetypes
            map_cr = true,  -- map <CR> to confirm pairs (Enter behavior)
            map_bs = true,  -- map Backspace to delete pairs
        })
    end,
}

