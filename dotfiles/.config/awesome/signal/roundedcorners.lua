-- IMPORTS
local gears = require("gears")
local beautiful = require("beautiful")

-- ROUNDED CORNERS
client.connect_signal("manage", function (c)
	c.shape = function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, beautiful.border_radius)
	end
end)
