Clear-Host
$scoop_apps= @'
sudo
bat
btop
fastfetch
pshazz
vcredist
secureuxtheme
archwsl
topgrade
'@ -split [environment]::NewLine
function Download{
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
            Winget install --id $Choice
        }
    } else {
        foreach ($Choice in $Choices) {
            Winget install --id $Choice
        }
    } 
}
Download
