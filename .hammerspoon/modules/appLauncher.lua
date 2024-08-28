-- Module to open / focus applictions
---@class AppLauncher
local AppLauncher = {}

-- Quickly open and/or focus applications
---@param name string
---@return function
function AppLauncher:openApp(name)
	return function()
		hs.application.launchOrFocus(name)
		if name == "Finder" then
			---@type hs.application | nil
			local app = hs.appfinder.appFromName(name)
			if app then
				app:selectMenuItem({ "Window", "Bring All to Front" })
				app:activate()
			end
		end
	end
end

return AppLauncher
