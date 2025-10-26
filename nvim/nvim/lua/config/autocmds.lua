local aug = vim.api.nvim_create_augroup("StartupCommands", { clear = true })
--
-- local function open_oil()
--   local ok, oil = pcall(require, "oil")
--   if ok and oil then
--     oil.open()
--     return
--   end
--
--   -- Lógica de reintento si Oil no se carga inmediatamente
--   local attempts = 0
--   local function try()
--     attempts = attempts + 1
--     local ok2, oil2 = pcall(require, "oil")
--     if ok2 and oil2 then
--       oil2.open()
--       return
--     end
--     if attempts < 10 then
--       vim.defer_fn(try, 100)
--     else
--       vim.notify("No se pudo cargar Oil.nvim al inicio", vim.log.levels.WARN)
--     end
--   end
--   vim.defer_fn(try, 100)
-- end
--
vim.api.nvim_create_autocmd("VimEnter", {
  -- pattern = "*",
  group = aug,
  callback = function()
    local arg = vim.fn.argv(0)
    -- if vim.fn.argc() == 0 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
    if arg ~= " " and vim.fn.isdirectory(arg) == 1 then
    -- open_oil()
      vim.cmd("Oil")
      vim.defer_fn(function()
        local seq = vim.api.nvim_replace_termcodes("<C-P>", true, false, true)
        vim.api.nvim_feedkeys(seq, 'm', false)
      end, 1000)
    end
  end,
})
