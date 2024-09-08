$modules = "$(Split-Path $PROFILE)\Modules"
# $scripts = "$(Split-Path $PROFILE)\Scripts"
# $desktop =  $(resolve-path "$Env:userprofile\desktop")

oh-my-posh init pwsh --config $HOME\posh\themes\catppuccin\catppuccin.omp.json | Invoke-Expression
Import-Module git-aliases -DisableNameChecking
Import-Module PSReadLine
Import-Module $modules\translate\0.1\translate.psm1
$Env:KOMOREBI_CONFIG_HOME = "$HOME\.config\komorebi"

function fastfetch_wrapper {
    param (
        [object[]]$Object
    )
    Write-Host $Object
}

function ll {
    # Get-ChildItem -Force $args 
    eza -la --hyperlink
}
function which {
    param($bin) Get-Command $bin
}
function img{
    param($file) wezterm imgcat $file
}
function clr {
    Clear-Host;
    fastfetch
}
