local mainMod = "SUPER"

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

for i = 10, 19 do
	local key = i
	hl.bind(mainMod .. " + code:" .. key, hl.dsp.focus({ workspace = 1 + i % 10 }))
	hl.bind(mainMod .. " + SHIFT + code:" .. key, hl.dsp.window.move({ workspace = 1 + i % 10 }))
end

hl.bind(mainMod .. " + code:35", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + code:35", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("SUPER + Tab", function()
	hl.dispatch(hl.dsp.window.cycle_next())
	hl.dispatch(hl.dsp.window.bring_to_top())
end)

hl.bind("SUPER + CTRL + right", hl.dsp.window.move({ workspace = "next" }))
hl.bind("SUPER + CTRL + left", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind("SUPER + CTRL + up", hl.dsp.window.move({ workspace = "prev" }))

hl.bind("SUPER + ALT + right", hl.dsp.focus({ workspace = "next" }))
hl.bind("SUPER + ALT + left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + ALT + up", hl.dsp.focus({ workspace = "prev" }))

hl.bind("SUPER + code:86", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + code:82", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + code:82", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + code:86", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

local function smart_nav(direction, coord)
	return function()
		local w = hl.get_active_window()

		if w ~= nil then
			if w.floating then
				hl.dispatch(hl.dsp.window.move({ x = coord.x, y = coord.y, relative = true }))
			else
				hl.dispatch(hl.dsp.window.swap({ direction = direction }))
			end
		end
	end
end

hl.bind("SUPER + SHIFT + Left", smart_nav("l", { x = -20, y = 0 }), { repeating = true })
hl.bind("SUPER + SHIFT + Right", smart_nav("r", { x = 20, y = 0 }), { repeating = true })
hl.bind("SUPER + SHIFT + Up", smart_nav("u", { x = 0, y = -20 }), { repeating = true })
hl.bind("SUPER + SHIFT + Down", smart_nav("d", { x = 0, y = 20 }), { repeating = true })

require("conf.bind.d_move")
