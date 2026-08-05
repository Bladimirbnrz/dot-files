return {
  -- This is a fork of https://github.com/let-def/texpresso.vim.git
  "bladimirbnrz/texpresso.vim",
  ft = "tex",
  config = function()
    -- Path to TeXpresso
    local username = vim.uv.os_get_passwd().username
    require('texpresso').texpresso_path = "/home/" .. username .. "/.texpresso/build/texpresso"
  end,
}
