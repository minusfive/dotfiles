-- Load type annotations and docs for LSP
hs.loadSpoon("EmmyLua")
-- Enable HS CLI (inter-process communication)
require("hs.ipc")

-- Set default settings
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
  ---@type AppLauncher
  appLauncher = require("modules.appLauncher"),
  ---@type Caffeine
  caffeine = require("modules.caffeine"),
  ---@type Hotkeys
  hotkeys = require("modules.hotkeys"),
  ---@type WindowManager
  windowManager = require("modules.windowManager"),
}

-- Base hotkeys
-- These are the most used / useful shortcuts, available through a single combination
---@type hs.hotkey.KeySpec[]
local baseSpecs = {
  -- Apps
  { m.hotkeys.mods.meh, "d", "Discord", m.appLauncher:openApp("Discord") },
  { m.hotkeys.mods.meh, "e", "Microsoft Outlook", m.appLauncher:openApp("Microsoft Outlook") }, -- Email
  { m.hotkeys.mods.meh, "f", "Finder", m.appLauncher:openApp("Finder") },
  { m.hotkeys.mods.meh, "g", "Google Chrome", m.appLauncher:openApp("Google Chrome") },
  { m.hotkeys.mods.meh, "h", "Hammerspoon", m.appLauncher:openApp("Hammerspoon") },
  { m.hotkeys.mods.hyper, "h", "Hints", hs.hints.windowHints },
  { m.hotkeys.mods.meh, "k", "Slack", m.appLauncher:openApp("Slack") }, -- Chat, Channels
  { m.hotkeys.mods.meh, "m", "Messages", m.appLauncher:openApp("Messages") },
  { m.hotkeys.mods.meh, "n", "Notes", m.appLauncher:openApp("Notes") },
  { m.hotkeys.mods.meh, "o", "Obsidian", m.appLauncher:openApp("Obsidian") },
  { m.hotkeys.mods.meh, "p", "1Password", m.appLauncher:openApp("1Password") },
  { m.hotkeys.mods.meh, "r", "Reminders", m.appLauncher:openApp("Reminders") },
  { m.hotkeys.mods.meh, "s", "Safari", m.appLauncher:openApp("Safari") },
  { m.hotkeys.mods.meh, "t", "WezTerm", m.appLauncher:openApp("WezTerm") },
  { m.hotkeys.mods.meh, "w", "WhatsApp", m.appLauncher:openApp("WhatsApp") },
  { m.hotkeys.mods.meh, "x", "Microsoft Excel", m.appLauncher:openApp("Microsoft Excel") },
  { m.hotkeys.mods.meh, "z", "Zoom.us", m.appLauncher:openApp("Zoom.us") },

  -- Window Layouts
  -- Top Row
  { m.hotkeys.mods.meh, "1", "1/4 1", m.windowManager:move(m.windowManager.layout.first25) },
  { m.hotkeys.mods.meh, "2", "1/4 2", m.windowManager:move(m.windowManager.layout.second25) },
  { m.hotkeys.mods.meh, "3", "1/4 3", m.windowManager:move(m.windowManager.layout.third25) },
  { m.hotkeys.mods.meh, "4", "1/4 4", m.windowManager:move(m.windowManager.layout.fourth25) },

  { m.hotkeys.mods.meh, "=", "Grow Width", m.windowManager.growX },
  { m.hotkeys.mods.meh, "-", "Shrink Width", m.windowManager.shrinkX },
  { m.hotkeys.mods.hyper, "=", "Grow Height", m.windowManager.growY },
  { m.hotkeys.mods.hyper, "-", "Shrink Height", m.windowManager.shrinkY },

  -- Middle Row
  { m.hotkeys.mods.meh, "7", "1/3 Left", m.windowManager:move(m.windowManager.layout.left33) },
  { m.hotkeys.mods.meh, "8", "1/3 Center", m.windowManager:move(m.windowManager.layout.center33) },
  { m.hotkeys.mods.meh, "9", "1/3 Right", m.windowManager:move(m.windowManager.layout.right33) },

  { m.hotkeys.mods.meh, "6", "1/2 Left", m.windowManager:move(m.windowManager.layout.left50) },
  { m.hotkeys.mods.meh, "space", "1/2 Center", m.windowManager:move(m.windowManager.layout.center50) },
  { m.hotkeys.mods.meh, "0", "1/2 Right", m.windowManager:move(m.windowManager.layout.right50) },
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
    { {}, "a", "Activity Monitor", m.appLauncher:openApp("Activity Monitor") },
    { {}, "c", "Caffeine", m.caffeine.toggle },
    { {}, "h", "Hammerspoon", m.appLauncher:openApp("Hammerspoon") },
    {
      {},
      "r",
      "Reload Config",
      function()
        hs.notify.new({ title = "Reloading Configuration", subTitle = "This may take a few seconds" }):send()
        hs.reload()
      end,
    },
    { {}, ",", "System Preferences", m.appLauncher:openApp("System Preferences") },
  },
}

-- Window manager mode
---@type Hotkeys.ModalSpec
local modeWindowManager = {
  trigger = { m.hotkeys.mods.hyper, "w", "Window" },
  isOneShot = true,
  specs = {
    { {}, "up", "1/2 Top", m.windowManager:move(m.windowManager.layout.top50) },
    { {}, "down", "1/2 Bottom", m.windowManager:move(m.windowManager.layout.bottom50) },

    -- Corners
    { { "shift" }, "1", "1/4 Top-Left", m.windowManager:move(m.windowManager.layout.topLeft25) },
    { { "shift" }, "2", "1/4 Top-Right", m.windowManager:move(m.windowManager.layout.topRigh25) },
    { { "shift" }, "3", "1/4 Bottom-Left", m.windowManager:move(m.windowManager.layout.bottomLeft25) },
    { { "shift" }, "4", "1/4 Bottom-Right", m.windowManager:move(m.windowManager.layout.bottomRigh25) },

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

-- Start caffeine
m.caffeine.start()

-- Notify on config [re]load
hs.notify.new({ title = "Configuration Loaded" }):send()
