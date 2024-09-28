#include %A_ScriptDir%\AutoCorrect.ahk
#include %A_ScriptDir%\Icons.ahk


^!r::Reload             ; Assign Ctrl+Alt+r as a hotkey to restart the script
+"::SendInput, {U+007E} ;Sending tilde(~) on Shift+"
^!w::
    Run wezterm-gui.exe
return
