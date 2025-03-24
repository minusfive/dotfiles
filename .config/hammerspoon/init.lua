-- Load type annotations and docs for LSP
hs.loadSpoon("EmmyLua")
hs.loadSpoon("WindowManager")
hs.loadSpoon("AppLauncher")
hs.loadSpoon("Caffeine")
hs.loadSpoon("Hotkeys")
hs.loadSpoon("RecursiveBinder")

---@type AppLauncher
local al = spoon.AppLauncher

---@type WindowManager
local wm = spoon.WindowManager

---@type Caffeine
local cf = spoon.Caffeine

---@type Hotkeys
local hk = spoon.Hotkeys

---@type RecursiveBinder
local rb = spoon.RecursiveBinder
local sk = rb.singleKey

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

-- -- Base hotkeys
-- -- These are the most used / useful shortcuts, available through a single combination
-- ---@type hs.hotkey.KeySpec[]
-- local baseSpecs = {
--   -- Apps
--   -- meh + a: AppLauncher mode (one shot)
--   -- hyper + a: AppLauncher mode (sticky)
--   { hk.mods.hyper, "d", "Discord", al:openApp("Discord") },
--   { hk.mods.meh, "e", "Microsoft Outlook", al:openApp("Microsoft Outlook") }, -- Email
--   { hk.mods.meh, "f", "Finder", al:openApp("Finder") },
--   { hk.mods.meh, "g", "Google Chrome", al:openApp("Google Chrome") },
--   { hk.mods.meh, "h", "Hammerspoon", al:openApp("Hammerspoon") },
--   { hk.mods.meh, "m", "Messages", al:openApp("Messages") },
--   { hk.mods.meh, "n", "Notes", al:openApp("Notes") },
--   { hk.mods.hyper, "n", "Obsidian", al:openApp("Obsidian") }, -- Notes
--   { hk.mods.meh, "p", "1Password", al:openApp("1Password") },
--   { hk.mods.meh, "r", "Reminders", al:openApp("Reminders") },
--   { hk.mods.meh, "s", "Safari", al:openApp("Safari") },
--   { hk.mods.hyper, "s", "Slack", al:openApp("Slack") },
--   { hk.mods.meh, "t", "WezTerm", al:openApp("WezTerm") },
--   { hk.mods.hyper, "t", "Microsoft Teams", al:openApp("Microsoft Teams") },
--   -- meh + w: Window manager mode (one shot)
--   -- hyper + w: Window manager mode (sticky)
--   { hk.mods.meh, "x", "Microsoft Excel", al:openApp("Microsoft Excel") },
--   { hk.mods.meh, "z", "Zoom.us", al:openApp("Zoom.us") },
-- }
--
-- -- Modal hotkeys
--
-- -- Common modal specs
-- ---@type hs.hotkey.KeySpec[]
-- local commonModalSpecs = {
--   -- Uniform ways of exiting modal environments
--   { {}, "escape", nil, hk.activeModeExit },
-- }
--
-- -- System manipulation mode
-- ---@type Hotkeys.ModalSpec
-- local modeSystem = {
--   trigger = { hk.mods.meh, ",", "System" }, -- `cmd + ,` is the standard shortcut for preferences on macOS
--   isOneShot = true,
--   specs = {
--     { {}, "a", "Activity Monitor", al:openApp("Activity Monitor") },
--     { {}, "c", "Caffeine", cf.toggle },
--     { {}, "h", "Hammerspoon", al:openApp("Hammerspoon") },
--     {
--       {},
--       "r",
--       "Reload Config",
--       function()
--         hs.notify.new({ title = "Reloading Configuration", subTitle = "This may take a few seconds" }):send()
--         hs.reload()
--       end,
--     },
--     { {}, ",", "System Preferences", al:openApp("System Preferences") },
--   },
-- }
--
-- -- AppLauncher mode
-- ---@type hs.hotkey.KeySpec[]
-- local appLauncherSpecs = {
--   { {}, "w", "WhatsApp", al:openApp("WhatsApp") },
-- }
--
-- ---@type Hotkeys.ModalSpec
-- local modeAppLauncherOneShot = {
--   trigger = { hk.mods.meh, "a", "App Launcher" },
--   isOneShot = true,
--   specs = appLauncherSpecs,
-- }
--
-- ---@type Hotkeys.ModalSpec
-- local modeAppLauncherSticky = {
--   trigger = { hk.mods.hyper, "a", "App Launcher" },
--   specs = appLauncherSpecs,
-- }
--
-- -- Window manager mode
-- ---@type hs.hotkey.KeySpec[]
-- local windowModeSpecs = {
--   {
--     {},
--     "h",
--     "Hints",
--     function()
--       hs.hints.windowHints()
--       hk:activeModeExit()
--     end,
--   },
--
--   -- Corners
--   { { "shift" }, "1", "1/4 Top-Left", wm:move(wm.layout.topLeft25) },
--   { { "shift" }, "2", "1/4 Top-Right", wm:move(wm.layout.topRigh25) },
--   { { "shift" }, "3", "1/4 Bottom-Left", wm:move(wm.layout.bottomLeft25) },
--   { { "shift" }, "4", "1/4 Bottom-Right", wm:move(wm.layout.bottomRigh25) },
--
--   -- Move
--   { {}, "up", "1/2 Top", wm:move(wm.layout.top50) },
--   { {}, "down", "1/2 Bottom", wm:move(wm.layout.bottom50) },
--
--   { {}, "[", "Move Left", wm.moveL },
--   { {}, "]", "Move Right", wm.moveR },
--
--   { { "shift" }, "[", "Prev Screen", wm.screenPrev },
--   { { "shift" }, "]", "Next Screen", wm.screenNext },
--
--   { { "shift" }, "c", "Center", wm.center },
--
--   { {}, "q", "1/4 1", wm:move(wm.layout.first25) },
--   { {}, "w", "1/4 2", wm:move(wm.layout.second25) },
--   { {}, "f", "1/4 3", wm:move(wm.layout.third25) },
--   { {}, "p", "1/4 4", wm:move(wm.layout.fourth25) },
--
--   { {}, "r", "1/3 Left", wm:move(wm.layout.left33) },
--   { {}, "s", "1/3 Center", wm:move(wm.layout.center33) },
--   { {}, "t", "1/3 Right", wm:move(wm.layout.right33) },
--
--   { {}, "x", "1/2 Left", wm:move(wm.layout.left50) },
--   { {}, "c", "1/2 Center", wm:move(wm.layout.center50) },
--   { {}, "d", "1/2 Right", wm:move(wm.layout.right50) },
--
--   -- Resize
--   { {}, "m", "Maximize", wm.maximixe },
--   { {}, "f", "Full Screen", wm.toggleFullScreen },
--
--   { {}, "=", "Grow Width", wm.growX },
--   { {}, "-", "Shrink Width", wm.shrinkX },
--   { { "shift" }, "=", "Grow Height", wm.growY },
--   { { "shift" }, "-", "Shrink Height", wm.shrinkY },
-- }
--
-- ---@type Hotkeys.ModalSpec
-- local modeWindowManagerOneShot = {
--   trigger = { hk.mods.meh, "w", "Window" },
--   isOneShot = true,
--   specs = windowModeSpecs,
-- }
--
-- ---@type Hotkeys.ModalSpec
-- local modeWindowManagerSticky = {
--   trigger = { hk.mods.hyper, "w", "Window" },
--   specs = windowModeSpecs,
-- }
--
-- -- Append commonModalSpecs to each modal's specs
-- hs.fnutils.each(
--   { modeAppLauncherOneShot, modeAppLauncherSticky, modeSystem, modeWindowManagerOneShot, modeWindowManagerSticky },
--   function(modalSpec) modalSpec.specs = hs.fnutils.concat(modalSpec.specs, commonModalSpecs) end
-- )

