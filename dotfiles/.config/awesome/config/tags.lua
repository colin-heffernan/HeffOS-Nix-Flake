-- IMPORTS
local awful = require("awful")

-- LAYOUTS
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.floating,
}

-- TAGS
tags = {
	"",
	"",
	"",
	"",
	"",
	"",
	"",
}

-- SET TAGS FOR EACH SCREEN
awful.screen.connect_for_each_screen (
	function(s)
		awful.tag(tags, s, awful.layout.layouts[1])
	end
)
