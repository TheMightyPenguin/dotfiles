local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- require("bg_toggle")

config.color_scheme = "tokyonight_moon"

config.font = wezterm.font("Iosevka Term", { weight = "Medium" })
config.font_size = 18.0

config.window_padding = {
	left = 0,
	right = 0,
	top = 8,
	bottom = 0,
}

config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

config.window_background_opacity = 0.9
config.macos_window_background_blur = 35
config.win32_system_backdrop = "Acrylic"

return config
