#
# ░█░█░▀█▀░█▀█░█▀▄░█▀█░█░█░█▀▀░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀░█▀▀
# ░█▄█░░█░░█░█░█░█░█░█░█▄█░▀▀█░░░█░░░█░█░█░█░█▀▀░░█░░█░█░▀▀█
# ░▀░▀░▀▀▀░▀░▀░▀▀░░▀▀▀░▀░▀░▀▀▀░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░▀▀▀
#
# Set up Windows Configurations
##

#Variables setup
$global:GIT_DIR = git rev-parse --show-toplevel
$global:SCRIPTS_DIR = $GIT_DIR+"/setup/os/windows"

#
# ░█▀█░█▀▄░█▀▀░█▀█
# ░█▀▀░█▀▄░█▀▀░█▀▀
# ░▀░░░▀░▀░▀▀▀░▀░░
#
# Set powershell execution policy
##
Write-Host "Setting powershell to allow execution of scripts"
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser

##
# Install Powershell modules
##
Write-Host "
Installing Powershell Modules"
.$SCRIPTS_DIR/Install-Modules.ps1

#
# ░█▀▀░█▀█░█▀█░▀█▀░█▀▀
# ░█▀▀░█░█░█░█░░█░░▀▀█
# ░▀░░░▀▀▀░▀░▀░░▀░░▀▀▀
#
# Install fonts
##
Write-Host "
Installing fonts"
.$SCRIPTS_DIR/Install-Fonts.ps1 $GIT_DIR"/fonts"

#
# ░█░█░▀█▀░█▀█░█▀▄░█▀█░█░█░█▀▀░░░█▀▀░█▀▀░█▀█░▀█▀░█░█░█▀▄░█▀▀░█▀▀
# ░█▄█░░█░░█░█░█░█░█░█░█▄█░▀▀█░░░█▀▀░█▀▀░█▀█░░█░░█░█░█▀▄░█▀▀░▀▀█
# ░▀░▀░▀▀▀░▀░▀░▀▀░░▀▀▀░▀░▀░▀▀▀░░░▀░░░▀▀▀░▀░▀░░▀░░▀▀▀░▀░▀░▀▀▀░▀▀▀
#
# Enable developer mode
##
Write-Host "
Enabling developer mode and Windows Features"
.$SCRIPTS_DIR/Enable-WindowsFeatures.ps1

#
# ░█▀█░█▀█░█▀█░█░░░▀█▀░█▀▀░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀
# ░█▀█░█▀▀░█▀▀░█░░░░█░░█░░░█▀█░░█░░░█░░█░█░█░█░▀▀█
# ░▀░▀░▀░░░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀
#
# Install software
##
Write-Host "
Installing software."
.$SCRIPTS_DIR/Install-Programs.ps1

#
# ░▀█▀░█░█░█▀▀░█▄█░▀█▀░█▀█░█▀▀
# ░░█░░█▀█░█▀▀░█░█░░█░░█░█░█░█
# ░░▀░░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀
# Install themes
##

##
# Customize windows taskbar
##
Write-Host "
Customizing the taskbar"
.$SCRIPTS_DIR/Customize-Taskbar.ps1

##
# Customize windows explorer
##
Write-Host "
Customizing explorer"
.$SCRIPTS_DIR/Customize-Explorer.ps1

##
# Update windows theme
##
Write-Host "
Installing Catppuccin Explorer Themes" 
.$SCRIPTS_DIR/Install-Theme.ps1 "$GIT_DIR/themes/Explorer/*"

##
# Customize cursor
##
Write-Host "
Installing Posy's Cursor"
.$SCRIPTS_DIR/Install-Cursor.ps1 "$GIT_DIR/themes/Cursors/Posys Cursor/_install Posy Default.inf"
Write-Host "
Installing Posy's Cursor Black"
.$SCRIPTS_DIR/Install-Cursor.ps1 "$GIT_DIR/themes/Cursors/Posys Cursor Black/_install Posy Black.inf"


# Need to test on VM first
#
# Write-Host "
# Setting Catppuccin Windows Colors" 
#.$SCRIPTS_DIR/Color-Explorer.ps1

#
# ░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀░█░█░█▀▄░█▀█░▀█▀░▀█▀░█▀█░█▀█
# ░█░░░█░█░█░█░█▀▀░░█░░█░█░█░█░█▀▄░█▀█░░█░░░█░░█░█░█░█
# ░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀
#
# Copy/Link Config Files
##
Write-Host "
Installing Config Files"
.$SCRIPTS_DIR/Configure-Apps.ps1

Write-Host "
Adding programs to startup"
.$SCRIPTS_DIR/Startup.ps1

Write-Host "
[!!] Dotfiles finished installation. Some changes require a reboot to take effect!"
