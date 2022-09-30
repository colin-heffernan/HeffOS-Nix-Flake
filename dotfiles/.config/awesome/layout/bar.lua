-- IMPORTS
local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

-- MAKE A BAR FOR EACH SCREEN
awful.screen.connect_for_each_screen(
	function(s)
		-- LEFT POWERLINE SHAPE
		local bar_powerline_left = function(cr, width, height)
			gears.shape.powerline(cr, width, height, height/2)
		end

		-- RIGHT POWERLINE SHAPE
		local bar_powerline_right = function(cr, width, height)
			gears.shape.powerline(cr, width, height, -1 * (height/2))
		end

		-- TAGLIST
		local bar_taglist = wibox.widget {
			{
				awful.widget.taglist {
					screen = s,
					filter = awful.widget.taglist.filter.all,
					layout = {
						spacing = 0,
						layout = wibox.layout.fixed.horizontal
					},
					widget_template = {
						{
							{
								{
									id = "text_role",
									widget = wibox.widget.textbox,
								},
								layout = wibox.layout.fixed.horizontal,
							},
							left = 18,
							right = 18,
							widget = wibox.container.margin
						},
						id = "background_role",
						widget = wibox.container.background,
					}
				},
				left = 5,
				right = 5,
				widget = wibox.container.margin
			},
			bg = beautiful.light,
			widget = wibox.container.background,
			shape = bar_powerline_left
		}

		-- MPD
		local get_mpd_cmd = "mpc status"
		local bar_mpd_current_song = wibox.widget {
			id = "current_song",
			widget = wibox.widget.textbox,
			font = beautiful.font .. " 10"
		}
		local update_graphic = function(_, stdout, _, _, _)
			local current_song = string.gmatch(stdout, "[^\r\n]+")()
			stdout = string.gsub(stdout, "\n", "")
			local mpdstatus = string.match(stdout, "%[(%a+)%]")
			if mpdstatus == "playing" then
				bar_mpd_current_song.markup = "" .. current_song
			elseif mpdstatus == "paused" then
				bar_mpd_current_song.markup = "" .. current_song
			else
				if string.len(stdout) == 0 then
					bar_mpd_current_song.markup = "MPD is not running"
				else
					bar_mpd_current_song.markup = ""
				end
			end
		end
		awful.widget.watch(get_mpd_cmd, 1, update_graphic, bar_mpd_current_song)
		local bar_mpd = wibox.widget {
			{
				wibox.widget {
					bar_mpd_current_song,
					layout = wibox.layout.align.horizontal
				},
				left = 18,
				right = 18,
				widget = wibox.container.margin
			},
			bg = beautiful.medium,
			fg = beautiful.light,
			-- visible = false,
			shape = bar_powerline_left,
			widget = wibox.container.background
		}

		-- SYSTRAY
		local bar_systray = wibox.widget {
			wibox.widget {
				wibox.widget {
					-- visible = false,
					widget = wibox.widget.systray
				},
				left = 18,
				right = 18,
				widget = wibox.container.margin,
			},
			bg = beautiful.medium,
			shape = bar_powerline_right,
			widget = wibox.container.background
		}

		-- CLOCK
		local bar_clock = wibox.widget {
			wibox.widget {
				wibox.widget{
					format = "%a, %b %d, %Y %H:%M:%S",
					refresh = 1,
					font = beautiful.font .. " 10",
					widget = wibox.widget.textclock
				},
				left = 15,
				right = 15,
				widget = wibox.container.margin
			},
			bg = beautiful.light,
			fg = beautiful.dark,
			shape = bar_powerline_right,
			widget = wibox.container.background
		}

		-- WIBAR
		s.bar_wibox = awful.wibar({
			-- border_width = 10,
			position = "top",
			screen = s,
			bg = "#ff000000",
			height = 32
		})
		s.bar_wibox:setup {
			{
				layout = wibox.layout.align.horizontal,
				{
					layout = wibox.layout.fixed.horizontal,
					bar_taglist,
					bar_mpd,
				},
				{
					layout = wibox.layout.flex.horizontal,
				},
				{
					layout = wibox.layout.fixed.horizontal,
					bar_systray,
					bar_clock,
				}
			},
			top = 10,
			left = 10,
			right = 10,
			widget = wibox.container.margin,
		}
	end
)
