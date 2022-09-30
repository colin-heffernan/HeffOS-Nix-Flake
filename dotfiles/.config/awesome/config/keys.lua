-- IMPORTS
local awful = require("awful")
local gears = require("gears")

local mod = "Mod4"

-- GLOBAL KEYBINDS
globalkeys = gears.table.join(
	awful.key(	{ mod }, "Return",
			function()
				awful.spawn("kitty")
			end,
			{ DESCRIPTION = "Launch terminal"}),
	awful.key(	{ mod }, "b",
			function()
				awful.spawn("firefox")
			end,
			{ DESCRIPTION = "Launch Firefox" }),
	awful.key(	{ mod, "Shift" }, "b",
			function()
				awful.spawn("firefox -private-window")
			end,
			{ DESCRIPTION = "Launch Firefox incognito" }),
	awful.key(	{ mod }, "p",
			function()
				awful.spawn("rofi -modi drun -show drun")
			end,
			{ DESCRIPTION = "Launch Rofi" }),
	awful.key(	{ mod, "Shift" }, "Tab",
			function()
				awful.client.focus.byidx(1)
			end,
			{ DESCRIPTION = "Toggle focus" }),
	awful.key(	{ mod }, "[",
			function()
				awful.spawn("amixer set Master 1%-")
			end,
			{ DESCRIPTION = "Decrement volume" }),
	awful.key(	{ mod }, "]",
			function()
				awful.spawn("amixer set Master 1%+")
			end,
			{ DESCRIPTION = "Increment volume" }),
	awful.key(	{ mod }, "q",
			awesome.restart,
			{ DESCRIPTION = "Restart Awesome" }),
	awful.key(	{ mod, "Shift" }, "q",
			awesome.quit,
			{ DESCRIPTION = "Quit Awesome" })
)

-- CLIENT KEYBINDS
clientkeys = gears.table.join(
	awful.key(	{ mod }, "c",
			function(c)
				c:kill()
			end,
			{ DESCRIPTION = "Kill current window" }),
	awful.key(	{ mod }, "space",
			function(c)
				c.fullscreen = not c.fullscreen
				c:raise()
			end,
			{ DESCRIPTION = "Toggle fullscreen" }),
	awful.key(	{ mod, "Shift" }, "Return",
			function(c)
				c:swap(awful.client.getmaster())
			end,
			{ DESCRIPTION = "Swap active window with master" }),
	awful.key(	{ mod, "Shift" }, "t",
			function(c)
				c.floating = not c.floating
				c:raise()
			end,
			{ DESCRIPTION = "Toggle floating window (probably)" })
)

-- TAG GLOBAL KEYBINDS
for i = 1, 7 do
	globalkeys = gears.table.join(globalkeys,
		awful.key(	{ mod }, "#" .. i + 9,
				function()
					local screen = awful.screen.focused()
					local tag = screen.tags[i]
					if tag then
						tag:view_only()
						local client = screen.clients[1]
						client:emit_signal("request::activate", "tag_change", { raise = false })
					end
				end,
				{ DESCRIPTION = "View group #" .. i }),
		awful.key(	{ mod, "Shift" }, "#" .. i + 9,
				function()
					if client.focus then
						local tag = client.focus.screen.tags[i]
						if tag then
							client.focus:move_to_tag(tag)
						end
					end
				end,
				{ DESCRIPTION = "Move focused window to tag #" .. i })
	)
end

-- CLIENT MOUSEBINDS
clientbuttons = gears.table.join(
	awful.button(	{}, 1,
			function (c)
				c:emit_signal("request::activate", "mouse_click", {raise = true})
			end),
	awful.button(	{ mod }, 1,
			function (c)
				c:emit_signal("request::activate", "mouse_click", {raise = true})
				c.floating = true
				awful.mouse.client.move(c)
			end),
	awful.button(	{ mod }, 3,
			function (c)
				c:emit_signal("request::activate", "mouse_click", {raise = true})
				c.floating = true
				awful.mouse.client.resize(c)
			end)
)

-- SET KEYBINDS
root.keys(globalkeys)
