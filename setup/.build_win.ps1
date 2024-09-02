#NOTE: AutoHotKey, fonts, komorebi, scoop and whkdrc do not need any links.

#Executables
$nvim_exe = 'C:\Program Files\Neovim\bin\nvim.exe'
$nvim_exe2 = 'C:\tools\neovim\nvim-win64\bin\nvim.exe'
$posh_exe = $home +'\AppData\Local\Programs\oh-my-posh\bin\oh-my-posh.exe'
$wezterm_exe = 'C:\Program Files\WezTerm\wezterm.exe'
$docker_exe = 'C:\Program Files\Docker\Docker\Docker Desktop.exe'

#Configs
$nvim_config = $home + '\AppData\Local\nvim'
$posh_config = $home +'\Posh'
$wezterm_config = $home + '\.wezterm.lua'
$docker_config = $home + '\.docker'
$pwsh_config = split-path -parent $PROFILE

#Config old
$nvim_config_old = $nvim_config + '.old'
$posh_config_old = $posh_config + '.old' 
$wezterm_config_old = $wezterm_config + '.old'
$pwsh_config_old = $pwsh_config + '.old'
$docker_config_old = $docker_config + '.old'

#Fonts
$FontFolder = $home + '\.config\fonts'
$FontItem = Get-Item -Path $FontFolder
$FontList = Get-ChildItem -Path "$FontItem\*" -Include ('*.fon','*.otf','*.ttc','*.ttf') -Recurse

function Docker {
    if (Test-Path $docker_exe) {
        if(Test-Path $docker_config) {
            Remove-Item -Path $docker_config_old -Force -Recurse 
            Move-Item -Path $docker_config -Destination $docker_config_old
        }
        New-Item -ItemType Junction -Path $docker_config -Target (Get-Item ~\.config\.docker).FullName
    } else {
        Write-Output 'No Docker found.'
    }
}

function Nvim {
    if( (Test-Path $nvim_exe) -or (Test-Path $nvim_exe2) ){
        if(Test-Path $nvim_config) {
            Remove-Item -Path $nvim_config_old -Force -Recurse 
            Move-Item -Path $nvim_config -Destination $nvim_config_old
        }
        New-Item -ItemType Junction -Path $nvim_config -Target (Get-Item ~\.config\nvim).FullName
    } else {
        Write-Output 'No NeoVim found.'
    }
}

function Posh {
    if (Test-Path $posh_exe) {
        if(Test-Path $posh_config ) {
            Remove-Item -Path $posh_config_old -Force -Recurse 
            Move-Item -Path $posh_config -Destination $posh_config_old
        }
        New-Item -ItemType Junction -Path $posh_config -Target (Get-Item ~\.config\Posh).FullName
    } else {
        Write-Output 'No oh-my-posh found.'
    }
}

function PowerShell {
    if(Test-Path $pwsh_config) {
        Remove-Item -Path $pwsh_config_old -Force -Recurse 
        Move-Item -Path $pwsh_config -Destination $pwsh_config_old
    }
    New-Item -ItemType Junction -Path $pwsh_config -Target (Get-Item ~\.config\PowerShell).FullName
}

function WezTerm {
    if (Test-Path $wezterm_exe) {
        if(Test-Path $wezterm_config) {

            Remove-Item -Path  $wezterm_config_old -Force -Recurse 
            Move-Item -Path $wezterm_config -Destination $wezterm_config_old
        }
        New-Item -ItemType SymbolicLink -Path $wezterm_config -Target (Get-Item ~\.config\.wezterm.lua).FullName
    } else {
        Write-Output 'No WezTerm found.'
    }
}
function Fonts {
    foreach ($Font in $FontList) {
        $fontpath = "C:\Windows\Fonts\" + $Font
        if([System.IO.File]::Exists($fontpath)) {
            Write-Host 'Installing font -' $Font.BaseName
            Copy-Item $Font "C:\Windows\Fonts"
            New-ItemProperty -Name $Font.BaseName -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -PropertyType string -Value $Font.name
        } else {
            Write-Host $Font + " is already installed"
        }
    } 
}
function init {
    Docker
    Nvim
    Posh
    PowerShell
    Wezterm
    Fonts
}

init
