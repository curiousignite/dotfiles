$fasthfetch_config = @'
--logo C:\Users\berke\.config\fastfetch\logos\catppuccin-windows
--logo-type "file"
--logo-color-1 green
--logo-color-2 yellow
--logo-color-3 red
--logo-color-4 magenta
--logo-color-5 blue
--os-key " \e[32m ├─ "
--packages-key " \e[32m ├─ "
'@ -split [environment]::NewLine

fastfetch $fasthfetch_config
