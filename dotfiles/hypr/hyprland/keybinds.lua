local ipc = "qs -c noctalia-shell ipc call "
hl.bind("SUPER + SUPER_L", hl.dsp.exec_cmd(ipc .. "launcher toggle"))
hl.bind("SUPER + SUPER_R", hl.dsp.exec_cmd(ipc .. "launcher toggle"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume increase"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume decrease"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume muteOutput"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness increase"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness decrease"))
hl.bind("SUPER + O", hl.dsp.exec_cmd(ipc .. "controlCenter toggle"))
hl.bind("SUPER + I", hl.dsp.exec_cmd(ipc .. "settings toggle"))
hl.bind("SUPER + X", hl.dsp.exec_cmd(ipc .. "lockScreen lock"))
hl.bind("SUPER + V", hl.dsp.exec_cmd(ipc .. "launcher clipboard"))
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd(ipc .. "sessionMenu toggle"))
hl.bind("SUPER + Period", hl.dsp.exec_cmd(ipc .. "launcher emoji"))
hl.bind("SUPER + CTRL + R", hl.dsp.exec_cmd("killall qs; qs -c noctalia-shell; hyprctl reload"))
hl.bind(
	"SUPER + SHIFT + D",
	hl.dsp.exec_cmd(
		"~/.config/hypr/custom/scripts/emacs-launcher '(progn (select-frame-set-input-focus (selected-frame)) (dirvish))'"
	)
)
hl.bind("SUPER + SHIFT+ C", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind("Print", hl.dsp.exec_cmd(ipc .. "plugin:screen-shot-and-record screenshot"))
--#/# bind = SUPER + ←/↑/→/↓,, -- Focus in direction
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move" })
hl.bind("SUPER + mouse:274", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize" })
--#/# bind = SUPER + ←/↑/→/↓,, -- Focus in direction
for i = 1, 6 do
	local arrowkey = { "Left", "Right", "Up", "Down", "BracketLeft", "BracketRight" }
	local focusdir = { "l", "r", "u", "d", "l", "r" }
	hl.bind("SUPER + " .. arrowkey[i], hl.dsp.focus({ direction = focusdir[i] }))
end
--#/# bind = SUPER + SHIFT, ←/↑/→/↓,, -- Move in direction
for i = 1, 4 do
	local arrowkey = { "Left", "Right", "Up", "Down" }
	local focusdir = { "l", "r", "u", "d" }
	hl.bind("SUPER + SHIFT + " .. arrowkey[i], hl.dsp.window.move({ direction = focusdir[i] }))
end

hl.bind("ALT + F4", function()
	hl.exec_cmd('notify-send "Wrong close keybind" "SUPER+Q to close. Use Alt+F4 for Windows VMs" -a Hyprland')
end, { non_consuming = true })
hl.bind("SUPER + Q", hl.dsp.window.close(), { description = "Close" })
hl.bind("SUPER + SHIFT + ALT + Q", hl.dsp.exec_cmd("hyprctl kill"), { description = "Forcefully zap a window" })

--# Window split ratio
--#/# binde = SUPER, ;/',, -- Adjust split ratio
hl.bind("SUPER + Semicolon", hl.dsp.layout("splitratio -0.1"), { repeating = true })
hl.bind("SUPER + Apostrophe", hl.dsp.layout("splitratio +0.1"), { repeating = true })
--# Positioning mode
hl.bind("SUPER + ALT + Space", hl.dsp.window.float({ action = "toggle" }), { description = "Float/Tile" })
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ "fullscreen" }, { description = "Fullscreen" }))
hl.bind("SUPER + D", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(
	"SUPER + ALT + F",
	hl.dsp.window.fullscreen_state({ internal = 0, client = 3 }, { description = "Fullscreen spoof" })
)
hl.bind("SUPER + P", hl.dsp.window.pin(), { description = "Pin" })

--#/# bind = SUPER+ALT, Hash,, -- Send to workspace -- (1, 2, 3,...)
--# We use raw keycodes because some keyboard layouts register number keys as different chars. The codes can be verified with `wev`
for i = 1, 10 do
	local numberkey = { 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }
	hl.bind("SUPER + ALT + code:" .. numberkey[i], hl.dsp.window.move({ workspace = i, follow = false }))
end
--# keypad numbers
for i = 1, 10 do
	local numpadkey = { 87, 88, 89, 83, 84, 85, 79, 80, 81, 90 }
	hl.bind("SUPER + ALT + code:" .. numpadkey[i], hl.dsp.window.move({ workspace = i, follow = false }))
end

--# #/# bind = SUPER+SHIFT, Scroll ↑/↓,, -- Send to workspace left/right
for i = 1, 4 do
	local key = { "SUPER + SHIFT + mouse_", "SUPER + ALT + mouse_" }
	local keycombos = { key[1] .. "down", key[1] .. "up", key[2] .. "down", key[2] .. "up" }
	local prefix = { "r-", "r+", "-", "+" }
	hl.bind(keycombos[i], hl.dsp.window.move({ workspace = prefix[i] .. "1" }))
end

--#/# bind = SUPER+SHIFT, Page_↑/↓,, -- Send to workspace left/right
for i = 1, 6 do
	local key = { "SUPER + ALT + Page_", "SUPER + SHIFT + Page_", "CTRL + SUPER + SHIFT + " }
	local keycombos =
		{ key[1] .. "down", key[1] .. "up", key[2] .. "down", key[2] .. "up", key[3] .. "Right", key[3] .. "Left" }
	local prefix = { "+", "-", "r+", "r-", "r+", "r-" }
	hl.bind(keycombos[i], hl.dsp.window.move({ workspace = prefix[i] .. "1" })) -- # [hidden]
end

hl.bind(
	"SUPER + ALT + S",
	hl.dsp.window.move({ workspace = "special:special", follow = false, description = "Send to scratchpad" })
)
hl.bind("CTRL + SUPER + S", hl.dsp.workspace.toggle_special("special"))

--##! Workspace
--# Switching
--#/# bind = SUPER, Hash,, -- Focus workspace -- (1, 2, 3,...)
--# We use raw keycodes because some keyboard layouts register number keys as different chars. The codes can be verified with `wev`
for i = 1, 10 do
	local numberkey = { 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }
	hl.bind("SUPER + code:" .. numberkey[i], hl.dsp.focus({ workspace = i }))
end
--# keypad numbers
for i = 1, 10 do
	local numpadkey = { 87, 88, 89, 83, 84, 85, 79, 80, 81, 90 }
	hl.bind("SUPER + code:" .. numpadkey[i], hl.dsp.focus({ workspace = i }))
end

--#/# bind = CTRL+SUPER, ←/→,, -- Focus left/right
--#/# bind = CTRL+SUPER+ALT, ←/→,, -- # [hidden] Focus busy left/right
for i = 1, 4 do
	local key = { "CTRL + SUPER + ", "CTRL + SUPER + ALT + " }
	local keycombos = { key[1] .. "Right", key[1] .. "Left", key[2] .. "Right", key[2] .. "Left" }
	local prefix = { "r+", "r-", "m+", "m-" }
	hl.bind(keycombos[i], hl.dsp.focus({ workspace = prefix[i] .. "1" }))
end
--#/# bind = SUPER, Page_↑/↓,, -- Focus left/right
for i = 1, 4 do
	local key = { "SUPER + Page_Down", "SUPER + Page_Up" }
	local keycombos = { key[1], key[2], "CTRL + " .. key[1], "CTRL + " .. key[2] }
	local prefix = { "r+", "r-", "r+", "r-" }
	hl.bind(keycombos[i], hl.dsp.focus({ workspace = prefix[i] .. "1" }))
end
--#/# bind = SUPER, Scroll ↑/↓,, -- Focus left/right
for i = 1, 4 do
	local key = { "SUPER + mouse_up", "SUPER + mouse_down" }
	local keycombos = { key[1], key[2], "CTRL + " .. key[1], "CTRL + " .. key[2] }
	local prefix = { "+", "-", "r+", "r-" }
	hl.bind(keycombos[i], hl.dsp.focus({ workspace = prefix[i] .. "1" }))
end
--## Special
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("special"), { description = "Toggle scratchpad" })
hl.bind("SUPER + mouse:275", hl.dsp.workspace.toggle_special("special"))
for i = 1, 4 do
	local key = { "BracketLeft", "BracketRight", "Up", "Down" }
	local prefix = { "-1", "+1", "r-5", "r+5" }
	hl.bind("CTRL + SUPER + " .. key[i], hl.dsp.focus({ workspace = prefix[i] }))
