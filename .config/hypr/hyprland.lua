-- Hyprland Lua config (migrated from hyprland.conf).
-- Refer to https://wiki.hypr.land/Configuring/Start/

------------------
---- MONITORS ----
------------------
-- Static rules applied immediately on connect, before kanshi runs.
-- These prevent auto-placement from causing transient overlaps.
hl.monitor({ output = "desc:Lenovo Group Limited 0x403A", mode = "1920x1200", position = "5440x1360", scale = 1 })
hl.monitor({ output = "desc:Dell Inc. DELL P2415Q P2PC251R0C2L", mode = "2560x1440", position = "4000x0", scale = 1, transform = 1 })
-- Fallback for everything else (home monitors, meeting room, unknown displays).
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

---------------------
---- MY PROGRAMS ----
---------------------
local terminal = "kitty"
local menu     = "rofi -show"
local dmenu    = "rofi -dmenu"
local browser  = "google-chrome-stable"
local lock     = "hyprlock"
local calc     = "wofi-calc"

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in  = 2,
        gaps_out = 1,
        border_size = 2,
        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 10,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a,
        },
        blur = {
            enabled = true,
            size = 8,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
    animations = {
        enabled = true,
    },
    dwindle = {
        preserve_split = true, -- You probably want this
        force_split = 2,
    },
    master = {
        new_status = "master",
    },
    misc = {
        force_default_wallpaper = 1,
        disable_hyprland_logo = false,
    },
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "compose:ralt",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
        touchpad = {
            natural_scroll = false,
        },
    },
})

-- Animation curves
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1} } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1.0} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1} } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-------------------------
---- GESTURES / DEVICES -
-------------------------
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 4, direction = "swipe",      action = "move" })
hl.gesture({ fingers = 2, direction = "pinch",      action = "fullscreen" })

hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })

---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"

hl.bind(mainMod .. " + RETURN",       hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Q",    hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E",    hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D",            hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + C",            hl.dsp.exec_cmd(calc))
hl.bind(mainMod .. " + P",            hl.dsp.window.pseudo())
hl.bind(mainMod .. " + S",            hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F",            hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + SHIFT + F",    hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + G",            hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + N",            hl.dsp.exec_cmd("~/.config/hypr/scripts/new_workspace_current_monitor.sh"))
hl.bind(mainMod .. " + M",            hl.dsp.window.move({ workspace = "emptyn", follow = false }))
hl.bind(mainMod .. " + SHIFT + M",    hl.dsp.window.move({ workspace = "emptyn" }))
hl.bind(mainMod .. " + TAB",          hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + SHIFT + TAB",  hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + B",            hl.dsp.focus({ workspace = "previous" }))
hl.bind(mainMod .. " + SHIFT + B",    hl.dsp.focus({ workspace = "previous_per_monitor" }))
hl.bind("CTRL + ALT + L",             hl.dsp.exec_cmd(lock))
hl.bind("Print",                      hl.dsp.exec_cmd("hyprshot -m region -z --clipboard"))
hl.bind(mainMod .. " + W",            hl.dsp.exec_cmd("hyprctl -j workspaces | jq '.[].id' | sort -n | " .. dmenu .. " | xargs hyprctl dispatch workspace"))
hl.bind(mainMod .. " + A",            hl.dsp.exec_cmd("kitty --hold opencode --agent chat --model 'opencode/gemini-3-flash'"))

-- Move focus (vim keys)
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

-- Move window
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))

-- Move workspace to a neighbouring monitor
hl.bind(mainMod .. " + CTRL + H", hl.dsp.workspace.move({ monitor = "l" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.workspace.move({ monitor = "r" }))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.workspace.move({ monitor = "u" }))
hl.bind(mainMod .. " + CTRL + J", hl.dsp.workspace.move({ monitor = "d" }))

-- Swap current monitor's workspace with the neighbouring monitor's workspace
hl.bind(mainMod .. " + CTRL + SHIFT + H", hl.dsp.workspace.swap_monitors({ monitor1 = "current", monitor2 = "l" }))
hl.bind(mainMod .. " + CTRL + SHIFT + L", hl.dsp.workspace.swap_monitors({ monitor1 = "current", monitor2 = "r" }))
hl.bind(mainMod .. " + CTRL + SHIFT + K", hl.dsp.workspace.swap_monitors({ monitor1 = "current", monitor2 = "u" }))
hl.bind(mainMod .. " + CTRL + SHIFT + J", hl.dsp.workspace.swap_monitors({ monitor1 = "current", monitor2 = "d" }))

-- Switch / move-to workspaces 1-10 (10 maps to key 0)
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + X", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle_magic_workspace.sh"))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"),      { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                 { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                 { locked = true, repeating = true })

-- Media (requires playerctl)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Misc
hl.bind(mainMod .. " + V",      hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle_float_focus.sh"))
hl.bind(mainMod .. " + Space",  hl.dsp.exec_cmd("dunstctl close-all"))
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallhaven-wallpaper.sh"))

-- Lid switch
hl.bind("switch:on:Lid Switch",  hl.dsp.exec_cmd([[hyprctl keyword monitor "eDP-1, disable"]]), { locked = true })
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("kanshictl reload"),                           { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
-- Ignore maximize requests from all apps.
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name = "fix-xwayland-drags",
    match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
    no_focus = true,
})

-- Pseudotile Gnome Calculator
hl.window_rule({
    name = "pseudo-gnome-calculator",
    match = { class = "org.gnome.Calculator" },
    pseudo = true,
})

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE")
    hl.exec_cmd("systemctl --user start kanshi.service")
    hl.exec_cmd("kanshictl reload")
    hl.exec_cmd("dunst")
    hl.exec_cmd("waybar")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("wl-paste -p -t text --watch cat >/dev/null")
    hl.exec_cmd("udiskie")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("~/.config/hypr/scripts/restore-wallpaper.sh")
end)

-- Original `exec = kanshictl reload` also ran on every config reload.
hl.on("config.reloaded", function()
    hl.exec_cmd("kanshictl reload")
end)
