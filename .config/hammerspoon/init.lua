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
  -- meh + a: AppLauncher mode (one shot)
  -- hyper + a: AppLauncher mode (sticky)
  { hk.mods.meh, "f", "Finder", al:openApp("Finder") },
  { hk.mods.meh, "g", "Google Chrome", al:openApp("Google Chrome") },
  { hk.mods.meh, "h", "Hammerspoon", al:openApp("Hammerspoon") },
  { hk.mods.meh, "n", "Notes", al:openApp("Notes") },
  { hk.mods.meh, "o", "Microsoft Outlook", al:openApp("Microsoft Outlook") },
  { hk.mods.meh, "p", "1Password", al:openApp("1Password") },
  { hk.mods.meh, "r", "Reminders", al:openApp("Reminders") },
  { hk.mods.meh, "s", "Safari", al:openApp("Safari") },
  { hk.mods.meh, "t", "WezTerm", al:openApp("WezTerm") },
  { hk.mods.meh, "v", "Microsoft Teams", al:openApp("Microsoft Teams") },
  -- meh + w: Window manager mode (one shot)
  -- hyper + w: Window manager mode (sticky)
  { hk.mods.meh, "x", "Microsoft Excel", al:openApp("Microsoft Excel") },
  { hk.mods.meh, "z", "Zoom.us", al:openApp("Zoom.us") },
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
  trigger = { hk.mods.meh, ",", "System" }, -- `cmd + ,` is the standard shortcut for preferences on macOS
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

-- AppLauncher mode
---@type hs.hotkey.KeySpec[]
local appLauncherSpecs = {
  { {}, "d", "Discord", al:openApp("Discord") },
  { {}, "m", "Messages", al:openApp("Messages") },
  { {}, "o", "Obsidian", al:openApp("Obsidian") },
  { {}, "w", "WhatsApp", al:openApp("WhatsApp") },
  { {}, "s", "Slack", al:openApp("Slack") },
}

---@type Hotkeys.ModalSpec
local modeAppLauncherOneShot = {
  trigger = { hk.mods.meh, "a", "App Launcher" },
  isOneShot = true,
  specs = appLauncherSpecs,
}

---@type Hotkeys.ModalSpec
local modeAppLauncherSticky = {
  trigger = { hk.mods.hyper, "a", "App Launcher" },
  specs = appLauncherSpecs,
}

-- Window manager mode
---@type hs.hotkey.KeySpec[]
local windowModeSpecs = {
  -- Resize
  { {}, "m", "Maximize", wm.maximixe },
  { {}, "f", "Full Screen", wm.toggleFullScreen },

  { {}, "=", "Grow Width", wm.growX },
  { {}, "-", "Shrink Width", wm.shrinkX },
  { hk.mods.shift, "=", "Grow Height", wm.growY },
  { hk.mods.shift, "-", "Shrink Height", wm.shrinkY },

  -- Move
  { {}, "up", "1/2 Top", wm:move(wm.layout.top50) },
  { {}, "down", "1/2 Bottom", wm:move(wm.layout.bottom50) },

  { {}, "left", "Move Left", wm.moveL },
  { {}, "right", "Move Right", wm.moveR },

  { hk.mods.shift, "left", "Prev Screen", wm.screenPrev },
  { hk.mods.shift, "right", "Next Screen", wm.screenNext },

  { hk.mods.shift, "c", "Center", wm.center },

  { {}, "r", "1/2 Left", wm:move(wm.layout.left50) },
  { {}, "s", "1/2 Center", wm:move(wm.layout.center50) },
  { {}, "t", "1/2 Right", wm:move(wm.layout.right50) },

  { hk.mods.shift, "r", "1/3 Left", wm:move(wm.layout.left33) },
  { hk.mods.shift, "s", "1/3 Center", wm:move(wm.layout.center33) },
  { hk.mods.shift, "t", "1/3 Right", wm:move(wm.layout.right33) },

  { {}, "a", "1/4 1", wm:move(wm.layout.first25) },
  { hk.mods.alt, "r", "1/4 2", wm:move(wm.layout.second25) },
  { hk.mods.alt, "t", "1/4 3", wm:move(wm.layout.third25) },
  { {}, "g", "1/4 4", wm:move(wm.layout.fourth25) },

  -- Corners
  { {}, "q", "1/4 Top-Left", wm:move(wm.layout.topLeft25) },
  { {}, "b", "1/4 Top-Right", wm:move(wm.layout.topRigh25) },
  { {}, "z", "1/4 Bottom-Left", wm:move(wm.layout.bottomLeft25) },
  { {}, "v", "1/4 Bottom-Right", wm:move(wm.layout.bottomRigh25) },
}

---@type Hotkeys.ModalSpec
local modeWindowManagerOneShot = {
  trigger = { hk.mods.meh, "w", "Window" },
  isOneShot = true,
  specs = windowModeSpecs,
}

---@type Hotkeys.ModalSpec
local modeWindowManagerSticky = {
  trigger = { hk.mods.hyper, "w", "Window" },
  specs = windowModeSpecs,
}

-- Append commonModalSpecs to each modal's specs
hs.fnutils.each(
  { modeAppLauncherOneShot, modeAppLauncherSticky, modeSystem, modeWindowManagerOneShot, modeWindowManagerSticky },
  function(modalSpec) modalSpec.specs = hs.fnutils.concat(modalSpec.specs, commonModalSpecs) end
)

hk:bindHotkeys({
  specs = baseSpecs,
  modes = {
    modeAppLauncherOneShot,
    modeAppLauncherSticky,
    modeSystem,
    modeWindowManagerOneShot,
    modeWindowManagerSticky,
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
