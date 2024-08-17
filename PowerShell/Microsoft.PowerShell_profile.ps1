$scripts = "$(Split-Path $PROFILE)\Scripts"
$modules = "$(Split-Path $PROFILE)\Modules"
$desktop =  $(resolve-path "$Env:userprofile\desktop")

oh-my-posh init pwsh --config 'C:\Users\berke\posh\Themes\catppuccin\catppuccin.omp.json'| Invoke-Expression
Import-Module git-aliases -DisableNameChecking
Import-Module PSReadLine
Import-Module 'C:\Users\berke\.config\PowerShell\Modules\translate\0.1\translate.psm1'
$Env:KOMOREBI_CONFIG_HOME = 'C:\\Users\berke\\.config\\komorebi'

# enable Vim on the shell and as editor
$OnViModeChange = [scriptblock]{
    if ($args[0] -eq 'Command')
    {
        # Set the cursor to a blinking block.
        Write-Host -NoNewLine "`e[2 q"
    } else
    {
        # Set the cursor to a blinking line.
        Write-Host -NoNewLine "`e[1 q"
    }
}

Set-PsReadLineOption -EditMode Vi
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $OnViModeChange
