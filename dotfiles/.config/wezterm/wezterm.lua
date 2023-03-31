local wezterm = require "wezterm"
local config = {
	color_scheme = "tokyonight",
	font = wezterm.font "Iosevka",
	font_size = 12,
	hide_tab_bar_if_only_one_tab = true,
	window_background_opacity = 0.8,
	window_padding = {
		left = "5px",
		right = 0,
		top = "5px",
		bottom = 0
	}
}

return config
