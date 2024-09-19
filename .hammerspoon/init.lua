-- Load type annotations and docs for LSP
hs.loadSpoon("EmmyLua")
hs.loadSpoon("ReloadConfiguration")

-- Set default settings
hs.window.animationDuration = 0.066
hs.hotkey.alertDuration = 0.5
hs.alert.defaultStyle = {
	strokeWidth = 0,
	strokeColor = { white = 0, alpha = 0 },
	fillColor = { white = 0.05, alpha = 0.8 },
	textColor = { white = 1, alpha = 1 },
	textFont = ".AppleSystemUIFont",
	textStyle = { paragraphStyle = { lineSpacing = 10 } },
	textSize = 18,
	radius = 6,
	atScreenEdge = 1,
	fadeInDuration = 0.05,
	fadeOutDuration = 0.05,
	padding = 18,
}

-- Keep all modules in a common table
local m = {
	appLauncher = require("modules.appLauncher"),
	caffeine = require("modules.caffeine"),
	hotkeys = require("modules.hotkeys"),
	windowManager = require("modules.windowManager"),
}

-- Base hotkeys
-- These are the most used / useful shortcuts, available through a single combination
---@type hs.hotkey.KeySpec[]
local baseSpecs = {
	-- Apps
	{ m.hotkeys.mods.meh, "c", "Slack", m.appLauncher:openApp("Slack") },
	{ m.hotkeys.mods.meh, "d", "Discord", m.appLauncher:openApp("Discord") },
	{ m.hotkeys.mods.meh, "f", "Finder", m.appLauncher:openApp("Finder") },
	{ m.hotkeys.mods.meh, "g", "Google Chrome", m.appLauncher:openApp("Google Chrome") },
	{ m.hotkeys.mods.meh, "i", "Insomnia", m.appLauncher:openApp("Insomnia") },
	{ m.hotkeys.mods.meh, "m", "Messages", m.appLauncher:openApp("Messages") },
	{ m.hotkeys.mods.meh, "n", "Obsidian", m.appLauncher:openApp("Obsidian") },
	{ m.hotkeys.mods.hyper, "n", "Notes", m.appLauncher:openApp("Notes") },
	{ m.hotkeys.mods.meh, "o", "Microsoft Outlook", m.appLauncher:openApp("Microsoft Outlook") },
	{ m.hotkeys.mods.meh, "p", "1Password", m.appLauncher:openApp("1Password") },
	{ m.hotkeys.mods.meh, "r", "Reminders", m.appLauncher:openApp("Reminders") },
	{ m.hotkeys.mods.meh, "s", "Safari", m.appLauncher:openApp("Safari") },
	{ m.hotkeys.mods.meh, "t", "WezTerm", m.appLauncher:openApp("WezTerm") },
	{ m.hotkeys.mods.meh, "w", "WhatsApp", m.appLauncher:openApp("WhatsApp") },
	{ m.hotkeys.mods.meh, "x", "Microsoft Excel", m.appLauncher:openApp("Microsoft Excel") },
	{ m.hotkeys.mods.meh, "z", "Zoom.us", m.appLauncher:openApp("Zoom.us") },

	-- Window Layouts
	-- Top Row
	{ m.hotkeys.mods.meh, "2", "1/3 Left", m.windowManager:move(m.windowManager.layout.left33) },
	{ m.hotkeys.mods.meh, "3", "1/3 Center", m.windowManager:move(m.windowManager.layout.center33) },
	{ m.hotkeys.mods.meh, "4", "1/3 Right", m.windowManager:move(m.windowManager.layout.right33) },

	-- Middle Row
	{ m.hotkeys.mods.meh, "6", "1/4 1", m.windowManager:move(m.windowManager.layout.first25) },
	{ m.hotkeys.mods.meh, "7", "1/2 Left", m.windowManager:move(m.windowManager.layout.left50) },
	{ m.hotkeys.mods.hyper, "7", "1/4 2", m.windowManager:move(m.windowManager.layout.second25) },
	{ m.hotkeys.mods.meh, "8", "1/2 Center", m.windowManager:move(m.windowManager.layout.center50) },
	{ m.hotkeys.mods.meh, "9", "1/2 Right", m.windowManager:move(m.windowManager.layout.right50) },
	{ m.hotkeys.mods.hyper, "9", "1/4 3", m.windowManager:move(m.windowManager.layout.third25) },
	{ m.hotkeys.mods.meh, "0", "1/4 4", m.windowManager:move(m.windowManager.layout.fourth25) },
}

-- Modal hotkeys

-- Common modal specs
---@type hs.hotkey.KeySpec[]
local commonModalSpecs = {
	-- Uniform ways of exiting modal environments
	{ {}, "escape", nil, m.hotkeys.activeModeExit },
}

-- System manipulation mode
---@type Hotkeys.ModalSpec
local modeSystem = {
	trigger = { m.hotkeys.mods.hyper, "s", "System" },
	isOneShot = true,
	specs = {
		{ {}, "c", "Caffeine", m.caffeine.toggle },
		{ {}, "h", "Hammerspoon", m.appLauncher:openApp("Hammerspoon") },
		{ {}, "m", "Activity Monitor", m.appLauncher:openApp("Activity Monitor") },
		{ {}, "p", "System Preferences", m.appLauncher:openApp("System Preferences") },
		{ {}, "r", "Reload Config", hs.reload },
	},
}

