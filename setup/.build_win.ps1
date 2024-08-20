#TODO: 
# [X] - Check which programs are installed, download them to correct places
# [X] - Create junctions and symlinks for windows config files
# [ ] - Check and replace old config files with config.old file for safety

#NOTE: AutoHotKey, fonts, komorebi, scoop and whkdrc do not need any links.

$nvim = 'C:\Program Files\Neovim\bin\nvim.exe'
$posh = $home +'\AppData\Local\Programs\oh-my-posh\bin\oh-my-posh.exe'
$wezterm = 'C:\Program Files\WezTerm\wezterm.exe'

function Docker {
    New-Item -ItemType -SymbolicLink -Path "~\.docker" -Target (Get-Item ~\.config\.docker).FullName
}


function Nvim {
    if (Test-Path $nvim) {
        New-Item -ItemType Junction -Path "~\AppData\Local\nvim" -Target (Get-Item ~\.config\nvim).FullName
    } else {
        Write-Output 'No NeoVim found.'
    }
}

function Posh {
    if (Test-Path $posh) {
        New-Item -ItemType Junction -Path "~\Posh" -Target (Get-Item ~\.config\Posh).FullName
    } else {
        Write-Output 'No oh-my-posh found.'
    }
}

function PowerShell {
    New-Item -ItemType Junction -Path "~\Documents\PowerShell" -Target (Get-Item ~\.config\PowerShell).FullName
}

function WezTerm {
    if (Test-Path $wezterm) {
        New-Item -ItemType SymbolicLink -Path "~\.wezterm.lua" -Target (Get-Item ..\.wezterm.lua).FullName
    } else {
        Write-Output 'No WezTerm found.'
    }
}

function init {
    Docker
    Nvim
    Posh
    PowerShell
    Wezterm
}
#init
