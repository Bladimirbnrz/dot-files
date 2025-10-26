return {
    "numToStr/Comment.nvim",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    event = "VeryLazy",
    config = function()
        require("Comment").setup({
            mappings = {
                basic = false,
                extra = false,
            },
            -- If you later want context-aware commentstring (for embedded languages),
            -- uncomment the pre_hook line below (requires ts_context_commentstring).
            -- pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        })
    end,
}
