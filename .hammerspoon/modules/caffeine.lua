-- Module for preventing system sleep

---@class Caffeine Allows preventing system sleep
---@field menuBarItem? hs.menubar
---@field watcher? hs.caffeinate.watcher
local Caffeine = {}

-- Toggle menuBarItem
local function toggleMenuBarItem()
	if not Caffeine.menuBarItem then
		Caffeine.menuBarItem = hs.menubar.new(true, "hs.minusfive.caffeine")
		Caffeine.menuBarItem:setClickCallback(Caffeine.toggle)
	end

	local isActive = hs.caffeinate.get("displayIdle")
	local menuIcon = isActive and "0.0" or "-.-"
	local tooltip = isActive and "Insomniac" or "Sleepy"

	Caffeine.menuBarItem:setTitle(menuIcon)
	Caffeine.menuBarItem:setTooltip(tooltip)
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
