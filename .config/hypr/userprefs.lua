-- Disable HyDE Alt-Tab notification popup.
hl.env("ALTAB_NOTIFY", "0")--------------------------------------------------

-- Workspace assignment
--------------------------------------------------

hl.workspace_rule({
    workspace = "1",
    monitor = "DP-3",
    default = true,
})

hl.workspace_rule({
    workspace = "2",
    monitor = "HDMI-A-1",
})

--------------------------------------------------
-- Input
--------------------------------------------------

hl.config({
    input = {
        repeat_delay = 250,
        repeat_rate = 40,

        kb_layout = "tr,tr",
        kb_variant = "alt,basic",
        kb_options = "grp:win_space_toggle",

        touchpad = {
            natural_scroll = true,
        },
    },

    cursor = {
        default_monitor = "DP-3",
        no_hardware_cursors = 1,

    },
})

--------------------------------------------------
-- Persistent gaming-style appearance
--------------------------------------------------

hl.config({
    animations = {
        enabled = false,
    },

    general = {
        gaps_in = 4,
        gaps_out = 4,
        border_size = 0,
        resize_on_border = false,
    },

    decoration = {
        rounding = 12,

        active_opacity = 1,
        inactive_opacity = 1,
        fullscreen_opacity = 1,

        blur = {
            enabled = false,
            xray = false,
        },

        shadow = {
            enabled = false,
        },
    },

    xwayland = {
        force_zero_scaling = true,
    },
})

--------------------------------------------------
-- Session autostart
--------------------------------------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("dex -a")

    hl.exec_cmd("/opt/localsend/localsend --hidden")

    hl.exec_cmd("/usr/bin/kdeconnectd")
    hl.exec_cmd("kdeconnect-indicator")

    hl.exec_cmd("brightness init")
    hl.exec_cmd("jellyfin-mpv-shim")

    -- Mark DP-3 primary for XWayland applications.
    -- Delay gives XWayland time to initialise.
    hl.exec_cmd("sleep 2 && xrandr --output DP-3 --primary")

    -- Preserved from old config. This may visibly open/toggle console.
    hl.exec_cmd("hyde-shell pypr toggle console")
end)
