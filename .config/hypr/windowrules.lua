-- User window and layer rules

local function window_rule(name, match, effects)
    effects.name = name
    effects.match = match
    hl.window_rule(effects)
end

local function float_class(name, class)
    window_rule(name, { class = class }, { float = true })
end

local function float_title(name, title)
    window_rule(name, { title = title }, { float = true })
end

local function blur_layer(name, namespace, ignore_alpha)
    local effects = {
        name = name,
        match = { namespace = namespace },
        blur = true,
    }

    if ignore_alpha ~= nil then
        effects.ignore_alpha = ignore_alpha
    end

    hl.layer_rule(effects)
end

--------------------------------------------------
-- Idle inhibition
--------------------------------------------------

window_rule(
    "idle-inhibit-media-players",
    {
        class = "^(.*celluloid.*)$|^(.*mpv.*)$|^(.*vlc.*)$",
    },
    {
        idle_inhibit = "fullscreen",
    }
)

window_rule(
    "idle-inhibit-spotify",
    {
        class = "^(.*[Ss]potify.*)$",
    },
    {
        idle_inhibit = "fullscreen",
    }
)

window_rule(
    "idle-inhibit-browsers",
    {
        class = "^(.*LibreWolf.*)$"
            .. "|^(.*floorp.*)$"
            .. "|^(.*brave-browser.*)$"
            .. "|^(.*firefox.*)$"
            .. "|^(.*chromium.*)$"
            .. "|^(.*[Hh]elium.*)$"
            .. "|^(.*zen.*)$"
            .. "|^(.*vivaldi.*)$",
    },
    {
        idle_inhibit = "fullscreen",
    }
)

--------------------------------------------------
-- Opacity
--------------------------------------------------

window_rule(
    "default-window-opacity",
    {
        class = ".*",
    },
    {
        opacity = "1.00 override 1.00 override",
    }
)

window_rule(
    "ghostty-opacity",
    {
        class = ".*ghostty.*",
    },
    {
        opacity = "0.90 override 0.90 override",
    }
)

window_rule(
    "kitty-opacity",
    {
        class = ".*kitty.*",
    },
    {
        opacity = "0.90 override 0.90 override",
    }
)

--------------------------------------------------
-- Dolphin dialogs
--------------------------------------------------

window_rule(
    "dolphin-progress-dialog",
    {
        class = "^(org.kde.dolphin)$",
        title = "^(Progress Dialog — Dolphin)$",
    },
    {
        float = true,
    }
)

window_rule(
    "dolphin-copy-dialog",
    {
        class = "^(org.kde.dolphin)$",
        title = "^(Copying — Dolphin)$",
    },
    {
        float = true,
    }
)

--------------------------------------------------
-- Browser windows
--------------------------------------------------

float_title(
    "firefox-about-dialog",
    "^(About Mozilla Firefox)$"
)

float_title(
    "browser-devtools",
    "^(DevTools)$"
)

window_rule(
    "firefox-library",
    {
        class = "^(firefox)$",
        title = "^(Library)$",
    },
    {
        float = true,
    }
)

window_rule(
    "zen-library",
    {
        class = "^(zen)$",
        title = "^(Library)$",
    },
    {
        float = true,
    }
)

--------------------------------------------------
-- Picture-in-Picture
--------------------------------------------------

window_rule(
    "picture-in-picture",
    {
        title = [[^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$]],
    },
    {
        tag = "+picture-in-picture",
        float = true,
        pin = true,
        size = {
            "monitor_w * 0.25",
            "monitor_h * 0.25",
        },
    }
)

--------------------------------------------------
-- Terminal utilities
--------------------------------------------------

window_rule(
    "kitty-top",
    {
        class = "^(kitty)$",
        title = "^(top)$",
    },
    {
        float = true,
    }
)

window_rule(
    "kitty-btop",
    {
        class = "^(kitty)$",
        title = "^(btop)$",
    },
    {
        float = true,
    }
)

