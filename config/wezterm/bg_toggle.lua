local wezterm = require("wezterm")

wezterm.on("toggle-opacity", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 0.5
	else
		overrides.window_background_opacity = nil
	end
	window:set_config_overrides(overrides)
end)

return {
	keys = {
		{
			key = "K",
			mods = "CTRL",
			action = wezterm.action.EmitEvent("toggle-opacity"),
		},
	},
}
