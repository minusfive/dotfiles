-- Module to manage / manipulate windows
---@alias hs.geometry.rect {x: number, y: number, w: number, h: number}

---@class WindowManager
local WindowManager = {}

-- Convenience list of unit rects for common window layouts
---@enum (key) WindowManager.layout
WindowManager.layout = {
	maximized = { x = 0, y = 0, w = 1, h = 1 },

	--- 1/2
	top50 = { x = 0, y = 0, w = 1, h = 0.5 },
	bottom50 = { x = 0, y = 0.5, w = 1, h = 0.5 },
	left50 = { x = 0, y = 0, w = 0.5, h = 1 },
	center50 = { x = 0.25, y = 0, w = 0.5, h = 1 },
	right50 = { x = 0.5, y = 0, w = 0.5, h = 1 },

	--- 1/3
	left33 = { x = 0, y = 0, w = 0.333, h = 1 },
	center33 = { x = 0.333, y = 0, w = 0.333, h = 1 },
	right33 = { x = 0.666, y = 0, w = 0.333, h = 1 },

	--- 1/4
	first25 = { x = 0, y = 0, w = 0.25, h = 1 },
	second25 = { x = 0.25, y = 0, w = 0.25, h = 1 },
	third25 = { x = 0.50, y = 0, w = 0.25, h = 1 },
	fourth25 = { x = 0.75, y = 0, w = 0.25, h = 1 },

	topLeft25 = { x = 0, y = 0, w = 0.50, h = 0.50 },
	topRigh25 = { x = 0.50, y = 0, w = 0.50, h = 0.50 },
	bottomLeft25 = { x = 0, y = 0.50, w = 0.50, h = 0.50 },
	bottomRigh25 = { x = 0.50, y = 0.50, w = 0.50, h = 0.50 },
}

-- Move window to specified rect coordinates
---@param unit hs.geometry.rect
function WindowManager:move(unit)
	return function()
		hs.window.focusedWindow():move(unit, nil, true)
	end
end

-- Toggle window "Full Screen" state
function WindowManager:toggleFullScreen()
	hs.window.focusedWindow():toggleFullScreen()
end

-- Maximize window
function WindowManager:maximixe()
	hs.window.focusedWindow():maximize()
end

-- Center window on screen
function WindowManager:center()
	hs.window.focusedWindow():centerOnScreen(nil, true, 0)
end

-- Move window to next screen
function WindowManager:screenNext()
	hs.window.focusedWindow():moveToScreen(hs.window.focusedWindow():screen():next(), false, true)
end

-- Move window to previous screen
function WindowManager:screenPrev()
	hs.window.focusedWindow():moveToScreen(hs.window.focusedWindow():screen():previous(), false, true)
end

-- Cycle window position to next available of equal size
---@param direction "<" | ">"
function WindowManager:cycleHorizontalPosition(direction)
	local screen = hs.window.focusedWindow():screen():frame()
	local window = hs.window.focusedWindow():frame()
	local x = window.x
	local w = window.w
	local sw = screen.w
	local newX = x

	if direction == "<" then
		newX = x >= w and x - w or sw - w
	elseif direction == ">" then
		newX = x + w
		newX = newX <= (sw - w) and newX or 0
	end

	hs.window.focusedWindow():setFrameInScreenBounds({ x = newX, y = window.y, w = w, h = window.h })
end

-- Cycle window position to the right
function WindowManager:moveR()
	WindowManager:cycleHorizontalPosition(">")
end

-- Cycle window position to the left
function WindowManager:moveL()
	WindowManager:cycleHorizontalPosition("<")
end

-- Increase or decrease window width in steps
---@param direction "+" | "-"
---@param step? integer (Optional) number of pixes window should grow by. Defaults to 100.
---@param minWidth? integer (Optional) minimum window width. Max is always screen width.
function WindowManager:resizeWindowWidthInSteps(direction, step, minWidth)
	-- Defaults
	step = step or 100
	minWidth = minWidth or 200

	local screen = hs.window.focusedWindow():screen():frame()
	local window = hs.window.focusedWindow():frame()
	local newW = window.w
	local newX = window.x

	if direction == "+" then
		newW = window.w + step
		newW = newW > screen.w and screen.w or newW
	elseif direction == "-" then
		newW = window.w - step
		newW = newW < minWidth and minWidth or newW
	end

	if window.x <= screen.x then
		newX = screen.x
	elseif window.x2 >= screen.x2 then
		newX = screen.w - newW
	elseif window.x == (screen.x2 - window.x2) then
		newX = math.max(0, math.floor((screen.w - newW) / 2))
	end

	hs.window.focusedWindow():setFrameInScreenBounds({ x = newX, y = window.y, w = newW, h = window.h })
end

-- Resize window height in steps
---@param direction "+" | "-"
---@param step? integer (Optional) number of pixes window should grow by. Defaults to 100.
---@param minHeight? integer (Optional) minimum window width. Max is always screen width.
function WindowManager:resizeWindowHeightInSteps(direction, step, minHeight)
	-- Defaults
	step = step or 100
	minHeight = minHeight or 200

	local screen = hs.window.focusedWindow():screen():frame()
	local window = hs.window.focusedWindow():frame()
	local newH = window.h
	local newY = window.h

	if direction == "+" then
		newH = window.h + step
		newH = newH > screen.h and screen.w or newH
	elseif direction == "-" then
		newH = window.h - step
		newH = newH < minHeight and minHeight or newH
	end

	if window.y <= screen.y then
		newY = screen.y
	elseif window.y2 >= screen.y2 then
		newY = screen.h - newH
	elseif window.y == (screen.y2 - window.y2) then
		newY = math.max(0, math.floor((screen.h - newH) / 2))
	end

	hs.window.focusedWindow():setFrameInScreenBounds({ x = window.x, y = newY, w = window.w, h = newH })
end

function WindowManager:shrinkX()
	WindowManager:resizeWindowWidthInSteps("-")
end

function WindowManager:growX()
	WindowManager:resizeWindowWidthInSteps("+")
end

function WindowManager:shrinkY()
	WindowManager:resizeWindowHeightInSteps("-")
end

function WindowManager:growY()
	WindowManager:resizeWindowHeightInSteps("+")
end

return WindowManager
