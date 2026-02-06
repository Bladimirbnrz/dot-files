----------------------------
---Diagnostics config-------
----------------------------

vim.diagnostic.config({
  virtual_text = {
    spacing = 2,
    prefix = "",
    format = function(diagnostic)
      local icons = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN]  = "",
        [vim.diagnostic.severity.INFO]  = "",
        [vim.diagnostic.severity.HINT]  = "",
      }
      return icons[diagnostic.severity] or "·"
    end,
  },

  signs = false,

  underline = {
    severity = { min = vim.diagnostic.severity.WARN },
  },

  update_in_insert = false,

  severity_sort = true,

  float = {
    border = "rounded",
    source = "if_many",
  },
})

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})
