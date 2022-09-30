-- IMPORTS
local beautiful = require("beautiful")

-- ON FOCUS
client.connect_signal("focus", function(c) c.border_color = beautiful.border_color_active end)

-- ON UNFOCUS
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_color_normal end)
