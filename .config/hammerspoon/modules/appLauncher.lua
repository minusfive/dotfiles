-- Module to open / focus applictions and automate application tasks
---@class AppLauncher
local AppLauncher = {}

-- Quickly open and/or focus applications
---@param name string
---@return function
function AppLauncher:openApp(name)
	return function()
		hs.application.launchOrFocus(name)
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
	end
end

AppLauncher.watcher = hs.application.watcher.new(appWatcher)
AppLauncher.watcher:start()

return AppLauncher
