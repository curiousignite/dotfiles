$modules = "$(Split-Path $PROFILE)\Modules"
# $scripts = "$(Split-Path $PROFILE)\Scripts"
# $desktop =  $(resolve-path "$Env:userprofile\desktop")

oh-my-posh init pwsh --config $HOME\posh\themes\catppuccin\catppuccin.omp.json | Invoke-Expression
Import-Module git-aliases -DisableNameChecking
Import-Module PSReadLine
Import-Module $modules\translate\0.1\translate.psm1
$Env:KOMOREBI_CONFIG_HOME = "$HOME\.config\komorebi"
Set-Alias -Name 'vim' -Value 'nvim'
Set-Alias fe FindFile 

function ll {
    param($var) eza -la --hyperlink $var
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
#function prompt {
#    $p = $executionContext.SessionState.Path.CurrentLocation
#    $osc7 = ""
#    if ($p.Provider.Name -eq "FileSystem") {
#        $ansi_escape = [char]27
#        $provider_path = $p.ProviderPath -Replace "\\", "/"
#        $osc7 = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}${ansi_escape}\"
#    }
#    "${osc7}PS $p$('>' * ($nestedPromptLevel + 1)) ";
#}
