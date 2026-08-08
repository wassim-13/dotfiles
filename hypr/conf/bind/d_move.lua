local function d_func()
	local START_STEP = 10
	local MAX_STEP = 80

	local move_states = {
		RIGHT = START_STEP,
		LEFT = START_STEP,
		DOWN = START_STEP,
		UP = START_STEP,
	}

	local function bind_exponential_move(key, dir_x, dir_y, state_key)
		hl.bind("SUPER + " .. key, function()
			local current_step = move_states[state_key]

			local move_x = current_step * dir_x
			local move_y = current_step * dir_y

			hl.dispatch(hl.dsp.window.move({ x = move_x, y = move_y, relative = true }))

			move_states[state_key] = math.min(current_step * 1.2, MAX_STEP)
		end, { repeating = true })

		hl.bind("SUPER + " .. key, function()
			move_states[state_key] = START_STEP
		end, { release = true })
	end

	bind_exponential_move("RIGHT", 1, 0, "RIGHT")
	bind_exponential_move("LEFT", -1, 0, "LEFT")
	bind_exponential_move("DOWN", 0, 1, "DOWN")
	bind_exponential_move("UP", 0, -1, "UP")
end

hl.bind("ALT + R", hl.dsp.submap("r_move"))

hl.define_submap("r_move", function()
	hl.bind("right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
	hl.bind("left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
	hl.bind("up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
	hl.bind("down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

	d_func()

	hl.bind("ALT + R", hl.dsp.submap("resize"))

	hl.bind("escape", hl.dsp.submap("reset"))
end)
