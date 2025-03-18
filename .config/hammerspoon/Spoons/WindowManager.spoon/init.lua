--- Module to manage / manipulate windows
---@class WindowManager
local WindowManager = {
  name = "WindowManager",
  version = "0.1",
  author = "http://github.com/minusfive",
  license = "MIT - https://opensource.org/licenses/MIT",

  ---@class WindowManagerOptions
  ---@field enableFocusedWindowHighlight? boolean
  options = {
    enableFocusedWindowHighlight = false,
  },
}

-- Global settings
hs.window.animationDuration = 0.1
hs.window.highlight.ui.overlay = true
hs.window.highlight.ui.overlayColor = { hex = "#11111b", alpha = 0.000001 }
hs.window.highlight.ui.isolateColor = { hex = "#11111b", alpha = 0.9 }
hs.window.highlight.ui.frameWidth = 6
hs.window.highlight.ui.frameColor = { hex = "#cdd6f4", alpha = 0.2 }

---@alias hs.geometry.rect {x: number, y: number, w: number, h: number}

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
  left33 = { x = 0, y = 0, w = 0.3333, h = 1 },
  center33 = { x = 0.3333, y = 0, w = 0.3333, h = 1 },
  right33 = { x = 0.6666, y = 0, w = 0.3333, h = 1 },

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

-- Wrapper to perform certain operations before and after window movement
-- to reduce artifacts
---@generic T
---@param fn function():`T`
---@return T
local function __optimizeFrame(fn)
  if not WindowManager.options.enableFocusedWindowHighlight then return fn() end

  hs.window.highlight.stop()
  local result = fn()
  hs.timer.doAfter(hs.window.animationDuration + 0.02, hs.window.highlight.start)
  return result
end

-- Move window to specified rect coordinates
---@param unit hs.geometry.rect
function WindowManager:move(unit)
  return function()
    __optimizeFrame(function() hs.window.focusedWindow():move(unit, nil, true) end)
  end
end

-- Toggle window "Full Screen" state
function WindowManager:toggleFullScreen()
  __optimizeFrame(function() hs.window.focusedWindow():toggleFullScreen() end)
end

-- Maximize window
function WindowManager:maximixe()
  __optimizeFrame(function() hs.window.focusedWindow():maximize() end)
end

-- Center window on screen
function WindowManager:center()
  __optimizeFrame(function() hs.window.focusedWindow():centerOnScreen(nil, true, 0) end)
end

-- Move window to next screen
function WindowManager:screenNext()
  __optimizeFrame(
    function() hs.window.focusedWindow():moveToScreen(hs.window.focusedWindow():screen():next(), false, true) end
  )
end

-- Move window to previous screen
function WindowManager:screenPrev()
  __optimizeFrame(
    function() hs.window.focusedWindow():moveToScreen(hs.window.focusedWindow():screen():previous(), false, true) end
  )
end

-- Places window in a specific location within current screen bounds
---@param rect hs.geometry.rect
---@param duration? number
---@return hs.window
local function __setFrameInScreenBounds(rect, duration)
  local win = hs.window.focusedWindow()
  __optimizeFrame(function() win:setFrameInScreenBounds(rect, duration) end)
  return win
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

  __setFrameInScreenBounds({ x = newX, y = window.y, w = w, h = window.h })
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
  local isCentered = math.abs(window.x - (screen.x2 - window.x2)) < 4

  if isCentered then step = step / 2 end

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
  elseif isCentered then
    newX = math.max(0, math.floor((screen.w - newW) / 2))
  end

  __setFrameInScreenBounds({ x = newX, y = window.y, w = newW, h = window.h })
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
  local newY = window.y
  local isCentered = math.abs(window.y - (screen.y2 - window.y2)) < (screen.y + 4)

  if direction == "+" then
    newH = window.h + step
    newH = newH > screen.h and screen.h or newH
  elseif direction == "-" then
    newH = window.h - step
    newH = newH < minHeight and minHeight or newH
  end

  if window.y <= screen.y then
    newY = screen.y
  elseif window.y2 >= screen.y2 then
    newY = screen.h - newH
  elseif isCentered then
    newY = math.max(0, math.floor((screen.h - newH) / 2))
  end

  __setFrameInScreenBounds({ x = window.x, y = newY, w = window.w, h = newH })
