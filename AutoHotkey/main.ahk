#include %A_ScriptDir%\AutoCorrect.ahk
#include %A_ScriptDir%\Icons.ahk


+"::SendInput, {U+007E} ;Sending tilde(~) on Shift+"
^!r::Reload             ; Assign Ctrl+Alt+r as a hotkey to restart the script
^!w::
    Run wezterm-gui.exe
return
