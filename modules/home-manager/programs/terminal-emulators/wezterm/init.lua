local wezterm = require "wezterm"

function recompute_stretch(window, pane)
  local window_dims = window:get_dimensions()
  local overrides = window:get_config_overrides() or {}
  local window_conf = window:effective_config() or {}
  local tab_dims = pane:tab():get_size()

  left_pad = math.floor((window_dims.pixel_width - tab_dims.pixel_width) / 2)
  top_pad = math.floor((window_dims.pixel_height - tab_dims.pixel_height) / 2)
  if
    overrides.window_padding
    and overrides.window_padding.left == left_pad
    and overrides.window_padding.top == top_pad
  then
    return
  end
  overrides.window_padding = {
    left = left_pad,
    right = 0,
    top = top_pad,
    bottom = 0
  }

  window:set_config_overrides(overrides)
end

wezterm.on("window-resized", function(window, pane)
  recompute_stretch(window, pane)
end)

wezterm.on("window-config-reloaded", function(window, pane)
  recompute_stretch(window_pane)
end)

local config = {
  adjust_window_size_when_changing_font_size = false,
  allow_square_glyphs_to_overflow_width = "Never",
  audible_bell = "Disabled",
  default_cursor_style = "SteadyBar",
  enable_kitty_graphics = true,
  font = wezterm.font "IosevkaTerm NF",
  font_size = 12.0,
  front_end = "WebGpu",
  hide_tab_bar_if_only_one_tab = true,
  window_background_opacity = 0.8
}

return config
