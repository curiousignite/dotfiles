powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-AppxPackage -Path https://cdn.winget.microsoft.com/cache/source.msix"
powershell -NoProfile -ExecutionPolicy Bypass -Command "scripts/os/windows.ps1"
