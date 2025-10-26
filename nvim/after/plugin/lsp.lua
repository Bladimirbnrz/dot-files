vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
  callback = function(event)
    local buf = event.buf
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = buf, desc = "LSP: " .. desc })
    end

    map("gd", vim.lsp.buf.definition, "Go to Definition")
    map("gr", vim.lsp.buf.references, "Go to References")
    map("K", function() vim.lsp.buf.hover({ border = "rounded" }) end, "Hover")
    -- Add more maps as you like

    -- Resaltar referencias
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client.server_capabilities.documentHighlightProvider then
      local hl = vim.api.nvim_create_augroup("user-lsp-highlight", {})
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = buf, group = hl, callback = vim.lsp.buf.document_highlight
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = buf, group = hl, callback = vim.lsp.buf.clear_references
      })
    end
  end,
})

local caps = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("*", {
  capabilities = caps
})

vim.lsp.enable("lua_ls")
vim.lsp.enable('pyright')
