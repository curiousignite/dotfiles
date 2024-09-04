#
# ░█░█░▀█▀░█▀█░█▀▄░█▀█░█░█░█▀▀░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀░█▀▀
# ░█▄█░░█░░█░█░█░█░█░█░█▄█░▀▀█░░░█░░░█░█░█░█░█▀▀░░█░░█░█░▀▀█
# ░▀░▀░▀▀▀░▀░▀░▀▀░░▀▀▀░▀░▀░▀▀▀░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░▀▀▀
#
# Set up Windows Configurations
##
Clear-Host
#Variables setup
$global:GIT_DIR = git rev-parse --show-toplevel
$RegistryKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"

#
# ░█▀█░█▀▄░█▀▀░█▀█
# ░█▀▀░█▀▄░█▀▀░█▀▀
# ░▀░░░▀░▀░▀▀▀░▀░░
#
# Set powershell execution policy
##
Write-Host "Setting powershell to allow execution of scripts"
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser

if (! (Test-Path -Path $RegistryKeyPath)) {
    New-Item -Path $RegistryKeyPath -ItemType Directory -Force
}

if (! (Get-ItemProperty -Path $RegistryKeyPath | Select-Object -ExpandProperty AllowDevelopmentWithoutDevLicense)) {
    # Add registry value to enable Developer Mode
    New-ItemProperty -Path $RegistryKeyPath -Name AllowDevelopmentWithoutDevLicense -PropertyType DWORD -Value 1
}

#
# ░█░█░▀█▀░█▀█░█▀▄░█▀█░█░█░█▀▀░░░█▀▀░█▀▀░█▀█░▀█▀░█░█░█▀▄░█▀▀░█▀▀
# ░█▄█░░█░░█░█░█░█░█░█░█▄█░▀▀█░░░█▀▀░█▀▀░█▀█░░█░░█░█░█▀▄░█▀▀░▀▀█
# ░▀░▀░▀▀▀░▀░▀░▀▀░░▀▀▀░▀░▀░▀▀▀░░░▀░░░▀▀▀░▀░▀░░▀░░▀▀▀░▀░▀░▀▀▀░▀▀▀
#
# Enable developer mode
##
Write-Host "
Enabling developer mode and Windows Features"
.$GIT_DIR/setup/os/windows/Enable-WindowsFeatures.ps1

#
# ░█▀█░█▀█░█▀█░█░░░▀█▀░█▀▀░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀
# ░█▀█░█▀▀░█▀▀░█░░░░█░░█░░░█▀█░░█░░░█░░█░█░█░█░▀▀█
# ░▀░▀░▀░░░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀
#
# Install software
##
Write-Host "
Installing software."
.$GIT_DIR/setup/os/windows/Install-Programs.ps1

#
# ░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀░█░█░█▀▄░█▀█░▀█▀░▀█▀░█▀█░█▀█
# ░█░░░█░█░█░█░█▀▀░░█░░█░█░█░█░█▀▄░█▀█░░█░░░█░░█░█░█░█
# ░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀
#
# Copy/Link Config Files
##
Write-Host "
Installing Config Files"
.$GIT_DIR/os/windows/Configure-Apps.ps1

Write-Host "
Adding programs to startup"
.$GIT_DIR/setup/os/windows/Startup.ps1

Write-Host "
[!!] Dotfiles finished installation. Some changes require a reboot to take effect!"
