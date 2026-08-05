--========= Refresh title  =========--

vim.api.nvim_create_user_command('TeXpressoClose', function()
  require('texpresso').stop()
  vim.o.titlestring = ' '
  vim.cmd('redraw')
  vim.o.titlestring = '%t'
  vim.cmd('redraw')
end, {})
