using module Message
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

# Removes Task View from the Taskbar
Write-Message -Type WARNING -Message "Removing task view from taskbar..."
Set-RegistryEntry -Key 'ShowTaskViewButton' -Type "DWORD" -Value '0' -Path $RegPath

# Removes Widgets from the Taskbar
Write-Message -Type WARNING -Message "Removing widgets from taskbar..."
Set-RegistryEntry -Key 'TaskbarDa' -Type "DWORD" -Value '0' -Path $RegPath

# Removes Chat from the Taskbar
Write-Message -Type WARNING -Message "Removing chat from taskbar..."
Set-RegistryEntry -Key 'TaskbarMn' -Type "DWORD" -Value '0' -Path $RegPath

$RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"

# Removes search from the Taskbar
Write-Message -Type WARNING -Message "Removing search from taskbar..."
Set-RegistryEntry -Key 'SearchboxTaskbarMode' -Type "DWORD" -Value '0' -Path $RegPath
