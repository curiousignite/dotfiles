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
LLVM.LLVM
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
if ( !(Test-CommandExists winget)) {
    Write-Host ""
    Write-Host  "Installing winget"
    $download_url = "https://github.com/microsoft/winget-cli/releases/download/v1.4.10173/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
    $download_save_file = "$($env:USERPROFILE)\Downloads\MicrosoftDesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
    $wc.Downloadfile($download_url, $download_save_file)
    Add-AppXPackage -Path $($env:USERPROFILE)\Downloads\MicrosoftDesktopAppInstaller_8wekyb3d8bbwe.msixbundle
} else {
    Write-Host ""
    Write-Host "Winget already installed. Skipping..."
}
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
            {[bool]$Header -and $Header -notmatch '^(?:\s+)?$' } {
                $null = $prompt.Append($Header); break
            }
            $true {
                $null = $prompt.Append('Choose WinGet apps to install')
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

if (!(Test-Path -Path "$($env:USERPROFILE)/scoop/shims/scoop" -PathType Leaf)) {
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
} else {
    Write-Host ""
    Write-Host "Scoop already installed. skipping..."
}
# Install scoop
$scoop_buckets = @(
    'main', 'extras', 'versions', 'nerd-fonts'
)
foreach ($bucket in $scoop_buckets) {
    scoop bucket add $bucket
}
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
            {[bool]$Header -and $Header -notmatch '^(?:\s+)?$' } {
                $null = $prompt.Append($Header); break
            }
            $true {
                $null = $prompt.Append('Choose scoop apps to install')
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

scoop update --all
winget upgrade --all
