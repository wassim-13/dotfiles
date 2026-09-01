---------------------
---- MY PROGRAMS ----
---------------------

local terminal = "kitty"
local browser = "zen-browser"
local fileManager = "nautilus"
local menu = "wofi"
local document_viewer = "zathura"
local editor = "kitty --app-id nvim-gui nvim"

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

local scripts = HYPR_ROOT .. "/scripts"

hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(scripts .. "/test.sh"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(document_viewer))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))

hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(scripts .. "/toggleIdle.sh"))

hl.bind(mainMod .. " + K", hl.dsp.exec_cmd("hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(editor))

hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(scripts .. "/screenshot.sh"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(scripts .. "/screenrec.sh"))
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd(scripts .. "/screenshot.sh" .. " w"))

hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + X", hl.dsp.window.kill())

-------------------------------------------
------------- Brightness & Sound keys -----
-------------------------------------------

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -n1 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -n1 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

require("conf.bind.move_window")
require("conf.bind.extra_binds")
