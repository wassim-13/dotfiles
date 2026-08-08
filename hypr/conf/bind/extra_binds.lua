local mainMod = "SUPER"

hl.bind(mainMod .. " + code:68", hl.dsp.exec_cmd("brightnessctl set -n 15%-"))
hl.bind(mainMod .. " + code:69", hl.dsp.exec_cmd("brightnessctl set -n 15%+"))
