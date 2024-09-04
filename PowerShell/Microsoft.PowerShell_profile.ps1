# $scripts = "$(Split-Path $PROFILE)\Scripts"
# $modules = "$(Split-Path $PROFILE)\Modules"
# $desktop =  $(resolve-path "$Env:userprofile\desktop")

oh-my-posh init pwsh --config 'C:\Users\berke\posh\Themes\catppuccin\catppuccin.omp.json'| Invoke-Expression
Import-Module git-aliases -DisableNameChecking
Import-Module PSReadLine
Import-Module 'C:\Users\berke\.config\PowerShell\Modules\translate\0.1\translate.psm1'
$Env:KOMOREBI_CONFIG_HOME = 'C:\\Users\berke\\.config\\komorebi'

function fastfetch_wrapper {
    param (
        [object[]]$Object
    )
    Write-Host $Object
}

function ll {
    Get-ChildItem -Force $args 
}
function which {
    param($bin) Get-Command $bin
}
function clr {
    Clear-Host;
    fastfetch --logo C:\Users\berke\.config\fastfetch\logos\catppuccin-windows --logo-type "file" --logo-color-1 green --logo-color-2 yellow --logo-color-3 red --logo-color-4 magenta --logo-color-5 blue ;
}
fastfetch --logo C:\Users\berke\.config\fastfetch\logos\catppuccin-windows --logo-type "file" --logo-color-1 green --logo-color-2 yellow --logo-color-3 red --logo-color-4 magenta --logo-color-5 blue ;
