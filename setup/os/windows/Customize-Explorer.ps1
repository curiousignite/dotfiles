using module RegistryEntry

#
# ░▀█▀░█░█░█▀▀░█▄█░▀█▀░█▀█░█▀▀
# ░░█░░█▀█░█▀▀░█░█░░█░░█░█░█░█
# ░░▀░░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀
#
##
# Update Windows Taskbar
##
$RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"

# Show file extensions in explorer
Write-Host "Showing hidden files in Explorer"
Set-RegistryEntry -Key 'HideFileExt' -Type "DWORD" -Value '0' -Path $RegPath
