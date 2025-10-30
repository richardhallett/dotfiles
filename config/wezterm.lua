-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- For example, changing the initial geometry for new windows:
-- config.initial_cols = 120
-- config.initial_rows = 28

config.font_size = 10
-- config.font = wezterm.font 'JetBrains Mono'
config.font = wezterm.font_with_fallback {
    {
      family = 'JetBrains Mono',
      harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
    },
    { family = 'Terminus', weight = 'Bold' },
    'Noto Color Emoji',
}
-- config.color_scheme = 'AdventureTime'

-- Finally, return the configuration to wezterm:
return config
