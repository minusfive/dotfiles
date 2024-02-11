-- Window Manager and App Launcher
local WM = {}
WM.meh = { "ctrl", "alt", "shift" }
WM.hyper = { "ctrl", "alt", "shift", "cmd" }

-- Set default window resize animation duration
hs.window.animationDuration = 0
-- Bind hotkeys help modal
-- hs.hotkey.showHotkeys(WM.meh, "k")
-- Disable hotkey alerts
hs.hotkey.alertDuration = 0

-- Default Alert style
hs.alert.defaultStyle = {
	strokeWidth = 0,
	strokeColor = { white = 0, alpha = 0 },
	fillColor = { white = 0, alpha = 0.5 },
	textColor = { white = 1, alpha = 1 },
	textFont = ".AppleSystemUIFont",
	textStyle = { paragraphStyle = { lineSpacing = 10 } },
	textSize = 16,
	radius = 6,
	atScreenEdge = 2,
	fadeInDuration = 0.1,
	fadeOutDuration = 0.1,
	padding = nil,
}

--- Quickly open and/or focus applications
function WM:openApp(name)
	return function()
		hs.application.launchOrFocus(name)
		if name == "Finder" then
			hs.appfinder.appFromName(name):activate()
		end
	end
end

-- Move window to specified rect coordinates
function WM:move(unit)
	return function()
		hs.window.focusedWindow():move(unit, nil, true)
	end
end

-- Maximize window
function WM:maximize()
	hs.window.focusedWindow():maximize()
end

-- Toggle window "Full Screen" state
function WM:toggleFullScreen()
	hs.window.focusedWindow():toggleFullScreen()
end

-- Toggle window Zoom
function WM:toggleZoom()
	hs.window.focusedWindow():toggleZoom()
end

-- Center window on screen
function WM:center()
	hs.window.focusedWindow():centerOnScreen(nil, true, 0)
end

-- Move window to next screen
function WM:screenNext()
	hs.window.focusedWindow():moveToScreen(hs.window.focusedWindow():screen():next(), false, true)
end

-- Move window to previous screen
function WM:screenPrev()
	hs.window.focusedWindow():moveToScreen(hs.window.focusedWindow():screen():previous(), false, true)
end

-- Cycle window position to the right
function WM:cycleXR()
	local screen = hs.window.focusedWindow():screen():frame()
	local window = hs.window.focusedWindow():frame()
	local x = window.x
	local w = window.w
	local sw = screen.w

	local newX = (x + w) / sw
	newX = newX < 0.99 and newX or 0

	WM:move({ x = newX, y = 0.00, w = math.abs(w / sw), h = 1.00 })()
end

-- Cycle window position to the left
function WM:cycleXL()
	local screen = hs.window.focusedWindow():screen():frame()
	local window = hs.window.focusedWindow():frame()
	local x = window.x
	local w = window.w
	local sw = screen.w

	local newX = x - w
	newX = (newX < 0 and sw - w or newX) / sw

	WM:move({ x = newX, y = 0.00, w = math.abs(w / sw), h = 1.00 })()
end