window_rule(
    "kitty-htop",
    {
        class = "^(kitty)$",
        title = "^(htop)$",
    },
    {
        float = true,
    }
)

--------------------------------------------------
-- Floating applications
--------------------------------------------------

local floating_classes = {
    { "vlc", "^(vlc)$" },
    { "kvantum-manager", "^(kvantummanager)$" },
    { "qt5ct", "^(qt5ct)$" },
    { "qt6ct", "^(qt6ct)$" },
    { "nwg-look", "^(nwg-look)$" },
    { "ark", "^(org.kde.ark)$" },
    { "pavucontrol", "^(org.pulseaudio.pavucontrol)$" },
    { "blueman-manager", "^(blueman-manager)$" },
    { "nm-applet", "^(nm-applet)$" },
    { "nm-connection-editor", "^(nm-connection-editor)$" },
    {
        "kde-polkit-agent",
        "^(org.kde.polkit-kde-authentication-agent-1)$",
    },

    { "signal", "^(Signal)$" },
    { "clapper", "^(com.github.rafostar.Clapper)$" },
    { "warp", "^(app.drey.Warp)$" },
    { "protonup-qt", "^(net.davidotek.pupgui2)$" },
    { "yad", "^(yad)$" },
    { "eog", "^(eog)$" },
    { "planify", "^(io.github.alainm23.planify)$" },
    { "upscaler", "^(io.gitlab.theevilskeleton.Upscaler)$" },
    { "video-downloader", "^(com.github.unrud.VideoDownloader)$" },
    { "impression", "^(io.gitlab.adhami3310.Impression)$" },
    { "mission-center", "^(io.missioncenter.MissionCenter)$" },
}

for _, entry in ipairs(floating_classes) do
    float_class(entry[1], entry[2])
end

--------------------------------------------------
-- Common dialogs
--------------------------------------------------

local floating_titles = {
    { "dialog-open", "^(Open)$" },
    { "dialog-choose-files", "^(Choose Files)$" },
    { "dialog-save-as", "^(Save As)$" },
    { "dialog-confirm-replace", "^(Confirm to replace files)$" },
    { "dialog-file-operation", "^(File Operation Progress)$" },
}

for _, entry in ipairs(floating_titles) do
    float_title(entry[1], entry[2])
end

--------------------------------------------------
-- Custom rules
--------------------------------------------------

window_rule(
    "chromium-extension-popup",
    {
        initial_class =
            "^(chrome-nngceckbapebfimnlniiiahkandclblb-Default)$",
    },
    {
        float = true,
        size = { 500, 750 },
        center = false,
    }
)

float_class(
    "xdg-desktop-portal-gtk",
    "^(xdg-desktop-portal-gtk)$"
)

float_class(
    "whatsie",
    "^(com.ktechpit.whatsie)$"
)

-- Float Steam auxiliary windows first.
float_class(
    "steam-windows",
    "^(steam)$"
)

-- Main Steam window remains tiled.
-- Later rule overrides generic Steam floating rule.
window_rule(
    "steam-main-window",
    {
        class = "^(steam)$",
        title = "^(Steam)$",
    },
    {
        tile = true,
    }
)

--------------------------------------------------
-- Layer rules
--------------------------------------------------

blur_layer(
    "blur-rofi",
    "^(rofi)$",
    0
)

blur_layer(
    "blur-notifications",
    "^(notifications)$",
    0
)

blur_layer(
    "blur-swaync-notification-window",
    "^(swaync-notification-window)$",
    0
)

blur_layer(
    "blur-swaync-control-center",
    "^(swaync-control-center)$",
    0
)

blur_layer(
    "blur-logout-dialog",
    "^(logout_dialog)$",
    nil
)
--------------------------------------------------
-- Capture overlays
--------------------------------------------------

hl.layer_rule({
    name = "user-no-animation-hyprpicker",
    match = {
        namespace = "^hyprpicker$",
    },
    no_anim = true,
})