-- hk:bindHotkeys({
--   specs = baseSpecs,
--   modes = {
--     modeAppLauncherOneShot,
--     modeAppLauncherSticky,
--     modeSystem,
--     modeWindowManagerOneShot,
--     modeWindowManagerSticky,
--   },
-- })

local rbKeymap = {
  [{ hk.mods.hyper, "space", "Leader" }] = {
    [sk("a", "App Launcher")] = {
      [sk("d", "Discord")] = al:openApp("Discord"),
      [sk("e", "Microsoft Outlook")] = al:openApp("Microsoft Outlook"), -- Email
      [sk("f", "Finder")] = al:openApp("Finder"),
      [sk("g", "Google Chrome")] = al:openApp("Google Chrome"),
      [sk("h", "Hammerspoon")] = al:openApp("Hammerspoon"),
      [sk("m", "Messages")] = al:openApp("Messages"),
      [sk("n", "Notes")] = al:openApp("Notes"),
      [sk("N", "Obsidian")] = al:openApp("Obsidian"), -- Notes
      [sk("p", "1Password")] = al:openApp("1Password"),
      [sk("r", "Reminders")] = al:openApp("Reminders"),
      [sk("s", "Safari")] = al:openApp("Safari"),
      [sk("N", "Slack")] = al:openApp("Slack"),
      [sk("t", "WezTerm")] = al:openApp("WezTerm"),
      [sk("N", "Microsoft Teams")] = al:openApp("Microsoft Teams"),
      [sk("x", "Microsoft Excel")] = al:openApp("Microsoft Excel"),
      [sk("z", "Zoom.us")] = al:openApp("Zoom.us"),
    },

    [sk("w", "Window Manager")] = {
      [sk("h", "Hints")] = hs.hints.windowHints,

      -- Corners
      -- [sk("!", "1/4 Top-Left")] = wm:move(wm.layout.topLeft25),
      -- [sk("@", "1/4 Top-Right")] = wm:move(wm.layout.topRigh25),
      -- [sk("#", "1/4 Bottom-Left")] = wm:move(wm.layout.bottomLeft25),
      -- [sk("$", "1/4 Bottom-Right")] = wm:move(wm.layout.bottomRigh25),

      -- Move
      [sk("up", "1/2 Top")] = wm:move(wm.layout.top50),
      [sk("down", "1/2 Bottom")] = wm:move(wm.layout.bottom50),

      [sk("[", "Move Left")] = wm.moveL,
      [sk("]", "Move Right")] = wm.moveR,

      -- [sk("{", "Prev Screen")] = wm.screenPrev,
      -- [sk("}", "Next Screen")] = wm.screenNext,

      [sk("C", "Center")] = wm.center,

      [sk("q", "1/4 1")] = wm:move(wm.layout.first25),
      [sk("w", "1/4 2")] = wm:move(wm.layout.second25),
      [sk("f", "1/4 3")] = wm:move(wm.layout.third25),
      [sk("p", "1/4 4")] = wm:move(wm.layout.fourth25),

      [sk("r", "1/3 Left")] = wm:move(wm.layout.left33),
      [sk("s", "1/3 Center")] = wm:move(wm.layout.center33),
      [sk("t", "1/3 Right")] = wm:move(wm.layout.right33),

      [sk("x", "1/2 Left")] = wm:move(wm.layout.left50),
      [sk("c", "1/2 Center")] = wm:move(wm.layout.center50),
      [sk("d", "1/2 Right")] = wm:move(wm.layout.right50),

      -- Resize
      [sk("m", "Maximize")] = wm.maximixe,
      [sk("f", "Full Screen")] = wm.toggleFullScreen,

      [sk("=", "Grow Width")] = wm.growX,
      [sk("-", "Shrink Width")] = wm.shrinkX,
      -- [sk("+", "Grow Height")] = wm.growY,
      -- [sk("_", "Shrink Height")] = wm.shrinkY,
    },

    [sk("s", "System")] = {
      [sk("a", "Activity Monitor")] = al:openApp("Activity Monitor"),
      [sk("c", "Caffeine")] = cf.toggle,
      [sk("h", "Hammerspoon")] = al:openApp("Hammerspoon"),
      [sk("r", "Reload Config")] = function()
        hs.notify.new({ title = "Reloading Configuration", subTitle = "This may take a few seconds" }):send()
        hs.reload()
      end,
      [sk(",", "System Preferences")] = al:openApp("System Preferences"),
    },
  },
}

rb.recursiveBind(rbKeymap)

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
