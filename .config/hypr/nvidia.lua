-- Current Hyprland NVIDIA environment variables
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

hl.config({
    cursor = {
        -- Current option uses integer:
        -- 0 = hardware cursor
        -- 1 = disable hardware cursor
        -- 2 = automatic
        no_hardware_cursors = 1,
    },
})

-- Enable only when libva-nvidia-driver is installed and VA-API needs it:
-- hl.env("NVD_BACKEND", "direct")
