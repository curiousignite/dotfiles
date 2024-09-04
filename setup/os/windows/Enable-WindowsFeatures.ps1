function Request-ElevateScript {    
    param (
        [Parameter(Mandatory=$true)] [string]$File
    ) 

    # Self-elevate the script if required
    if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
        if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
            $CommandLine = "-File `"" + $File + "`" "
            Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
            Exit
        }
    }
}

#
# ░█░█░▀█▀░█▀█░█▀▄░█▀█░█░█░█▀▀░░░█▀▀░█▀▀░█▀█░▀█▀░█░█░█▀▄░█▀▀░█▀▀
# ░█▄█░░█░░█░█░█░█░█░█░█▄█░▀▀█░░░█▀▀░█▀▀░█▀█░░█░░█░█░█▀▄░█▀▀░▀▀█
# ░▀░▀░▀▀▀░▀░▀░▀▀░░▀▀▀░▀░▀░▀▀▀░░░▀░░░▀▀▀░▀░▀░░▀░░▀▀▀░▀░▀░▀▀▀░▀▀▀
#

if (([Version](Get-CimInstance Win32_OperatingSystem).version).Major -lt 10) {
    Write-Host "The DeveloperMode is only supported on Windows 10"
    exit 1
}

Write-Host "Enabling features requires admin elevated privileges. Requesting elevated privileges..."

# Self-elevate the script if required
Request-ElevateScript -File $MyInvocation.MyCommand.Path

$RegistryKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"
if (! (Test-Path -Path $RegistryKeyPath)) {
    Write-Host "Enable installing unsigned apps"
    New-Item -Path $RegistryKeyPath -ItemType Directory -Force
} else {
    Write-Host "AppModelUnlock already set. Skipping.."
}

if (! (Get-ItemProperty -Path $RegistryKeyPath | Select-Object -ExpandProperty AllowDevelopmentWithoutDevLicense)) {
    # Add registry value to enable Developer Mode
    Write-Host "Enable developer mode"
    New-ItemProperty -Path $RegistryKeyPath -Name AllowDevelopmentWithoutDevLicense -PropertyType DWORD -Value 1
} else {
    Write-Host "Dev mode already enabled. Skipping.."
}

$feature = Get-WindowsOptionalFeature -FeatureName Microsoft-Windows-Subsystem-Linux -Online
if ($feature -and ($feature.State -eq "Disabled")) {
    Write-Host "Enable WSL"
    Enable-WindowsOptionalFeature -FeatureName Microsoft-Windows-Subsystem-Linux -Online -All -LimitAccess -NoRestart
} else {
    Write-Host "WSL already enabled. Skipping.."
}

$feature = Get-WindowsOptionalFeature -FeatureName VirtualMachinePlatform -Online
if ($feature -and ($feature.State -eq "Disabled")) {
    Write-Host "Enable Virtual Machine Platform"
    Enable-WindowsOptionalFeature -FeatureName VirtualMachinePlatform -Online -All -LimitAccess -NoRestart
} else {
    Write-Host "Virtual Machine Platform already enabled. Skipping.."
}

$feature = Get-WindowsOptionalFeature -FeatureName Microsoft-Hyper-V -Online
if ($feature -and ($feature.State -eq "Disabled")) {
    Write-Host "Enable Hyper-V"
    Enable-WindowsOptionalFeature -FeatureName Microsoft-Hyper-V -Online -All -LimitAccess -NoRestart
} else {
    Write-Host "Hyper-V already enabled. Skipping.."
}