end

local mediaNextCommand =
	'playerctl next || playerctl position `bc <<< "100 * $(playerctl metadata mpris:length) / 1000000 / 100"`'
hl.bind("SUPER + SHIFT + N", hl.dsp.exec_cmd(mediaNextCommand), { locked = true, description = "Next track" })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(mediaNextCommand), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("SUPER + SHIFT + ALT + mouse:275", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("SUPER + SHIFT + ALT + mouse:276", hl.dsp.exec_cmd(mediaNextCommand))
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd("playerctl previous"), { locked = true, description = "Previous track" })
hl.bind(
	"SUPER + SHIFT + P",
	hl.dsp.exec_cmd("playerctl play-pause"),
	{ locked = true, description = "Play/pause media" }
)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("SUPER + W", hl.dsp.exec_cmd("firefox"), { description = "Browser" })
hl.bind(
	"SUPER + SHIFT + M",
	hl.dsp.exec_cmd(
		"~/.config/hypr/custom/scripts/emacs-launcher '(progn (select-frame-set-input-focus (selected-frame)) (emms) (emms-playlist-mode-go))'"
	)
)
hl.bind("SUPER + Return", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + Space", hl.dsp.exec_cmd("emacsclient -e '(universal-launcher-popup)'"))
-- Trigger when the switch is toggled.
