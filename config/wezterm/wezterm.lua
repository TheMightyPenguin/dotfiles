local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- require("bg_toggle")

config.color_scheme = "tokyonight_moon"

-- "Iosevka" (plain) has no Powerline or nerd glyphs, so the starship prompt
-- loses its segment separators and branch icon. Ask for the nerd-font build
-- by name, with an explicit symbols fallback rather than relying on wezterm's
-- implicit one. Both families come from modules/fonts.nix.
config.font = wezterm.font_with_fallback({
	{ family = "IosevkaTerm Nerd Font", weight = "Medium" },
	{ family = "Symbols Nerd Font Mono" },
})
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
