local wezterm = require('wezterm')
local act = wezterm.action

local config = wezterm.config_builder()

config.color_scheme = 'kanagawabones'
config.font = wezterm.font 'IosevkaTerm Nerd Font'
config.font_size = 14


config.window_decorations = "RESIZE"
config.window_background_image = "C:/Users/bladi/OneDrive/Imágenes/Fondos/kanagawa-wallpaper.jpg"
config.window_background_opacity = 0.25

config.window_padding = {
  right = '0px',
  left = '0px',
  top = '11px',
  bottom = '0px'
}

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.enable_scroll_bar = false

config.colors = {
  tab_bar = {
    background = '#16161C',
    active_tab = {
      bg_color = '#283247',
      fg_color = '#DAD7BD',
    },
    inactive_tab = {
      bg_color = '#16161C',
      fg_color = '#808080',
    },
  },
}

wezterm.on("format-tab-title", function(tab, tabs)
  local title = tab.active_pane.title
  local index = tab.tab_index + 1

  if title:match("Yazi") then      -- if it is running yazi
    title = "y/" .. title:gsub('(.*[/\\])(.*)', '%2')
  elseif title:find("oil://") then -- if it is running nvim-oil
    local path = title:gsub("oil://", ""):gsub(" %- Nvim", "")

    title = path:match("([^/]+)/?$") or "oil"
    title = title:gsub("[%s%)%]%>]+$", "")

    title = "../" .. title
  elseif title:lower():match("/bladi") then
    title = "WezTerm"
  elseif title:find('[/\\]') then
    title = "/" .. title:gsub('(.*[/\\])(.*)', '%2')
  end

  title = index .. ": " .. title
  local min_width = 14
  if (#title > min_width) and not (title:find('[/\\]')) then --if it is not a /dir
    local ext = title:match("(%.%w+)$") or ""                -- capture the file extension ".ext"
    local base = title:sub(1, min_width - #ext - 2)
    title = base .. "…" .. ext
  elseif (#title > min_width) and (title:find('[/\\]')) then --if is it a /dir
    title = title:sub(1, min_width - 2) .. "…"
  elseif #title < min_width then
    title = title .. string.rep(" ", min_width - #title)
  end

  if index == 1 then
    return {
      { Text = title .. " " },
    }
  elseif index == #tabs then
    return {
      { Text = '▏' .. title .. "▕" },
    }
  else
    return {
      { Text = '▏' },
      { Text = title .. " " },
    }
  end
end)


config.max_fps = 240
config.enable_kitty_graphics = true


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
  -- Comment if the bindings (keymaps) do work natively with fish
  {
    key = 'Space',
    mods = 'SHIFT',
    action = wezterm.action.SendKey { key = "y", mods = "CTRL" },
  },

  -- Commenting this would be good if you do plan on using tmux

  { key = 'V', mods = 'ALT', action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = 'v', mods = 'ALT', action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

  { key = "h", mods = "ALT", action = act.ActivatePaneDirection("Left") },
  { key = "l", mods = "ALT", action = act.ActivatePaneDirection("Right") },
  { key = "k", mods = "ALT", action = act.ActivatePaneDirection("Up") },
  { key = "j", mods = "ALT", action = act.ActivatePaneDirection("Down") },

  -- Move to next tab
  { key = "n", mods = "ALT", action = act.ActivateTabRelative(1), },
  -- Move to previous tab
  { key = "p", mods = "ALT", action = act.ActivateTabRelative(-1), },

  -- Close the current tab/pane
  { key = 'w', mods = 'ALT', action = act.CloseCurrentPane({ confirm = true }) },
}

config.mouse_bindings = {
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
