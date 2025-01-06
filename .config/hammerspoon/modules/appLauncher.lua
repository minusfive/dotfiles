-- Module to open / focus applictions and automate application tasks
---@class AppLauncher
---@field notifyOnActivation? boolean Whether to send notifications on app activation
local AppLauncher = { notifyOnActivation = false }

-- Quickly open and/or focus applications
---@param name string
---@return function
function AppLauncher:openApp(name)
  return function()
    hs.application.launchOrFocus(name)
  end
end

-- Sends a system notification whenever an app is activated
---@param app hs.application
local function __sendAppActivationNotification(app)
  if not AppLauncher.notifyOnActivation then
    return
  end

  local bundleID = app:bundleID()
  local appIcon = bundleID and hs.image.imageFromAppBundle(bundleID)

  local notification = hs.notify.new(nil, {
    title = app:name(),
    subTitle = "App Activated",
    information = app:pid(),
    contentImage = appIcon,
  })

  if notification then
    notification:send()
  end
end

-- Watch applications and automate actions
---@param name string Application name
---@param eventType unknown
---@param app hs.application
local function appWatcher(name, eventType, app)
  if eventType == hs.application.watcher.activated then
    if name == "Finder" then
      app:selectMenuItem({ "Window", "Bring All to Front" })
    end

    __sendAppActivationNotification(app)
  end
end

AppLauncher.watcher = hs.application.watcher.new(appWatcher)
AppLauncher.watcher:start()

return AppLauncher
