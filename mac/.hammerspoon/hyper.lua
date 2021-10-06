-- HYPER
--
-- Hyper is a hyper shortcut modal.
--
-- Feel free to modify... I use karabiner-elements.app on my laptop and QMK on
-- my mech keyboards to bind a single key to `F19`, which fires all this
-- Hammerspoon-powered OSX automation.
--
-- I chiefly use it to launch applications quickly from a single press,
-- although I also use it to create "universal" local bindings inspired by
-- Shawn Blanc's OopsieThings.
-- https://thesweetsetup.com/oopsiethings-applescript-for-things-on-mac/

local hyper = hs.hotkey.modal.new({}, nil)

local hyper_toggle = false

hyper.pressed  = function()
	hyper_toggle = false
	hyper:enter()
	hs.timer.delayed.new(0.5, function ()
		hyper_toggle = true
	end):start()
end
hyper.released = function()
	if not hyper_toggle then
		hs.eventtap.keyStrokes(" ")
		-- hs.eventtap.keyStroke({}, 'space')
	end
	hyper:exit()
end

hyper.launchOrHide = function(app_config)
	hyper_toggle = true
	local app = hs.application.get(app_config.bundleID)
	if app:isFrontmost() and #app:visibleWindows() > 0 then
		app:hide()
	elseif app:isRunning() then
		hs.application.launchOrFocusByBundleID(app_config.bundleID)
	end
end

-- Expects a configuration table with an applications key that has the
-- following form:
-- config_table.applications = {
--   ['com.culturedcode.ThingsMac'] = {
--     bundleID = 'com.culturedcode.ThingsMac',
--     hyper_key = 't',
--     tags = {'planning', 'review'},
--     local_bindings = {',', '.'}
--   },
-- }
hyper.start = function(config_table)
	-- Set the key you want to be HYPER to F19 in karabiner or keyboard
	-- Bind the Hyper key to the hammerspoon modal
	hs.hotkey.bind({}, config_table.hyper_key, hyper.pressed, hyper.released)
	-- Use the hyper key with the application config to use the `hyper_key`
	hs.fnutils.map(config_table.applications, function(app)
		-- Apps that I want to jump to
		if app.hyper_key then
			hyper:bind({}, app.hyper_key, function() hyper.launchOrHide(app); end)
		end

		-- I use hyper to power some shortcuts in different apps If the app is closed
		-- and I press the shortcut, open the app and send the shortcut, otherwise
		-- just send the shortcut.
		-- if app.local_bindings then
		--   hs.fnutils.map(app.local_bindings, function(key)
		--     hyper:bind({}, key, nil, function()
		--       if hs.application.get(app.bundleID) then
		--         hs.eventtap.keyStroke({'cmd','alt','shift','ctrl'}, key)
		--       else
		--         hyper.launch(app)
		--         hs.timer.waitWhile(
		--           function()
		--             return not hs.application.get(app.bundleID):isFrontmost()
		--           end,
		--           function()
		--             hs.eventtap.keyStroke({'cmd','alt','shift','ctrl'}, key)
		--           end
		--         )
		--       end
		--     end)
		--   end)
		-- end
	end)
end

hyper.bindKey = function(x, key_modifiers, key, to_modifiers, to)
	hs.alert.show(#key_modifiers)
	hs.alert.show(key)
	hyper:bind(key_modifiers or {}, key, function()
		hyper_toggle = true
		hs.eventtap.keyStroke(to_modifiers or {}, to)
	end)
end

return hyper