-- Increase or decrease window size in steps
function WM:resizeWindowInSteps(increment)
	local screen = hs.window.focusedWindow():screen():frame()
	local window = hs.window.focusedWindow():frame()
	local wStep = math.floor(screen.w / 48)
	local hStep = math.floor(screen.h / 48)
	local x = window.x
	local y = window.y
	local w = window.w
	local h = window.h

	if increment then
		local xu = math.max(screen.x, x - wStep)
		local yu = math.max(screen.y, y - hStep)
		w = w + (x - xu)
		x = xu
		h = h + (y - yu)
		y = yu
		w = math.min(screen.w - x + screen.x, w + wStep)
		h = math.min(screen.h - y + screen.y, h + hStep)
	else
		local noChange = true
		local notMinWidth = w > wStep * 3
		local notMinHeight = h > hStep * 3

		local snapLeft = x <= screen.x
		local snapTop = y <= screen.y
		-- add one pixel in case of odd number of pixels
		local snapRight = (x + w + 1) >= (screen.x + screen.w)
		local snapBottom = (y + h + 1) >= (screen.y + screen.h)

		local b2n = { [true] = 1, [false] = 0 }
		local totalSnaps = b2n[snapLeft] + b2n[snapRight] + b2n[snapTop] + b2n[snapBottom]

		if notMinWidth and (totalSnaps <= 1 or not snapLeft) then
			x = x + wStep
			w = w - wStep
			noChange = false
		end

		if notMinHeight and (totalSnaps <= 1 or not snapTop) then
			y = y + hStep
			h = h - hStep
			noChange = false
		end

		if notMinWidth and (totalSnaps <= 1 or not snapRight) then
			w = w - wStep
			noChange = false
		end

		if notMinHeight and (totalSnaps <= 1 or not snapBottom) then
			h = h - hStep
			noChange = false
		end

		if noChange then
			x = notMinWidth and x + wStep or x
			y = notMinHeight and y + hStep or y
			w = notMinWidth and w - wStep * 2 or w
			h = notMinHeight and h - hStep * 2 or h
		end
	end

	WM:move({ x = x, y = y, w = w, h = h })()
end

function WM:resizeIn()
	WM:resizeWindowInSteps(false)
end

function WM:resizeOut()
	WM:resizeWindowInSteps(true)
end

function WM:bindHotkeys()
	for _, v in pairs(self.hotkeys) do
		hs.hotkey.bind(v[2], v[3], v[1], v[4])
	end
end

