local wezterm = require('wezterm')
local act = wezterm.action

local config = wezterm.config_builder()

config.color_scheme = 'kanagawabones'

config.window_padding = {
    right = '0px',
    left = '0px',
    top = '11px',
    bottom = '0px'
}


config.font = wezterm.font 'IosevkaTerm Nerd Font'
config.font_size = 14

config.max_fps = 240
config.enable_kitty_graphics = true

config.window_background_opacity = 0.85
config.native_macos_fullscreen_mode = true
config.hide_tab_bar_if_only_one_tab = true
config.enable_scroll_bar = false

-- config.default_domain = 'WSL:Ubuntu'
config.default_domain = 'WSL:Debian'
config.front_end = 'OpenGL'

local gpus = wezterm.gui.enumerate_gpus()

if #gpus > 0 then
    config.webgpu_preferred_adapter = gpus[1] -- only set if there's at least one GPU
else
    -- fallback to default behavior or log a message
    wezterm.log_info("No GPUs found, using default settings")
end

config.keys = {
  -- comment if the bindings (keymaps) do work natively with fish 
  {
    key = 'Space',
    mods = 'SHIFT',
    action = wezterm.action.SendKey { key="y", mods="CTRL" },
  },
  --
  -- Uncommenting this would be good if you don't plan on using tmux
  --
  -- { key = 'V', mods = 'ALT', action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  -- { key = 'v', mods = 'ALT', action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  --
  -- { key = "h", mods = "ALT", action = act.ActivatePaneDirection("Left") },
  -- { key = "l", mods = "ALT", action = act.ActivatePaneDirection("Right") },
  -- { key = "k", mods = "ALT", action = act.ActivatePaneDirection("Up") },
  -- { key = "j", mods = "ALT", action = act.ActivatePaneDirection("Down") },

  { key = 'w', mods = 'ALT', action = act.CloseCurrentPane({ confirm = true }) },
}

config.mouse_bindings ={
  {
  event = { Down = { streak = 1, button = "Right" } },
	mods = "NONE",
	action = wezterm.action_callback(function(window, pane)
		local has_selection = window:get_selection_text_for_pane(pane) ~= ""
		if has_selection then
			window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
			window:perform_action(act.ClearSelection, pane)
		else
			window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
		end
		end),
	},
}

-- comment if the bindings (keymaps) do work natively with fish 
-- config.enable_kitty_keyboard = true 

return config
