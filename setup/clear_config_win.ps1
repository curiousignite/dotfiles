$nvim_config = $home + '\AppData\Local\nvim'
$posh_config = $home +'\Posh'
$wezterm_config = '.\.wezterm.lua'
$pwsh_config = $home + '\Documents\PowerShell'
$docker_config = $home + '\.docker'

function clear_config {
    Remove-Item $nvim_config -Recurse
    Remove-Item $posh_config -Recurse
    Remove-Item $wezterm_config
    Remove-Item $pwsh_config -Recurse
    Remove-Item $docker_config -Recurse
    
}
clear_config