end

-- Cycle window position to the right
function WindowManager:moveR() return WindowManager:cycleHorizontalPosition(">") end

-- Cycle window position to the left
function WindowManager:moveL() return WindowManager:cycleHorizontalPosition("<") end

function WindowManager:shrinkX() return WindowManager:resizeWindowWidthInSteps("-") end

function WindowManager:growX() return WindowManager:resizeWindowWidthInSteps("+") end

function WindowManager:shrinkY() return WindowManager:resizeWindowHeightInSteps("-") end

function WindowManager:growY() return WindowManager:resizeWindowHeightInSteps("+") end

-- Position mouse in center of focused windows whenever focus changes
---@param window hs.window
local function mouseFollowsFocus(window)
  -- Only update mouse if mouse buttons are not pressed (e.g. focus wasn't changed by mouse)
  if #hs.mouse.getButtons() ~= 0 then return end

  -- Position mouse in center of focused window if it's not already within its frame
  local currentMousePosition = hs.geometry(hs.mouse.absolutePosition())
  local frame = window:frame()
  if not currentMousePosition:inside(frame) then hs.mouse.absolutePosition(frame.center) end
end

-- Watch for focused window changes and trigger some actions
---@param window hs.window
local function focusedWindowWatcher(window) mouseFollowsFocus(window) end

-- Ensure all terminal windows open on specific positions depending on screen size
---@param window hs.window
local function terminalNewWindowWatcher(window)
  local desiredPosition = WindowManager.layout.right50
  if window:screen():fullFrame().w >= 5120 then desiredPosition = WindowManager.layout.center33 end
  window:moveToUnit(desiredPosition, 0)
end

-- Ensure all browser windows open on specific positions depending on screen size
---@param window hs.window
local function browserNewWindowWatcher(window)
  ---@type hs.application | nil
  local app = window:application()
  app = app and app:name()

  local pos = { default = WindowManager.layout.right50, above5125 = WindowManager.layout.right33 }

  if app == "Safari" then pos = { default = WindowManager.layout.left50, above5125 = WindowManager.layout.left33 } end

  local desiredPosition = pos.default
  if window:screen():fullFrame().w >= 5120 then desiredPosition = pos.above5125 end
  window:moveToUnit(desiredPosition, 0)
end

--- Initialize WindowManager
function WindowManager:init()
  local focusedWindowFilter = hs.window.filter.new()
  focusedWindowFilter:setOverrideFilter({ visible = true, focused = true, activeApplication = true })
  local weztermWindowFilter = hs.window.filter.new({ "Terminal", "WezTerm" })
  local browserWindowFilter = hs.window.filter.new({ "Safari", "Google Chrome", "Firefox", "Brave" })

  --- Starts the WindowManager watchers
  function WindowManager:start()
    focusedWindowFilter:subscribe(hs.window.filter.windowFocused, focusedWindowWatcher)
    weztermWindowFilter:subscribe(hs.window.filter.windowCreated, terminalNewWindowWatcher)
    browserWindowFilter:subscribe(hs.window.filter.windowCreated, browserNewWindowWatcher)

    if WindowManager.options.enableFocusedWindowHighlight then hs.window.highlight.start() end
  end

  --- Stops the WindowManager watchers
  function WindowManager:stop()
    focusedWindowFilter:unsubscribe(hs.window.filter.windowFocused, focusedWindowWatcher)
    weztermWindowFilter:unsubscribe(hs.window.filter.windowCreated, terminalNewWindowWatcher)
    browserWindowFilter:unsubscribe(hs.window.filter.windowCreated, browserNewWindowWatcher)

    hs.window.highlight.stop()
  end
end

return WindowManager
