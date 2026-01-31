-- Auxiliar function to try to open Oil-Preview several times silently
local function try_open_preview(max_retries, delay_ms)
  max_retries = max_retries or 5
  delay_ms = delay_ms or 50

  local function loop(retries_left)
    if retries_left <= 0 then
      return
    end

    vim.defer_fn(function()
      -- Try opening Oil silently
      vim.cmd("silent! lua require('oil').open_preview()")

      -- local variable to check if the preview opened
      local has_preview = false
      for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(w), "filetype") == "oilpreview" then
          has_preview = true
          break
        end
      end

      if not has_preview then
        -- if didn't open, try again
        loop(retries_left - 1)
      end
    end, delay_ms)
  end

  loop(max_retries)
end

-- autocmd and call the function try_open_preview
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function(ev)
    if vim.api.nvim_buf_get_option(ev.buf, "filetype") == "oil"
       and vim.env.NVIM_OIL_PREVIEW == "1"
    then
      -- Will try opening preview six times every ten ms 
      -- You can modify the number of attpemps or the interval between them if it does not working
      try_open_preview(6, 10)
      vim.env.NVIM_OIL_PREVIEW = nil
    end
  end,
})

-- Only try to open Oil-Preview once, but silently, just in case the function above does not work 
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "oil",
--   callback = function()
--     if vim.env.NVIM_OIL_PREVIEW == "1" then
--
--       vim.defer_fn(function()
--         vim.cmd("silent! lua require('oil').open_preview()")
--       end, 100)
--
--       vim.env.NVIM_OIL_PREVIEW = nil
--     end
--   end,
-- })
