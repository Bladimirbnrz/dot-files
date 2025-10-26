local aug = vim.api.nvim_create_augroup("StartupCommands", { clear = true })

local function toggle_neotree()
  local ok, neo_cmd = pcall(require, "neo-tree.command")
  if ok and neo_cmd then
    neo_cmd.execute({
      toggle = true,
      -- optional: source = "filesystem",
      -- dir = vim.loop.cwd(), -- in default open in cwd
    })
    return
  end

  local attempts = 0
  local function try()
    attempts = attempts + 1
    local ok2, neo_cmd2 = pcall(require, "neo-tree.command")
    if ok2 and neo_cmd2 then
      neo_cmd2.execute({ toggle = true })
      return
    end
    if attempts < 10 then
      vim.defer_fn(try, 100)
    else
      vim.notify("Can't open NeoTree", vim.log.levels.WARN)
    end
  end
  vim.defer_fn(try, 100)
end

vim.api.nvim_create_autocmd("VimEnter", {
  group = aug,
  callback = function()
    if vim.fn.argc() == 0 then
      toggle_neotree()
      vim.defer_fn(function()
        local seq = vim.api.nvim_replace_termcodes("P", true, false, true)
        vim.api.nvim_feedkeys(seq, 'm', false)
      end, 20)
    end
  end,
})
