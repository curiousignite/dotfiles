#Executable paths
$nvim_exe = 'C:\Program Files\Neovim\bin\nvim.exe'
$nvim_exe2 = 'C:\tools\neovim\nvim-win64\bin\nvim.exe'
$posh_exe = $home +'\AppData\Local\Programs\oh-my-posh\bin\oh-my-posh.exe'
$wezterm_exe = 'C:\Program Files\WezTerm\wezterm.exe'
$docker_exe = 'C:\Program Files\Docker\Docker\Docker Desktop.exe'

#Config paths
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

$winget_apps= @'
All
MSYS2.MSYS2
JanDeDobbeleer.OhMyPosh
Microsoft.Powershell.Preview
Microsoft.WindowsTerminalPreview
Git.Git
Neovim.Neovim
Microsoft.DotNet.SDK.7
Microsoft.DotNet.Runtime.7
Mozilla.Firefox.DeveloperEdition
Valve.Steam
LGUG2Z.komorebi
LGUG2Z.whkd
wez.wezterm
Docker.DockerDesktop
'@ -split [environment]::NewLine

$scoop_apps = @'
All
sudo
bat
btop
fastfetch
vcredist
secureuxtheme
archwsl
topgrade
7zip
meld
'@ -split [environment]::NewLine

$RegistryKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"

if (! (Test-Path -Path $RegistryKeyPath)) {
    New-Item -Path $RegistryKeyPath -ItemType Directory -Force
}

if (! (Get-ItemProperty -Path $RegistryKeyPath | Select-Object -ExpandProperty AllowDevelopmentWithoutDevLicense)) {
    # Add registry value to enable Developer Mode
    New-ItemProperty -Path $RegistryKeyPath -Name AllowDevelopmentWithoutDevLicense -PropertyType DWORD -Value 1
}
function Download-Winget{
    Clear-Host
    function Out-Menu {
        param (
            [Parameter(Mandatory = $true, ValueFromPipeline = $True, ValueFromPipelinebyPropertyName = $True)]
            [object[]]$Object,
            [string]$Header,
            [string]$Footer,
            [switch]$AllowCancel, 
            [switch]$AllowMultiple
        )

        if ($input) {
            $Object = @($input)
            Write-Host $Object
        }

        if (!$Object) {
            throw 'Must provide an object.'
        }
 
        Write-Host '' 
 
        do { 
            $prompt = New-Object System.Text.StringBuilder 
            switch ($true) { 
                { [bool]$Header -and $Header -notmatch '^(?:\s+)?$' } {
                    $null = $prompt.Append($Header); break 
                }
                $true {
                    $null = $prompt.Append('Choose an option') 
                } 
                $AllowCancel {
                    $null = $prompt.Append(', or enter "c" to cancel.') 
                } 
                $AllowMultiple {
                    $null = $prompt.Append("`nTo select multiple, enter numbers separated by a comma EX: 1, 2") 
                } 
            } 
            Write-Host $prompt.ToString() 
 
            for ($i = 0; $i -lt $Object.Count; $i++) { 
                Write-Host "$('{0:D2}' -f ($i)). $($Object[$i])" 
            } 
 
            if ($Footer) { 
                Write-Host $Footer 
            } 

            Write-Host '' 
 
            if ($AllowMultiple) { 
                $answers = @(Read-Host).Split(',').Trim() 

                if ($AllowCancel -and $answers -match 'c') { 
                    return
                } 
 
                $ok = $true 
                foreach ($ans in $answers) { 
                    if ($ans -in 0..$Object.Count) { 
                        $Object[$ans] 
                    } else { 
                        Write-Host 'Not an option!' -ForegroundColor Red 
                        Write-Host ''
                        $ok = $false 
                    }
                }
            } else { 
                $answer = Read-Host 

                if ($AllowCancel -and $answer -eq 'c') { 
                    return 
                } 
 
                $ok = $true
                if ($answer -in 0..$Object.Count) { 
                    $Object[$answer] 
                } else { 
                    Write-Host 'Not an option!' -ForegroundColor Red
                    Write-Host '' 
                    $ok = $false
                }
            }
        } while (!$ok)
    }

    $Choices = Out-Menu $winget_apps -AllowCancel -AllowMultiple


    if ($Choices -Contains "All") {
        foreach ($Choice in $winget_apps) {
            if ($Choice -eq "All") {
                continue
            }
            Winget install --id $Choice
        }
    } else {
        foreach ($Choice in $Choices) {
            Winget install --id $Choice
        }
    } 
}

function Download-Scoop{
    Clear-Host
    function Out-Menu {
        param (
            [Parameter(Mandatory = $true, ValueFromPipeline = $True, ValueFromPipelinebyPropertyName = $True)]
            [object[]]$Object,
            [string]$Header,
            [string]$Footer,
            [switch]$AllowCancel, 
            [switch]$AllowMultiple
        )

        if ($input) {
            $Object = @($input)
            Write-Host $Object
        }

        if (!$Object) {
            throw 'Must provide an object.'
        }
 
        Write-Host '' 
 
        do { 
            $prompt = New-Object System.Text.StringBuilder 
            switch ($true) { 
                { [bool]$Header -and $Header -notmatch '^(?:\s+)?$' } {
                    $null = $prompt.Append($Header); break 
                }
                $true {
                    $null = $prompt.Append('Choose an option') 
                } 
                $AllowCancel {
                    $null = $prompt.Append(', or enter "c" to cancel.') 
                } 
                $AllowMultiple {
                    $null = $prompt.Append("`nTo select multiple, enter numbers separated by a comma EX: 1, 2") 
                } 
            } 
            Write-Host $prompt.ToString() 
 
            for ($i = 0; $i -lt $Object.Count; $i++) { 
                Write-Host "$('{0:D2}' -f ($i)). $($Object[$i])" 
            } 
 
            if ($Footer) { 
                Write-Host $Footer 
            } 

            Write-Host '' 
 
            if ($AllowMultiple) { 
                $answers = @(Read-Host).Split(',').Trim() 

                if ($AllowCancel -and $answers -match 'c') { 
                    return
                } 
 
                $ok = $true 
                foreach ($ans in $answers) { 
                    if ($ans -in 0..$Object.Count) { 
                        $Object[$ans] 
                    } else { 
                        Write-Host 'Not an option!' -ForegroundColor Red 
                        Write-Host ''
                        $ok = $false 
                    }
                }
            } else { 
                $answer = Read-Host 

                if ($AllowCancel -and $answer -eq 'c') { 
                    return 
                } 
 
                $ok = $true
                if ($answer -in 0..$Object.Count) { 
                    $Object[$answer] 
                } else { 
                    Write-Host 'Not an option!' -ForegroundColor Red
                    Write-Host '' 
                    $ok = $false
                }
            }
        } while (!$ok)
    }

    $Choices = Out-Menu $scoop_apps -AllowCancel -AllowMultiple

    if ($Choices -Contains "All") {
        foreach ($Choice in $scoop_apps) {
            if ($Choice -eq "All") {
                continue
            }
            scoop install $Choice
        }
    } else {
        foreach ($Choice in $Choices) {
            scoop install $Choice
        }
    } 
    scoop update -all
}



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
function komorebi{
    ## Set komorebi to run on startup
    $RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
    Set-ItemProperty -Name 'KomorebicOnLogin' -Value 'C:\Program Files\komorebi\bin\komorebic.exe start --whkd --await-configuration' -Path $RegPath
}
function Init {
    Download-Winget
    Download-Scoop
    Docker
    Nvim
    Posh
    PowerShell
    Wezterm
    Fonts
}
Init
