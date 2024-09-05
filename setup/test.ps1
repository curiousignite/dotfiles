$global:GIT_DIR = git rev-parse --show-toplevel
$global:SCRIPTS_DIR = $GIT_DIR+"/setup/os/windows"

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

