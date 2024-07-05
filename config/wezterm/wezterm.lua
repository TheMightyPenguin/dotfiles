-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "tokyonight_moon"

config.font = wezterm.font("Iosevka Nerd Font", { weight = "Medium" })
config.font_size = 18.0

-- and finally, return the configuration to wezterm
return config
