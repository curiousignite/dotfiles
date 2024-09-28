local wezterm                 = require 'wezterm';
local nf                      = wezterm.nerdfonts
local M                       = {}

local SOLID_LEFT_ARROW        = utf8.char(0xe0ba)
local SOLID_LEFT_MOST         = utf8.char(0x2588)
local SOLID_RIGHT_ARROW       = utf8.char(0xe0bc)

local GLYPH_SEMI_CIRCLE_LEFT  = utf8.char(0xe0b6)
local GLYPH_SEMI_CIRCLE_RIGHT = utf8.char(0xe0b4)


local ADMIN_ICON     = utf8.char(0xed25)

local CMD_ICON       = utf8.char(0xe62a)
local NU_ICON        = utf8.char(0xe7a8)
local PS_ICON        = utf8.char(0xe70f)

local ELV_ICON       = utf8.char(0xef4e)
local WSL_ICON       = utf8.char(0xf17c)
local YORI_ICON      = utf8.char(0xf1d4)
local NYA_ICON       = utf8.char(0xf011b)

local VIM_ICON       = utf8.char(0xf36f)
local PAGER_ICON     = utf8.char(0xf15c)
local FUZZY_ICON     = utf8.char(0xf0b0)
local HOURGLASS_ICON = utf8.char(0xf252)
local SUNGLASS_ICON  = utf8.char(0xf04e0)

local PYTHON_ICON    = utf8.char(0xe73c)
local NODE_ICON      = utf8.char(0xe74e)
local DENO_ICON      = utf8.char(0xe628)
local LAMBDA_ICON    = utf8.char(0xf0627)
local GO_ICON        = utf8.char(0xe627)
local GIT_ICON       = utf8.char(0xe65d)
local C_ICON         = utf8.char(0xe61e)



local SUP_IDX = { "¹", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹", "¹⁰",
  "¹¹", "¹²", "¹³", "¹⁴", "¹⁵", "¹⁶", "¹⁷", "¹⁸", "¹⁹", "²⁰" }
local SUB_IDX = { "₁", "₂", "₃", "₄", "₅", "₆", "₇", "₈", "₉", "₁₀",
  "₁₁", "₁₂", "₁₃", "₁₄", "₁₅", "₁₆", "₁₇", "₁₈", "₁₉", "₂₀" }

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end
M.setup = function()
  wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local edge_background = "#121212"
    local background = "#4E4E4E"
    local foreground = "#1C1B19"
    local dim_foreground = "#3A3A3A"

    if tab.is_active then
      background = "#cba6f7"
      foreground = "#1C1B19"
    elseif hover then
      background = "#eba0ac"
      foreground = "#1C1B19"
    end

    local edge_foreground = background
    local process_name = tab.active_pane.foreground_process_name
    local pane_title = tab.active_pane.title
    local exec_name = basename(process_name):gsub("%.exe$", "")
    local title_with_icon

    if exec_name == "nu" then
      title_with_icon = NU_ICON .. " NuShell"
    elseif exec_name == "pwsh" or exec_name == "oh-my-posh" then
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
      -- title_with_icon = VIM_ICON .. pane_title:gsub("^(%S+)%s+(%d+/%d+) %- nvim", " %2 %1")
      title_with_icon = VIM_ICON .. " Neovim"
    elseif exec_name == "lua-language-server" then
      title_with_icon = VIM_ICON .. " Neovim"
    elseif exec_name == "bat" or exec_name == "less" or exec_name == "moar" then
      title_with_icon = PAGER_ICON .. " " .. exec_name:upper()
    elseif exec_name == "fzf" or exec_name == "hs" or exec_name == "peco" then
      title_with_icon = FUZZY_ICON .. " " .. exec_name:upper()
    elseif exec_name == "btm" or exec_name == "ntop" then
      title_with_icon = SUNGLASS_ICON .. " " .. exec_name:upper()
    elseif exec_name == "python" or exec_name == "hiss" then
      title_with_icon = PYTHON_ICON .. " " .. exec_name
    elseif exec_name == "gopls" then
      title_with_icon = GO_ICON .. " " .. 'Go'
    elseif exec_name == "clangd" then
      title_with_icon = C_ICON .. " " .. 'Clang'
    elseif exec_name == "git" then
      title_with_icon = GIT_ICON .. " " .. 'git'
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
    local left_arrow = GLYPH_SEMI_CIRCLE_LEFT
    if tab.tab_index == 0 then
      left_arrow = GLYPH_SEMI_CIRCLE_LEFT
    end
    local id = SUB_IDX[tab.tab_index + 1]
    local pid = SUP_IDX[tab.active_pane.pane_index + 1]
    local title = " " .. wezterm.truncate_right(title_with_icon, max_width - 6) .. " "

    return {
      { Attribute = { Intensity = "Bold" } },
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = left_arrow },
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = id },
      { Text = title },
      { Foreground = { Color = dim_foreground } },
      { Text = pid },
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = GLYPH_SEMI_CIRCLE_RIGHT
      },
      { Attribute = { Intensity = "Normal" } },
    }
  end)
end

return M