-- Window manager mode
---@type Hotkeys.ModalSpec
local modeWindowManager = {
	trigger = { m.hotkeys.mods.hyper, "w", "Window Manager" },
	isOneShot = true,
	specs = {
		-- Top Row - Thirds [||]
		{ { "shift" }, "2", "1/3 Left", m.windowManager:move(m.windowManager.layout.left33) },
		{ { "shift" }, "3", "1/3 Center", m.windowManager:move(m.windowManager.layout.center33) },
		{ { "shift" }, "4", "1/3 Right", m.windowManager:move(m.windowManager.layout.right33) },

		-- Middle Row - Halves [|] and Quarters [|||]
		{ { "shift" }, "6", "1/4 1", m.windowManager:move(m.windowManager.layout.first25) },
		{ { "shift" }, "7", "1/2 Left", m.windowManager:move(m.windowManager.layout.left50) },
		{ { "cmd", "shift" }, "7", "1/4 2", m.windowManager:move(m.windowManager.layout.second25) },
		{ { "shift" }, "8", "1/2 Center", m.windowManager:move(m.windowManager.layout.center50) },
		{ { "shift" }, "9", "1/2 Right", m.windowManager:move(m.windowManager.layout.right50) },
		{ { "cmd", "shift" }, "9", "1/4 3", m.windowManager:move(m.windowManager.layout.third25) },
		{ { "shift" }, "0", "1/4 4", m.windowManager:move(m.windowManager.layout.fourth25) },

		{ {}, "up", "1/2 Top", m.windowManager:move(m.windowManager.layout.top50) },
		{ {}, "down", "1/2 Bottom", m.windowManager:move(m.windowManager.layout.bottom50) },

		-- Corners
		{ {}, "q", "1/4 Top-Left", m.windowManager:move(m.windowManager.layout.topLeft25) },
		{ {}, "b", "1/4 Top-Right", m.windowManager:move(m.windowManager.layout.topRigh25) },
		{ {}, "z", "1/4 Bottom-Left", m.windowManager:move(m.windowManager.layout.bottomLeft25) },
		{ {}, "v", "1/4 Bottom-Right", m.windowManager:move(m.windowManager.layout.bottomRigh25) },

		-- Move
		{ {}, "[", "Move Left", m.windowManager.moveL },
		{ {}, "]", "Move Right", m.windowManager.moveR },
		{ { "shift" }, "[", "Prev Screen", m.windowManager.screenPrev },
		{ { "shift" }, "]", "Next Screen", m.windowManager.screenNext },

		{ {}, "c", "Center", m.windowManager.center },

		-- Resize
		{ {}, "=", "Grow Width", m.windowManager.growX },
		{ {}, "-", "Shrink Width", m.windowManager.shrinkX },
		{ { "shift" }, "=", "Grow Height", m.windowManager.growY },
		{ { "shift" }, "-", "Shrink Height", m.windowManager.shrinkY },

		{ {}, "m", "Maximize", m.windowManager.maximixe },
		{ {}, "f", "Full Screen", m.windowManager.toggleFullScreen },
	},
}

-- Append commonModalSpecs to each modal's specs
hs.fnutils.each({ modeSystem, modeWindowManager }, function(modalSpec)
	modalSpec.specs = hs.fnutils.concat(modalSpec.specs, commonModalSpecs)
end)

m.hotkeys:bindHotkeys({
	specs = baseSpecs,
	modes = {
		modeSystem,
		modeWindowManager,
	},
})

-- Ensure all terminal windows open on specific positions depending on screen size
---@param window hs.window
local function weztermNewWindowWatcher(window)
	local desiredPosition = m.windowManager.layout.right50
	if window:screen():fullFrame().w >= 5120 then
		desiredPosition = m.windowManager.layout.center33
	end
	window:moveToUnit(desiredPosition, 0)
end
local weztermWindowFilter = hs.window.filter.new({ "Terminal", "WezTerm" })
weztermWindowFilter:subscribe(hs.window.filter.windowCreated, weztermNewWindowWatcher)

-- Ensure all browser windows open on specific positions depending on screen size
---@param window hs.window
local function browserNewWindowWatcher(window)
	---@type hs.application | nil
	local app = window:application()
	app = app and app:name()

	---@class Position
	---@field default string
	local pos = { default = m.windowManager.layout.right50, above5125 = m.windowManager.layout.right33 }

	if app == "Safari" then
		pos = { default = m.windowManager.layout.left50, above5125 = m.windowManager.layout.left33 }
	end

	local desiredPosition = pos.default
	if window:screen():fullFrame().w >= 5120 then
		desiredPosition = pos.above5125
	end
	window:moveToUnit(desiredPosition, 0)
end
local browserWindowFilter = hs.window.filter.new({ "Safari", "Google Chrome", "Firefox", "Brave" })
browserWindowFilter:subscribe(hs.window.filter.windowCreated, browserNewWindowWatcher)

-- Start caffeine
m.caffeine.start()

-- Start watching config changes to reload
spoon.ReloadConfiguration:start()
hs.alert.show("Hammerspoon Configuration Reloaded")
