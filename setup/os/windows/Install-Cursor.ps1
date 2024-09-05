using module Message
using module UserPreferencesMask

#
# ░▀█▀░█░█░█▀▀░█▄█░▀█▀░█▀█░█▀▀
# ░░█░░█▀█░█▀▀░█░█░░█░░█░█░█░█
# ░░▀░░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀
#
# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
        Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    }
}

# Check what the current cursor is set to
$current_cursor = Get-ItemPropertyValue "HKCU:\Control Panel\Cursors" -Name "(Default)"

if ($current_cursor -eq "Posy's Cursor") {
    Write-Message -Type WARNING  -Message 'Cursor already set. Skipping...'
} else {
    Write-Message -Message 'Cursor not set. Installing cursor and setting...'
    infdefaultinstall.exe $args
    Set-itemproperty "HKCU:\Control Panel\Cursors" -Name "(Default)" -Value "Posys Cursor"
    $RegConnect = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]"CurrentUser","$env:COMPUTERNAME")
    $RegCursors = $RegConnect.OpenSubKey("Control Panel\Cursors",$true)
    $RegCursors.SetValue("","Posys Cursor")
    $RegCursors.SetValue("Scheme Source","1")
    # $RegCursors.SetValue("CursorBaseSize",0x20)
    $RegCursors.SetValue("AppStarting","%SYSTEMROOT%\Cursors\Posys Cursor\Posy background max 96.ani")
    $RegCursors.SetValue("Arrow","%SYSTEMROOT%\Cursors\Posys Cursor\Posy cursor.cur")
    $RegCursors.SetValue("Crosshair","%SYSTEMROOT%\Cursors\Posys Cursor\Posy precise.cur")
    $RegCursors.SetValue("Hand","%SYSTEMROOT%\Cursors\Posys Cursor\Posy hand.cur")
    $RegCursors.SetValue("Help","%SYSTEMROOT%\Cursors\Posys Cursor\Posy help.cur")
    $RegCursors.SetValue("IBeam","%SYSTEMROOT%\Cursors\Posys Cursor\Posy beam.cur")
    $RegCursors.SetValue("No","%SYSTEMROOT%\Cursors\Posys Cursor\Posy forbidden.cur")
    $RegCursors.SetValue("NWPen","%SYSTEMROOT%\Cursors\Posys Cursor\Posy pen.cur")
    $RegCursors.SetValue("SizeAll","%SYSTEMROOT%\Cursors\Posys Cursor\Posy move.cur")
    $RegCursors.SetValue("SizeNESW","%SYSTEMROOT%\Cursors\Posys Cursor\Posy size NeSw.cur")
    $RegCursors.SetValue("SizeNS","%SYSTEMROOT%\Cursors\Posys Cursor\Posy size NS.cur")
    $RegCursors.SetValue("SizeNWSE","%SYSTEMROOT%\Cursors\Posys Cursor\Posy size NwSe.cur")
    $RegCursors.SetValue("SizeWE","%SYSTEMROOT%\Cursors\Posys Cursor\Posy size EW.cur")
    $RegCursors.SetValue("UpArrow","%SYSTEMROOT%\Cursors\Posys Cursor\Posy alt.cur")
    $RegCursors.SetValue("Wait","%SYSTEMROOT%\Cursors\Posys Cursor\Posy wait max 96.ani")
    $RegCursors.Close()
    $RegConnect.Close()

    Update-UserPreferencesMask
}

if ($current_cursor -eq "Posy's Cursor Black") {
    Write-Message -Type WARNING  -Message 'Cursor already set. Skipping...'
} else {
    Write-Message -Message 'Cursor not set. Installing cursor and setting...'
    infdefaultinstall.exe $args
    Set-itemproperty "HKCU:\Control Panel\Cursors" -Name "(Default)" -Value "Posys Cursor Black"
    $RegConnect = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]"CurrentUser","$env:COMPUTERNAME")
    $RegCursors = $RegConnect.OpenSubKey("Control Panel\Cursors",$true)
    $RegCursors.SetValue("","Posys Cursor Black")
    $RegCursors.SetValue("Scheme Source","1")
    # $RegCursors.SetValue("CursorBaseSize",0x20)
    $RegCursors.SetValue("AppStarting","%SYSTEMROOT%\Cursors\Posys Cursor Black\Posy Black background max 96.ani")
    $RegCursors.SetValue("Arrow","%SYSTEMROOT%\Cursors\Posys Cursor Black\Posy Black default.cur")
    $RegCursors.SetValue("Crosshair","%SYSTEMROOT%\Cursors\Posys Cursor Black\Posy precise.cur")
    $RegCursors.SetValue("Hand","%SYSTEMROOT%\Cursors\Posys Cursor Black\Posy hand.cur")
    $RegCursors.SetValue("Help","%SYSTEMROOT%\Cursors\Posys Cursor Black\Posy Black help.cur")
    $RegCursors.SetValue("IBeam","%SYSTEMROOT%\Cursors\Posys Cursor Black\Posy beam.cur")
    $RegCursors.SetValue("No","%SYSTEMROOT%\Cursors\Posys Cursor Black\Posy forbidden.cur")
    $RegCursors.SetValue("NWPen","%SYSTEMROOT%\Cursors\Posys Cursor Black\Posy Black pen.cur")
    $RegCursors.SetValue("SizeAll","%SYSTEMROOT%\Cursors\Posys Cursor Black\Posy move.cur")
    $RegCursors.SetValue("SizeNESW","%SYSTEMROOT%\Cursors\Posys Cursor Black\Posy Black size NeSw.cur")
    $RegCursors.SetValue("SizeNS","%SYSTEMROOT%\Cursors\Posys Cursor Black\Posy Black size NS.cur")
    $RegCursors.SetValue("SizeNWSE","%SYSTEMROOT%\Cursors\Posys Cursor Black\Posy Black size NwSe.cur")
    $RegCursors.SetValue("SizeWE","%SYSTEMROOT%\Cursors\Posys Cursor Black\Posy Black size EW.cur")
    $RegCursors.SetValue("UpArrow","%SYSTEMROOT%\Cursors\Posys Cursor Black\Posy alt.cur")
    $RegCursors.SetValue("Wait","%SYSTEMROOT%\Cursors\Posys Cursor Black\Posy wait max 96.ani")
    $RegCursors.Close()
    $RegConnect.Close()

    Update-UserPreferencesMask
}
