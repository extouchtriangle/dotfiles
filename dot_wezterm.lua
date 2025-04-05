-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom.background = "#000000"
config.window_background_opacity = 0.75
config.font = wezterm.font("Maple Mono")
config.font_size = 14

-- and finally, return the configuration to wezterm
return config
