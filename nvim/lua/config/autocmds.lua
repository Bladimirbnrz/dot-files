--========= FileType TS-Highlighting =========--

vim.api.nvim_create_autocmd('FileType', {

  pattern = { "python", "c", "tex" }, -- langs you want to install automatically

  callback = function(ev)
    local ts = require("nvim-treesitter")

    local lang = vim.treesitter.language.get_lang(ev.match)

    if not lang then return end

    local installed_langs = ts.get_installed()
    local is_installed = vim.tbl_contains(installed_langs, lang)

    if not is_installed then
      local available_langs = ts.get_available()
      local is_available = vim.tbl_contains(available_langs, lang)

      if is_available then
        ts.install(lang):await(function()
          vim.treesitter.start()
        end)
      else
        return
      end
    else
      vim.treesitter.start()
    end
  end,
})



-- Maybe with this option tex-highlighting could be improved

-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = { "tex", "plaintex", "bib" },
--   callback = function()
--     vim.o.regexpengine = 1
--   end,
-- })


--========= Update filename =========--

vim.api.nvim_create_augroup("TitleUpdate", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost" }, {
  group = "TitleUpdate",
  callback = function()
    vim.o.titlestring = vim.fn.expand("%:t")
  end,
})


--========= Spell =========--
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex", "plaintex" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt.spelllang = { "es", "en" }
  end,
})


--========= Lint Trigger =========--

vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost", "TextChanged" }, {
  pattern = "*.f90",
  callback = function()
    local lint_status, lint = pcall(require, "lint")
    if vim.bo.modified then
      vim.cmd("silent write") ----> WARNING: this save the file every time you exit of insert mode
    end
    if lint_status then
      lint.try_lint()
    end
  end,
})


--========= Show/Hide Diagnostics on Insert(Enter/Leave) =========--

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.diagnostic.hide()
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.diagnostic.show(nil, 0)
  end,
})


--========= Auto open Oil-Preview on start =========--

-- Auxiliar function to try to open Oil-Preview several times silently
function Try_open_preview(max_retries, delay_ms)
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
        local buf = vim.api.nvim_win_get_buf(w)
        if vim.bo[buf].filetype == "oilpreview" then
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
    if vim.bo[ev.buf].filetype == "oil"
        and vim.env.NVIM_OIL_PREVIEW == "1"
    then
      -- Will try opening preview six times every twenty ms
      -- You can modify the number of attpemps or the interval between them if it does not working
      Try_open_preview(6, 30)
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
