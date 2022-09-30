-- IMPORTS
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

-- SET WALLPAPER FUNCTION
local function set_wallpaper(s)
	local wallpaper = beautiful.wallpaper
	gears.wallpaper.maximized(wallpaper, s, true)
end

-- CALL SET WALLPAPER ON SCREEN RESIZE
screen.connect_signal("property::geometry", set_wallpaper)

-- SET WALLPAPER ON EACH SCREEN
awful.screen.connect_for_each_screen (
	function(s)
		set_wallpaper(s)
	end
)
