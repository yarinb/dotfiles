local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font("BerkeleyMono Nerd Font")
config.font_rules = {
	{
		intensity = "Bold",
		font = wezterm.font({ family = "BerkeleyMono Nerd Font", weight = "Bold" }),
	},
}

config.font_size = 16.0
config.line_height = 1.0
config.color_scheme = "Tokyo Night"

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

return config
