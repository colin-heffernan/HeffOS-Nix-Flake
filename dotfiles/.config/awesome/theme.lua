-- IMPORTS
local beautiful = require("beautiful")
local gears = require("gears")

-- EMPTY THEME ARRAY
local theme = {}

-- THEME COLORS
theme.light = "#7aa2f7"
theme.medium = "#414868"
theme.dark = "#1a1b26"
theme.transparent = "#00000000"

-- FONT
theme.font = "Iosevka"

-- WALLPAPER
theme.wallpaper = "/home/obsi/Pictures/Backgrounds/BaseGlitch.png"

-- SYSTRAY
theme.bg_systray = theme.medium

-- GAPS/BORDERS
theme.useless_gap = 5
theme.border_width = 2
theme.border_color_active = theme.light
theme.border_color_normal = theme.dark
theme.border_radius = 0

-- NOTIFICATIONS
theme.notification_font = theme.font .. " 18"
theme.notification_border_width = 0
theme.notification_bg = theme.light
theme.notification_fg = theme.dark
theme.notification_icon_size = 64

-- TAGLIST
theme.taglist_fg_focus = theme.light
theme.taglist_bg_focus = theme.dark
theme.taglist_fg_urgent = theme.dark
theme.taglist_bg_urgent = theme.light
theme.taglist_fg_occupied = theme.dark
theme.taglist_bg_occupied = theme.light
theme.taglist_fg_empty = theme.dark
theme.taglist_bg_empty = theme.light
theme.taglist_fg_volatile = theme.dark
theme.taglist_bg_volatile = theme.light
theme.taglist_font = theme.font .. " 18"
theme.taglist_shape = gears.shape.powerline

-- INIT
beautiful.init(theme)
