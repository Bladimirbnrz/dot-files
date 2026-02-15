return {
  "kylechui/nvim-surround",
  version = "^3.0.0",
  event = "VeryLazy",
  config = function()
    -- Disable all built-in keymaps; you manage keymaps in your keymaps.lua
    require("nvim-surround").setup({
      keymaps = {
        insert = false,      -- there are no keymaps declared in keymaps.lua
        insert_line = false, -- there are no keymaps declared in keymaps.lua
        normal = false,
        normal_line = false, -- there are no keymaps declared in keymaps.lua
        normal_cur = false,
        normal_cur_line = false,
        visual = false,
        visual_line = false,
      }
    })
  end,
}