WM.hotkeys = {
	-- App launcher hotkeys
	-- For Colemak-DH keyboard layout
	-- ============ RIGHT hand =============
	-- TOP row
	-- MIDDLE row
	-- BOTTOM row
	-- =====================================

	-- ============= LEFT hand =============
	-- TOP row
	{ "App: Notes", WM.meh, "w", WM:openApp("Notes") }, -- "write"
	{ "App: WhatsApp", WM.hyper, "w", WM:openApp("WhatsApp") }, -- "write"
	{ "App: Finder", WM.meh, "f", WM:openApp("Finder") },
	-- MIDDLE row
	{ "App: WezTerm", WM.meh, "t", WM:openApp("WezTerm") }, -- "terminal"
	{ "App: Messages", WM.hyper, "t", WM:openApp("Messages") }, -- "text"
	{ "App: Slack", WM.meh, "s", WM:openApp("Safari") },
	{ "App: Slack", WM.hyper, "s", WM:openApp("Slack") },
	{ "App: Outlook", WM.meh, "r", WM:openApp("Microsoft Outlook") }, -- "reply"
	{ "App: Insomnia", WM.meh, "a", WM:openApp("Insomnia") }, -- "api"
	-- BOTTOM row
	{ "App: Zoom", WM.meh, "z", WM:openApp("Zoom.us") },
	{ "App: Chrome", WM.meh, "c", WM:openApp("Google Chrome") }, -- "chrome"
	-- { "App: Discord", WM.meh, "d", WM:openApp("Discord") },
	{ "App: VSCode", WM.meh, "v", WM:openApp("Visual Studio Code") }, -- "VSCode"
	{ "App: Pulse Secure", WM.hyper, "v", WM:openApp("Pulse Secure") }, -- "vpn"
	-- =====================================

	{ "Window: Center", WM.hyper, "e", WM.center },

	{ "Window: Zoom", WM.hyper, "z", WM.toggleZoom },
	{ "Window: Full Screen", WM.hyper, "f", WM.toggleFullScreen },

	{ "Window: Cycle R", WM.meh, "]", WM.cycleXR },
	{ "Window: Cycle L", WM.meh, "[", WM.cycleXL },

	{ "Window: Next Screen", WM.hyper, "]", WM.screenNext },
	{ "Window: Prev Screen", WM.hyper, "[", WM.screenPrev },

	{ "Window: ResizeIn", WM.meh, "-", WM.resizeIn },
	{ "Window: ResizeOut", WM.meh, "=", WM.resizeOut },

	{ "Window: Maximize", WM.meh, "m", WM.maximize },
	{ "Window: 1/2 T", WM.hyper, "up", WM:move({ x = 0.00, y = 0.00, w = 1.00, h = 0.50 }) },
	{ "Window: 1/2 B", WM.hyper, "down", WM:move({ x = 0.00, y = 0.50, w = 1.00, h = 0.50 }) },
	{ "Window: 1/2 L", WM.meh, "n", WM:move({ x = 0.00, y = 0.00, w = 0.50, h = 1.00 }) },
	{ "Window: 1/2 C", WM.meh, "e", WM:move({ x = 0.25, y = 0.00, w = 0.50, h = 1.00 }) },
	{ "Window: 1/2 R", WM.meh, "i", WM:move({ x = 0.50, y = 0.00, w = 0.50, h = 1.00 }) },
	{ "Window: 1/3 L", WM.meh, "h", WM:move({ x = 0.0000, y = 0.00, w = 0.3333, h = 1.00 }) },
	{ "Window: 1/3 C", WM.meh, ",", WM:move({ x = 0.3333, y = 0.00, w = 0.3333, h = 1.00 }) },
	{ "Window: 1/3 R", WM.meh, ".", WM:move({ x = 0.6666, y = 0.00, w = 0.3333, h = 1.00 }) },
	{ "Window: 1/4 ↖", WM.hyper, "j", WM:move({ x = 0.00, y = 0.00, w = 0.50, h = 0.50 }) },
	{ "Window: 1/4 ↗", WM.hyper, "l", WM:move({ x = 0.50, y = 0.00, w = 0.50, h = 0.50 }) },
	{ "Window: 1/4 ↙", WM.hyper, "k", WM:move({ x = 0.00, y = 0.50, w = 0.50, h = 0.50 }) },
	{ "Window: 1/4 ↘", WM.hyper, "h", WM:move({ x = 0.50, y = 0.50, w = 0.50, h = 0.50 }) },
	{ "Window: 1/4 1", WM.meh, "left", WM:move({ x = 0.00, y = 0.00, w = 0.25, h = 1.00 }) },
	{ "Window: 1/4 2", WM.meh, "up", WM:move({ x = 0.25, y = 0.00, w = 0.25, h = 1.00 }) },
	{ "Window: 1/4 3", WM.meh, "down", WM:move({ x = 0.50, y = 0.00, w = 0.25, h = 1.00 }) },
	{ "Window: 1/4 4", WM.meh, "right", WM:move({ x = 0.75, y = 0.00, w = 0.25, h = 1.00 }) },

	-- { "Fifth1", WM.hyper, 'a', WM:move({ x = 0.00, y = 0.00, w = 0.20, h = 1.00 }) },
	-- { "Fifth2", WM.hyper, 'r', WM:move({ x = 0.20, y = 0.00, w = 0.20, h = 1.00 }) },
	-- { "Fifth3", WM.hyper, 's', WM:move({ x = 0.40, y = 0.00, w = 0.20, h = 1.00 }) },
	-- { "Fifth4", WM.hyper, 't', WM:move({ x = 0.60, y = 0.00, w = 0.20, h = 1.00 }) },
	-- { "Fifth5", WM.hyper, 'g', WM:move({ x = 0.80, y = 0.00, w = 0.20, h = 1.00 }) },

	-- { "Sixth1", WM.hyper, 'q', WM:move({ x = 0.0000, y = 0.00, w = 0.1666, h = 1.00 }) },
	-- { "Sixth2", WM.hyper, 'w', WM:move({ x = 0.1666, y = 0.00, w = 0.1666, h = 1.00 }) },
	-- { "Sixth3", WM.hyper, 'f', WM:move({ x = 0.3333, y = 0.00, w = 0.1666, h = 1.00 }) },
	-- { "Sixth4", WM.hyper, 'z', WM:move({ x = 0.5000, y = 0.00, w = 0.1666, h = 1.00 }) },
	-- { "Sixth5", WM.hyper, 'x', WM:move({ x = 0.6666, y = 0.00, w = 0.1666, h = 1.00 }) },
	-- { "Sixth6", WM.hyper, 'c', WM:move({ x = 0.8333, y = 0.00, w = 0.1666, h = 1.00 }) },
}

WM:bindHotkeys()
