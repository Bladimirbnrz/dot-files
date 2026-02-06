local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    print("Wait... Installing lazy.nvim...")
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

------------------------------------
------------------------------------

require("lazy").setup({
    --{ import = "plugins.core" },
    { import = "plugins.ui" },
    { import = "plugins.tools" },
    { import = "plugins.lsp" },
    ui = { border = "single" },
})

