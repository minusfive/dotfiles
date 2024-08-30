-- Module for preventing system sleep

---@class Caffeine Allows preventing system sleep
---@field menuBarItem? hs.menubar
---@field watcher? hs.caffeinate.watcher
local Caffeine = {}

-- Toggle menuBarItem
local function toggleMenuBarItem()
	if not Caffeine.menuBarItem then
		Caffeine.menuBarItem = hs.menubar.new(true, "hs.minusfive.caffeine")
	end

	local menuIcon = hs.caffeinate.get("displayIdle") and "0.0" or "-.-"
	Caffeine.menuBarItem:setTitle(menuIcon)
end

-- Toggles system caffeination
function Caffeine.toggle()
	hs.caffeinate.toggle("displayIdle")
	toggleMenuBarItem()
end

function Caffeine.start()
	toggleMenuBarItem()
end

return Caffeine
