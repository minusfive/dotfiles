-- Module to open / focus applictions
local AppLauncher = {}

-- Quickly open and/or focus applications
---@param name string
---@return function
function AppLauncher:openApp(name)
	return function()
		hs.application.launchOrFocus(name)
		if name == "Finder" then
			local app = hs.appfinder.appFromName(name)
			if app then
				app:activate()
			end
		end
	end
end

return AppLauncher
