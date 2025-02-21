-- Load type annotations and docs for LSP
hs.loadSpoon("EmmyLua")
hs.loadSpoon("WindowManager")
hs.loadSpoon("AppLauncher")
hs.loadSpoon("Caffeine")
hs.loadSpoon("Hotkeys")

---@type AppLauncher
local al = spoon.AppLauncher

---@type WindowManager
local wm = spoon.WindowManager

---@type Caffeine
local cf = spoon.Caffeine

---@type Hotkeys
local hk = spoon.Hotkeys

-- Set default settings
hs.hotkey.alertDuration = 0.3
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

-- Base hotkeys
-- These are the most used / useful shortcuts, available through a single combination
---@type hs.hotkey.KeySpec[]
local baseSpecs = {
  -- Apps
  { hk.mods.meh, "d", "Discord", al:openApp("Discord") },
  { hk.mods.meh, "e", "Microsoft Outlook", al:openApp("Microsoft Outlook") }, -- Email
  { hk.mods.meh, "f", "Finder", al:openApp("Finder") },
  { hk.mods.meh, "g", "Google Chrome", al:openApp("Google Chrome") },
  { hk.mods.meh, "h", "Hammerspoon", al:openApp("Hammerspoon") },
  { hk.mods.hyper, "h", "Hints", hs.hints.windowHints },
  { hk.mods.meh, "k", "Slack", al:openApp("Slack") }, -- Chat, Channels
  { hk.mods.meh, "m", "Messages", al:openApp("Messages") },
  { hk.mods.meh, "n", "Notes", al:openApp("Notes") },
  { hk.mods.meh, "o", "Obsidian", al:openApp("Obsidian") },
  { hk.mods.meh, "p", "1Password", al:openApp("1Password") },
  { hk.mods.meh, "r", "Reminders", al:openApp("Reminders") },
  { hk.mods.meh, "s", "Safari", al:openApp("Safari") },
  { hk.mods.meh, "t", "WezTerm", al:openApp("WezTerm") },
  { hk.mods.hyper, "t", "Microsoft Teams", al:openApp("Microsoft Teams") },
  { hk.mods.meh, "w", "WhatsApp", al:openApp("WhatsApp") },
  { hk.mods.meh, "x", "Microsoft Excel", al:openApp("Microsoft Excel") },
  { hk.mods.meh, "z", "Zoom.us", al:openApp("Zoom.us") },

  -- Window Layouts
  -- Top Row
  { hk.mods.meh, "1", "1/4 1", wm:move(wm.layout.first25) },
  { hk.mods.meh, "2", "1/4 2", wm:move(wm.layout.second25) },
  { hk.mods.meh, "3", "1/4 3", wm:move(wm.layout.third25) },
  { hk.mods.meh, "4", "1/4 4", wm:move(wm.layout.fourth25) },

  { hk.mods.meh, "=", "Grow Width", wm.growX },
  { hk.mods.meh, "-", "Shrink Width", wm.shrinkX },
  { hk.mods.hyper, "=", "Grow Height", wm.growY },
  { hk.mods.hyper, "-", "Shrink Height", wm.shrinkY },

  -- Middle Row
  { hk.mods.meh, "7", "1/3 Left", wm:move(wm.layout.left33) },
  { hk.mods.meh, "8", "1/3 Center", wm:move(wm.layout.center33) },
  { hk.mods.meh, "9", "1/3 Right", wm:move(wm.layout.right33) },

  { hk.mods.meh, "6", "1/2 Left", wm:move(wm.layout.left50) },
  { hk.mods.meh, "space", "1/2 Center", wm:move(wm.layout.center50) },
  { hk.mods.meh, "0", "1/2 Right", wm:move(wm.layout.right50) },
}

-- Modal hotkeys

-- Common modal specs
---@type hs.hotkey.KeySpec[]
local commonModalSpecs = {
  -- Uniform ways of exiting modal environments
  { {}, "escape", nil, hk.activeModeExit },
}

-- System manipulation mode
---@type Hotkeys.ModalSpec
local modeSystem = {
  trigger = { hk.mods.hyper, "s", "System" },
  isOneShot = true,
  specs = {
    { {}, "a", "Activity Monitor", al:openApp("Activity Monitor") },
    { {}, "c", "Caffeine", cf.toggle },
    { {}, "h", "Hammerspoon", al:openApp("Hammerspoon") },
    {
      {},
      "r",
      "Reload Config",
      function()
        hs.notify.new({ title = "Reloading Configuration", subTitle = "This may take a few seconds" }):send()
        hs.reload()
      end,
    },
    { {}, ",", "System Preferences", al:openApp("System Preferences") },
  },
}

-- Window manager mode
---@type Hotkeys.ModalSpec
local modeWindowManager = {
  trigger = { hk.mods.hyper, "w", "Window" },
  isOneShot = true,
  specs = {
    { {}, "up", "1/2 Top", wm:move(wm.layout.top50) },
    { {}, "down", "1/2 Bottom", wm:move(wm.layout.bottom50) },

    -- Corners
    { { "shift" }, "1", "1/4 Top-Left", wm:move(wm.layout.topLeft25) },
    { { "shift" }, "2", "1/4 Top-Right", wm:move(wm.layout.topRigh25) },
    { { "shift" }, "3", "1/4 Bottom-Left", wm:move(wm.layout.bottomLeft25) },
    { { "shift" }, "4", "1/4 Bottom-Right", wm:move(wm.layout.bottomRigh25) },

    -- Move
    { {}, "[", "Move Left", wm.moveL },
    { {}, "]", "Move Right", wm.moveR },
    { { "shift" }, "[", "Prev Screen", wm.screenPrev },
    { { "shift" }, "]", "Next Screen", wm.screenNext },

    { {}, "c", "Center", wm.center },

    -- Resize
    { {}, "=", "Grow Width", wm.growX },
    { {}, "-", "Shrink Width", wm.shrinkX },
    { { "shift" }, "=", "Grow Height", wm.growY },
    { { "shift" }, "-", "Shrink Height", wm.shrinkY },

    { {}, "m", "Maximize", wm.maximixe },
    { {}, "f", "Full Screen", wm.toggleFullScreen },
  },
}

-- Append commonModalSpecs to each modal's specs
hs.fnutils.each(
  { modeSystem, modeWindowManager },
  function(modalSpec) modalSpec.specs = hs.fnutils.concat(modalSpec.specs, commonModalSpecs) end
)

hk:bindHotkeys({
  specs = baseSpecs,
  modes = {
    modeSystem,
    modeWindowManager,
  },
})

-- Start caffeine
cf.options.notifyOnStateChange = true
cf:start()

--- Start WindowManager
wm:start()

--- Start AppLauncher
al:start()

-- Enable HS CLI (inter-process communication)
require("hs.ipc")

-- Notify on config [re]load
hs.notify.new({ title = "Configuration Loaded", subTitle = "Settings applied" }):send()
