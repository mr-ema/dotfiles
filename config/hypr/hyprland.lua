-- ============================================================
-- Hyprland configuration
-- ============================================================

local TERMINAL          = "kitty"
local FILE_MANAGER      = "nautilus"
local MENU              = "wofi --show drun"
local MAIN_MOD          = "ALT"


-- ============================================================
-- MONITORS
-- ============================================================

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})


-- ============================================================
-- AUTOSTART
-- ============================================================

hl.on("hyprland.start", function()
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")

    hl.exec_cmd("hyprctl dispatch workspace 1")
    hl.exec_cmd("firefox")

    hl.exec_cmd("hyprctl dispatch workspace 2")
    hl.exec_cmd(TERMINAL)

    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
end)


-- ============================================================
-- ENVIRONMENT VARIABLES
-- ============================================================

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


-- ============================================================
-- LOOK AND FEEL
-- ============================================================

hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 0,

        border_size = 2,

        ["col.active_border"] = {
            colors = {
                "rgba(33ccffee)",
                "rgba(00ff99ee)",
            },
            angle = 45,
        },

        ["col.inactive_border"] = "rgba(595959aa)",

        resize_on_border = true,
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding = 6,
        rounding_power = 1,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
    },

    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            natural_scroll = false,
        },
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },
})


-- ============================================================
-- ANIMATIONS
-- ============================================================

hl.config({ animations = { enabled = true, }, })

hl.curve("easeOutQuint", {
    type = "bezier",
    points = { { 0.23, 1 }, { 0.32, 1 }, },
})

hl.curve("easeInOutCubic", {
    type = "bezier",
    points = { { 0.65, 0.05 }, { 0.36, 1 }, },
})

hl.curve("linear", {
    type = "bezier",
    points = { { 0, 0 }, { 1, 1 }, },
})

hl.curve("almostLinear", {
    type = "bezier",
    points = { { 0.5, 0.5 }, { 0.75, 1 }, },
})

hl.curve("quick", {
    type = "bezier",
    points = { { 0.15, 0 }, { 0.1, 1 }, },
})


hl.animation({
    leaf = "global",
    enabled = true,
    speed = 8,
    bezier = "default",
})


-- ============================================================
-- INPUT
-- ============================================================

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})


-- ============================================================
-- KEYBINDS
-- ============================================================

-- Terminal
hl.bind(MAIN_MOD .. " + Q", hl.dsp.exec_cmd(TERMINAL))

-- Kill active window
hl.bind(MAIN_MOD .. " + C", hl.dsp.window.kill())

-- Exit Hyprland
hl.bind(MAIN_MOD .. " + M", hl.dsp.exit())

-- File manager
hl.bind(MAIN_MOD .. " + E", hl.dsp.exec_cmd(FILE_MANAGER))

-- Toggle floating
hl.bind(MAIN_MOD .. " + V", hl.dsp.window.float({ action = "toggle" }))

-- Menu
hl.bind(MAIN_MOD .. " + R", hl.dsp.exec_cmd(MENU))

-- Dwindle pseudotile
hl.bind(MAIN_MOD .. " + P", hl.dsp.window.pseudo({ action= "toggle"}))

-- Dwindle split
hl.bind(MAIN_MOD .. " + SHIFT + J", hl.dsp.layout("togglesplit"))

-- Fullscreen
hl.bind(MAIN_MOD .. " + F", hl.dsp.window.fullscreen())


-- Focus movement
hl.bind(MAIN_MOD .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(MAIN_MOD .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(MAIN_MOD .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(MAIN_MOD .. " + J", hl.dsp.focus({ direction = "down" }))


-- ============================================================
-- WORKSPACES
-- ============================================================

for i = 1, 9 do
    -- Switch to workspace
    hl.bind(
        MAIN_MOD .. " + " .. tostring(i),
        hl.dsp.focus({ workspace = tostring(i) })
    )

    -- Move focused window to workspace
    hl.bind(
        MAIN_MOD .. " + SHIFT + " .. tostring(i),
        hl.dsp.window.move({ workspace = tostring(i) })
    )
end

hl.bind(MAIN_MOD .. " + 0", hl.dsp.window.move({ workspace = "10" }))
hl.bind(MAIN_MOD .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "10"}))


-- ============================================================
-- MEDIA / BRIGHTNESS
-- ============================================================

hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd(
        "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
    ),
    { flags = { "e" } }
)

hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd(
        "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ),
    { flags = { "e" } }
)

hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd(
        "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ),
    { flags = { "e" } }
)

hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd(
        "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ),
    { flags = { "e" } }
)

hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd(
        "brightnessctl -e4 -n2 set 5%+"
    ),
    { flags = { "e" } }
)

hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd(
        "brightnessctl -e4 -n2 set 5%-"
    ),
    { flags = { "e" } }
)


-- ============================================================
-- MEDIA PLAYER
-- ============================================================

hl.bind(
    "XF86AudioNext",
    hl.dsp.exec_cmd("playerctl next"),
    { flags = { "l" } }
)

hl.bind(
    "XF86AudioPause",
    hl.dsp.exec_cmd("playerctl play-pause"),
    { flags = { "l" } }
)

hl.bind(
    "XF86AudioPlay",
    hl.dsp.exec_cmd("playerctl play-pause"),
    { flags = { "l" } }
)

hl.bind(
    "XF86AudioPrev",
    hl.dsp.exec_cmd("playerctl previous"),
    { flags = { "l" } }
)


-- ============================================================
-- WINDOW RULES
-- ============================================================

hl.window_rule({
    match = {
        class = ".*",
    },
    suppress_event = "maximize",
})

hl.window_rule({
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        fullscreen = false,
    },
    no_focus = true,
})
