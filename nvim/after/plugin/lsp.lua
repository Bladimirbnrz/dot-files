local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("*", {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
})

-- to avoid conflicts between pyright and ruff
vim.lsp.config("pyright", {
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
  end,
})

local group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(event)
    local buf = event.buf

    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc })
    end
    -- Navigation
    map("gd", vim.lsp.buf.definition, "LSP: Go to definition")
    map("gr", vim.lsp.buf.references, "LSP: List references")

    -- Info
    map("K", vim.lsp.buf.hover, "LSP: Hover documentation")

    -- Refactor
    map("<leader>rn", vim.lsp.buf.rename, "LSP: Rename symbol")
    map("<leader>ca", vim.lsp.buf.code_action, "LSP: Code actions")

    --Formater
    map("<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, "Format buffer")
  end,
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    vim.lsp.buf.format({ bufnr = args.buf })
  end,
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("ruff")
