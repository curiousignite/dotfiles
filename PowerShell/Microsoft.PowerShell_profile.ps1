$modules = "$(Split-Path $PROFILE)\Modules"
# $scripts = "$(Split-Path $PROFILE)\Scripts"
# $desktop =  $(resolve-path "$Env:userprofile\desktop")

oh-my-posh init pwsh --config $HOME\posh\themes\catppuccin\catppuccin.omp.json | Invoke-Expression
#Import-Module git-aliases -DisableNameChecking
Import-Module PSReadLine
Import-Module $modules\translate\0.1\translate.psm1
$Env:KOMOREBI_CONFIG_HOME = "$HOME\.config\komorebi"
Set-Alias -Name 'vim' -Value 'nvim'
Set-Alias fe FindFile 
Set-Alias wc Measure-Object
Set-Alias du Get-Folder-Size
function ll {
    param($var) eza -la --hyperlink --header --icons $var
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
function FindFile {
    fzf | ForEach-Object{
        vim $_
    }
}
function Get-Folder-Size {
    param($path) Get-ChildItem -Path $path -Directory | ForEach-Object { $_.FullName + ": " + [math]::Round((Get-ChildItem $_.FullName -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB,2) + " MB" }
}
