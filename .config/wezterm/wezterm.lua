-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
-- Performance
config.front_end = "WebGpu"
config.animation_fps = 60

-- Enable advanced features
config.set_environment_variables = {
  TERMINFO_DIRS = "$HOME/.config/wezterm/terminfo",
  WSLENV = "TERMINFO_DIRS",
}
config.term = "wezterm"

-- Default working directory
config.default_cwd = wezterm.home_dir .. "/dev"

-- Theme
-- local tokyo_night_mod = wezterm.color.get_builtin_schemes()["tokyonight_night"]
-- -- tokyo_night_mod.background = "#16161e"
-- -- tokyo_night_mod.background = "#1a1b26"
-- tokyo_night_mod.tab_bar.background = tokyo_night_mod.tab_bar.inactive_tab_edge
-- tokyo_night_mod.tab_bar.new_tab.bg_color = tokyo_night_mod.background
-- tokyo_night_mod.tab_bar.active_tab.intensity = "Bold"
-- tokyo_night_mod.tab_bar.active_tab.bg_color = tokyo_night_mod.background
-- tokyo_night_mod.tab_bar.inactive_tab.bg_color = tokyo_night_mod.tab_bar.background

config.color_scheme = "Catppuccin Mocha"
-- config.color_schemes = { ["tokyonight_mod"] = tokyo_night_mod }
-- config.command_palette_bg_color = tokyo_night_mod.background
config.command_palette_font_size = 18.0
config.hide_tab_bar_if_only_one_tab = true
config.macos_window_background_blur = 20
config.quick_select_alphabet = "ARSTQWFPZXCVNEIOLUYMDHGJBK"
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 30
-- config.tab_bar_style = {
-- 	active_tab_left = wezterm.format({
-- 		{ Background = { Color = tokyo_night_mod.tab_bar.active_tab.bg_color } },
-- 		{ Foreground = { Color = tokyo_night_mod.tab_bar.active_tab.fg_color } },
-- 		{ Text = "  " },
-- 	}),
-- }
config.underline_position = -8
config.use_fancy_tab_bar = false
-- config.window_background_gradient = {
-- 	colors = { tokyo_night_mod.background, tokyo_night_mod.tab_bar.background },
-- 	orientation = "Vertical",
-- }
-- config.window_background_opacity = 0.925
config.window_decorations = "RESIZE"
config.window_padding = {
  bottom = 0,
  left = 0,
  right = 0,
  top = 0,
}
-- Cursor
config.cursor_blink_rate = 333
config.default_cursor_style = "BlinkingBlock"

-- Fonts
config.font = wezterm.font({
  family = "JetBrains Mono",
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})
-- config.font = wezterm.font("Berkeley Mono")
config.font_size = 18.0
config.line_height = 1.25
config.adjust_window_size_when_changing_font_size = false
config.custom_block_glyphs = true
config.anti_alias_custom_block_glyphs = true
config.bold_brightens_ansi_colors = true

-- Keys
config.enable_kitty_keyboard = true
config.enable_csi_u_key_encoding = false

-- Show active workspace in the status area
-- wezterm.on("update-right-status", function(window, pane)
-- 	window:set_right_status(window:active_workspace())
-- end)

-- Show which key table is active in the status area
-- wezterm.on("update-right-status", function(window, pane)
-- 	local name = window:active_key_table()
-- 	if name then
-- 		name = "TABLE: " .. name
-- 	end
-- 	window:set_right_status(name or "")
-- end)

config.leader = {
  key = "Space",
  mods = "OPT",
}

config.keys = {
  -- Workspaces
  -- { key = "n", mods = "CTRL", action = act.SwitchWorkspaceRelative(1) },
  -- { key = "p", mods = "CTRL", action = act.SwitchWorkspaceRelative(-1) },

  -- Split pane
  {
    key = "g",
    mods = "CMD",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },

  {
    key = "s",
    mods = "CMD",
    action = act.SplitPane({ direction = "Left" }),
  },

  {
    key = "p",
    mods = "CMD",
    action = act.SplitPane({ direction = "Up" }),
  },

  {
    key = "d",
    mods = "CMD",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },

  {
    key = "s",
    mods = "CMD|OPT",
    action = act.PaneSelect,
  },

  {
    key = "p",
    mods = "CMD|SHIFT",
    action = act.PaneSelect({ mode = "SwapWithActive" }),
  },

  {
    key = "z",
    mods = "CMD",
    action = act.TogglePaneZoomState,
  },

  {
    key = "t",
    mods = "CMD|OPT",
    action = act.ShowTabNavigator,
  },

  {
    key = "w",
    mods = "CMD",
    action = act.CloseCurrentPane({ confirm = true }),
  },

  {
    key = "w",
    mods = "CMD|SHIFT",
    action = act.CloseCurrentTab({ confirm = true }),
  },

  {
    key = "w",
    mods = "CMD|ALT",
    action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
  },

  {
    key = "LeftArrow",
    mods = "CMD",
    action = act.ActivatePaneDirection("Left"),
  },

  {
    key = "RightArrow",
    mods = "CMD",
    action = act.ActivatePaneDirection("Right"),
  },

  {
    key = "UpArrow",
    mods = "CMD",
    action = act.ActivatePaneDirection("Up"),
  },

  {
    key = "DownArrow",
    mods = "CMD",
    action = act.ActivatePaneDirection("Down"),
  },
  {
    key = "LeftArrow",
    mods = "CMD|OPT",
    action = act.AdjustPaneSize({ "Left", 2 }),
  },

  {
    key = "RightArrow",
    mods = "CMD|OPT",
    action = act.AdjustPaneSize({ "Right", 2 }),
  },

  {
    key = "UpArrow",
    mods = "CMD|OPT",
    action = act.AdjustPaneSize({ "Up", 2 }),
  },

  {
    key = "DownArrow",
    mods = "CMD|OPT",
    action = act.AdjustPaneSize({ "Down", 2 }),
  },
}

-- folke/zen-mode.nvim
wezterm.on("user-var-changed", function(window, pane, name, value)
  local overrides = window:get_config_overrides() or {}
  if name == "ZEN_MODE" then
    local incremental = value:find("+")
    local number_value = tonumber(value)
    if incremental ~= nil then
      while number_value > 0 do
        window:perform_action(wezterm.action.IncreaseFontSize, pane)
        number_value = number_value - 1
      end
      overrides.enable_tab_bar = false
    elseif number_value < 0 then
      window:perform_action(wezterm.action.ResetFontSize, pane)
      overrides.font_size = nil
      overrides.enable_tab_bar = true
    else
      overrides.font_size = number_value
      overrides.enable_tab_bar = false
    end
  end
  window:set_config_overrides(overrides)
end)

-- and finally, return the configuration to wezterm
return config
