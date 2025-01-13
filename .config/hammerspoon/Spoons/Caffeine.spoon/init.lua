-- Module for preventing system sleep

---@class Caffeine Allows preventing system sleep
---@field menuBarItem? hs.menubar
---@field watcher? hs.caffeinate.watcher
local Caffeine = {
  name = "Caffeine",
  version = "1.0",
  author = "http://github.com/minusfive",
  license = "MIT - https://opensource.org/licenses/MIT",

  ---@class CaffeineOptions
  ---@field notifyOnStateChange? boolean
  options = {
    notifyOnStateChange = false,
  },
}

-- Gets the caffeine active state
---@return boolean | nil
local function __getCaffeineState()
  return hs.caffeinate.get("displayIdle")
end

-- Gets the menuIcon from state
---@param isActive? boolean
local function __getMenuIcon(isActive)
  return isActive and "0.0" or "-.-"
end

--- Gets the tooltip from state
---@param isActive? boolean
local function __getMenuTooltip(isActive)
  return isActive and "Insomniac" or "Sleepy"
end

-- Sends a system notification whenever an app is activated
---@param isActive? boolean
local function __sendAppActivationNotification(isActive)
  if not Caffeine.options.notifyOnStateChange then
    return
  end

  local notification = hs.notify.new(nil, {
    title = __getMenuIcon(isActive),
    subTitle = __getMenuTooltip(isActive),
  })

  if notification then
    notification:send()
  end
end

-- Toggle menuBarItem
local function __toggleMenuBarItem()
  local isActive = __getCaffeineState()
  Caffeine.menuBarItem:setTitle(__getMenuIcon(isActive))
  Caffeine.menuBarItem:setTooltip(__getMenuTooltip(isActive))
  __sendAppActivationNotification(isActive)
end

-- Toggles system caffeination
function Caffeine.toggle()
  hs.caffeinate.toggle("displayIdle")
  __toggleMenuBarItem()
end

function Caffeine:start()
  if not Caffeine.menuBarItem then
    Caffeine.menuBarItem = hs.menubar.new(true, "hs.minusfive.caffeine")
    Caffeine.menuBarItem:setClickCallback(Caffeine.toggle)
  end
  __toggleMenuBarItem()
end

function Caffeine:stop()
  if Caffeine.menuBarItem then
    Caffeine.menuBarItem:delete()
  end
end

return Caffeine
