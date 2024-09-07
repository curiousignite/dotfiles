#
# ░█▀█░█▀▄░█▀▀░█▀█
# ░█▀▀░█▀▄░█▀▀░█▀▀
# ░▀░░░▀░▀░▀▀▀░▀░░
#
$DOTFILES_MODULES_PATH = $HOME + "/.config/PowerShell/Modules"
$DOCUMENTS_PATH = Get-ItemPropertyValue -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -Name "Personal" -ErrorAction SilentlyContinue
$USER_MODULES_PATH =  "$DOCUMENTS_PATH/WindowsPowerShell/Modules/"
$ModuleList = Get-ChildItem -Path "$DOTFILES_MODULES_PATH\*"

foreach ( $module in $ModuleList ) {
    if (Get-ChildItem -Path "$DOCUMENTS_PATH/WindowsPowerShell/Modules/*" | Select-String -Pattern $module.baseName ) {
        Write-Host (-join($module.baseName, " already installed. Skipping..."))
    } else {
        Write-Host (-join("Installing ", $module.baseName, " module"))
        Copy-Item -Path "$module" -Destination "$USER_MODULES_PATH" -Recurse -Force
    }
}
