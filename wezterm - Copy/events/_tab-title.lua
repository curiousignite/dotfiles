-- Inspired by https://github.com/wez/wezterm/discussions/628#discussioncomment-1874614

local wezterm           = require('wezterm')

local M                 = {}
local SOLID_LEFT_ARROW  = utf8.char(0xe0ba)
local SOLID_LEFT_MOST   = utf8.char(0x2588)
local SOLID_RIGHT_ARROW = utf8.char(0xe0bc)
local ADMIN_ICON        = utf8.char(0xf49c)
local CMD_ICON          = utf8.char(0xe62a)
local NU_ICON           = utf8.char(0xe7a8)
local PS_ICON           = utf8.char(0xe70f)
local ELV_ICON          = utf8.char(0xfc6f)
local WSL_ICON          = utf8.char(0xf83c)
local YORI_ICON         = utf8.char(0xf1d4)
local NYA_ICON          = utf8.char(0xf61a)
local VIM_ICON          = utf8.char(0xe62b)
local PAGER_ICON        = utf8.char(0xf718)
local FUZZY_ICON        = utf8.char(0xf0b0)
local HOURGLASS_ICON    = utf8.char(0xf252)
local SUNGLASS_ICON     = utf8.char(0xf9df)
local PYTHON_ICON       = utf8.char(0xf820)
local NODE_ICON         = utf8.char(0xe74e)
local DENO_ICON         = utf8.char(0xe628)
local LAMBDA_ICON       = utf8.char(0xfb26)
local SUP_IDX           = { "¹", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹", "¹⁰",
    "¹¹", "¹²", "¹³", "¹⁴", "¹⁵", "¹⁶", "¹⁷", "¹⁸", "¹⁹", "²⁰" }
local SUB_IDX           = { "₁", "₂", "₃", "₄", "₅", "₆", "₇", "₈", "₉", "₁₀",
    "₁₁", "₁₂", "₁₃", "₁₄", "₁₅", "₁₆", "₁₇", "₁₈", "₁₉", "₂₀" }
local bg
local fg
-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s)
    return string.gsub(s, "(.*[/\\])(.*)", "%2")
end


M.setup = function()
    wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
        local title_with_icon
        local edge_background = "#121212"
        local dim_foreground = "#3A3A3A"

        local process_name = tab.active_pane.foreground_process_name
        local pane_title = tab.active_pane.title
        local exec_name = basename(process_name):gsub("%.exe$", "")
        local colors = {
            default   = { bg = '#45475a', fg = '#1c1b19' },
            is_active = { bg = '##cba6f7cba6f7', fg = '#11111b' },
            hover     = { bg = '#eba0ac', fg = '#1c1b19' },
        }

        if tab.is_active then
            bg = colors.is_active.bg
            fg = colors.is_active.fg
        elseif hover then
            bg = colors.hover.bg
            fg = colors.hover.fg
        else
            bg = colors.default
            fg = colors.default
        end

        local edge_foreground = bg

        if exec_name == "nu" then
            title_with_icon = NU_ICON .. " NuShell"
        elseif exec_name == "pwsh" then
            title_with_icon = PS_ICON .. " PS"
        elseif exec_name == "cmd" then
            title_with_icon = CMD_ICON .. " CMD"
        elseif exec_name == "elvish" then
            title_with_icon = ELV_ICON .. " Elvish"
        elseif exec_name == "wsl" or exec_name == "wslhost" then
            title_with_icon = WSL_ICON .. " WSL"
        elseif exec_name == "nyagos" then
            title_with_icon = NYA_ICON .. " " .. pane_title:gsub(".*: (.+) %- .+", "%1")
        elseif exec_name == "yori" then
            title_with_icon = YORI_ICON .. " " .. pane_title:gsub(" %- Yori", "")
        elseif exec_name == "nvim" then
            title_with_icon = VIM_ICON .. pane_title:gsub("^(%S+)%s+(%d+/%d+) %- nvim", " %2 %1")
        elseif exec_name == "lua-language-server" then
            title_with_icon = VIM_ICON .. " NeoVim"
        elseif exec_name == "bat" or exec_name == "less" or exec_name == "moar" then
            title_with_icon = PAGER_ICON .. " " .. exec_name:upper()
        elseif exec_name == "fzf" or exec_name == "hs" or exec_name == "peco" then
            title_with_icon = FUZZY_ICON .. " " .. exec_name:upper()
        elseif exec_name == "btm" or exec_name == "ntop" then
            title_with_icon = SUNGLASS_ICON .. " " .. exec_name:upper()
        elseif exec_name == "python" or exec_name == "hiss" then
            title_with_icon = PYTHON_ICON .. " " .. exec_name
        elseif exec_name == "node" then
            title_with_icon = NODE_ICON .. " " .. exec_name:upper()
        elseif exec_name == "deno" then
            title_with_icon = DENO_ICON .. " " .. exec_name:upper()
        elseif exec_name == "bb" or exec_name == "cmd-clj" or exec_name == "janet" or exec_name == "hy" then
            title_with_icon = LAMBDA_ICON .. " " .. exec_name:gsub("bb", "Babashka"):gsub("cmd%-clj", "Clojure")
        else
            title_with_icon = HOURGLASS_ICON .. " " .. exec_name
        end
        if pane_title:match("^Administrator: ") then
            title_with_icon = title_with_icon .. " " .. ADMIN_ICON
        end
        local left_arrow = SOLID_LEFT_ARROW
        if tab.tab_index == 0 then
            left_arrow = SOLID_LEFT_MOST
        end
        local id = SUB_IDX[tab.tab_index + 1]
        local pid = SUP_IDX[tab.active_pane.pane_index + 1]
        local title = " " .. wezterm.truncate_right(title_with_icon, max_width - 6) .. " "

        return {
            { Attribute = { Intensity = "Bold" } },
            { Background = { Color = edge_background } },
            { Foreground = { Color = edge_foreground } },
            { Text = left_arrow },
            { Background = { Color = bg } },
            { Foreground = { Color = fg } },
            { Text = id },
            { Text = title },
            { Foreground = { Color = dim_foreground } },
            { Text = pid },
            { Background = { Color = edge_background } },
            { Foreground = { Color = edge_foreground } },
            { Text = SOLID_RIGHT_ARROW },
            { Attribute = { Intensity = "Normal" } },
        }
    end)
end

return M
