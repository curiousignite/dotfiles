# Executable paths
$nvim_exe    = 'C:\Program Files\Neovim\bin\nvim.exe'
$nvim_exe2   = 'C:\tools\neovim\nvim-win64\bin\nvim.exe'
$posh_exe    = $home +'\AppData\Local\Programs\oh-my-posh\bin\oh-my-posh.exe'
$wezterm_exe = 'C:\Program Files\WezTerm\wezterm.exe'
$docker_exe  = 'C:\Program Files\Docker\Docker\Docker Desktop.exe'
$firefox_exe = 'C:\Program Files\Mozilla Firefox\firefox.exe'

# Config paths
$nvim_config    = $home + '\AppData\Local\nvim'
$posh_config    = $home + '\Posh'
$wezterm_config = $home + '\.wezterm.lua'
$docker_config  = $home + '\.docker'
$firefox_config = $home + '\AppData\Roaming\Mozilla\Firefox\Profiles\92wg67t8.berke\chrome'
$userjs         = $home + '\AppData\Roaming\Mozilla\Firefox\Profiles\92wg67t8.berke\user.js'
$pwsh_config    = split-path -parent $PROFILE

# Config old
$nvim_config_old    = $nvim_config    + '.old'
$posh_config_old    = $posh_config    + '.old' 
$wezterm_config_old = $wezterm_config + '.old'
$pwsh_config_old    = $pwsh_config    + '.old'
$firefox_config_old = $firefox_config + '.old'
$userjs_old         = $userjs         + '.old'

if (Test-Path $docker_exe) {
    if(Test-Path $docker_config) {
        Remove-Item -Path $docker_config_old -Force -Recurse
        Move-Item -Path $docker_config -Destination $docker_config_old
    }
    New-Item -ItemType Junction -Path $docker_config -Target (Get-Item ~\.config\.docker).FullName
} else {
    Write-Output 'No Docker found.'
}

if( (Test-Path $nvim_exe) -or (Test-Path $nvim_exe2) ){
    if(Test-Path $nvim_config) {
        Remove-Item -Path $nvim_config_old -Force -Recurse
        Move-Item -Path $nvim_config -Destination $nvim_config_old
    }
    New-Item -ItemType Junction -Path $nvim_config -Target (Get-Item ~\.config\nvim).FullName
} else {
    Write-Output 'No NeoVim found.'
}

if (Test-Path $posh_exe) {
    if(Test-Path $posh_config ) {
        Remove-Item -Path $posh_config_old -Force -Recurse
        Move-Item -Path $posh_config -Destination $posh_config_old
    }
    New-Item -ItemType Junction -Path $posh_config -Target (Get-Item ~\.config\Posh).FullName
} else {
    Write-Output 'No oh-my-posh found.'
}

if(Test-Path $pwsh_config) {
    Remove-Item -Path $pwsh_config_old -Force -Recurse
    Move-Item -Path $pwsh_config -Destination $pwsh_config_old
}
New-Item -ItemType Junction -Path $pwsh_config -Target (Get-Item ~\.config\PowerShell).FullName


if (Test-Path $wezterm_exe) {
    if(Test-Path $wezterm_config) {
        Remove-Item -Path  $wezterm_config_old -Force -Recurse
        Move-Item -Path $wezterm_config -Destination $wezterm_config_old
    }
    New-Item -ItemType SymbolicLink -Path $wezterm_config -Target (Get-Item ~\.config\.wezterm.lua).FullName
} else {
    Write-Output 'No WezTerm found.'
}

#chrome/
if (Test-Path $firefox_exe) {
    if(Test-Path $firefox_config) {
        Remove-Item -Path  $firefox_config_old -Force -Recurse
        Move-Item -Path $firefox_config -Destination $firefox_config_old
    }
    New-Item -ItemType Junction -Path $firefox_config -Target (Get-Item ~\.config\firefox\chrome).FullName
    #user.js
    if(Test-Path $userjs) {
        Remove-Item -Path  $userjs_old -Force -Recurse
        Move-Item -Path $userjs -Destination $userjs_old
    }
    New-Item -ItemType SymbolicLink -Path $userjs -Target (Get-Item ~\.config\firefox\user.js).FullName
} else {
    Write-Output 'No Firefox found.'
}

