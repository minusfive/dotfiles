-- Module to handle hotkey actions

---@alias hs.hotkey.KeySpec [string[], string, string, function?, function?, function?]

---@class Hotkeys
---@field mods {meh: string[], hyper: string[]}
---@field activeMode hs.hotkey.modal | nil
---@field activeModeSpecs hs.hotkey.KeySpec[] | nil
---@field keyListener hs.eventtap | nil
---@field menuBarItem hs.menubar | nil
local Hotkeys = {
	mods = {
		meh = { "ctrl", "alt", "shift" },
		hyper = { "ctrl", "alt", "shift", "cmd" },
	},
	activeMode = nil,
	activeModeSpecs = nil,
	keyListener = nil,
	menuBarItem = nil,
}

---@class Hotkeys.ModalSpec
---@field trigger [string[], string, string]
---@field specs? hs.hotkey.KeySpec[]

-- Setup modal hotkeys environments
---@param modalSpec Hotkeys.ModalSpec
---@return hs.hotkey.modal
local function configureModal(modalSpec)
	local modal = hs.hotkey.modal.new(table.unpack(modalSpec.trigger))
	local specs = modalSpec.specs or {}

	-- Bind all specs
	for _, spec in ipairs(specs) do
		modal:bind(table.unpack(spec))
	end

	---@diagnostic disable-next-line: duplicate-set-field
	function modal:entered()
		Hotkeys.activeMode = modal
		Hotkeys.activeModeSpecs = specs

		if Hotkeys.keyListener then
			Hotkeys.keyListener:start()
		end

		if Hotkeys.menuBarItem then
			Hotkeys.menuBarItem:returnToMenuBar()
			Hotkeys.menuBarItem:setTitle(hs.styledtext(modalSpec.trigger[2], {
				font = { size = 18 },
			}):upper())
		end
	end

	---@diagnostic disable-next-line: duplicate-set-field
	function modal:exited()
		Hotkeys.activeMode = nil
		Hotkeys.activeModeSpecs = nil

		if Hotkeys.keyListener then
			Hotkeys.keyListener:stop()
		end

		if Hotkeys.menuBarItem then
			Hotkeys.menuBarItem:removeFromMenuBar()
		end

		hs.alert('Exited "' .. modalSpec.trigger[3] .. '" mode')
	end

	return modal
end

-- EventTap handler which blocks any key events not found in a mode's specs
---@param event hs.eventtap.event
local function keyListenerFn(event)
	-- Noop if no active mode specs found
	if not Hotkeys.activeModeSpecs then
		return
	end

	local eventMods = event:getFlags()
	local eventKey = hs.keycodes.map[event:getKeyCode()]
	eventKey = type(eventKey) == "string" and string.lower(eventKey)

	-- Allow key event if it's found in active mode hotkeys specs
	for _, spec in ipairs(Hotkeys.activeModeSpecs) do
		if eventKey == string.lower(spec[2]) and type(eventMods) == "table" and eventMods:containExactly(spec[1]) then
			return
		end
	end

	-- Otherwise block it
	return true
end

-- Allows exiting the currently active modal state
function Hotkeys:activeModeExit()
	if Hotkeys.activeMode then
		Hotkeys.activeMode:exit()
	end
end

---@class Hotkeys.Config
---@field modes? Hotkeys.ModalSpec[]
---@field specs? hs.hotkey.KeySpec[]

-- Bind hotkeys
---@param config Hotkeys.Config
function Hotkeys:bindHotkeys(config)
	-- Root hotkeys
	if config.specs then
		for _, spec in ipairs(config.specs) do
			hs.hotkey.bind(table.unpack(spec))
		end
	end

	-- Modal hotkeys
	if config.modes then
		if not self.menuBarItem then
			self.menuBarItem = hs.menubar.new(false, "hs.minusfive.hotkeys.mode")
		end

		if not self.keyListener then
			self.keyListener = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, keyListenerFn)
		end

		for _, mode in ipairs(config.modes) do
			configureModal(mode)
		end
	end
end

return Hotkeys
