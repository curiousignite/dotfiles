VimUnDoå °µúwZq¹ª;5ó6:B-Èôñü¶ãú¹m   }       ~                           fÜìÖ    _Ð                     _        ÿÿÿÿ                                                                                                                                                                                                                                                                                                                            d           _           V        fÜêá     õ   ^   _          ##   # Update windows theme   ##   Write-Host "   'Installing Catppuccin Explorer Themes"    <.$SCRIPTS_DIR/Install-Theme.ps1 "$GIT_DIR/themes/Explorer/*"5õ    ^                      Ò                     5_Ð                    T        ÿÿÿÿ                                                                                                                                                                                                                                                                                                                            _           _           V        fÜêä     õ   T   [   v    õ   T   U   v    5õ    T                                           5_Ð                    [        ÿÿÿÿ                                                                                                                                                                                                                                                                                                                            e           e           V        fÜêê     õ   Z   \   |    5õ    Z                      )                     5_Ð                    [        ÿÿÿÿ                                                                                                                                                                                                                                                                                                                            f           f           V        fÜêì    õ   }               õ               }   #   °# ââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ   °# ââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ   °# ââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ   #   # Set up Windows Configurations   ##       #Variables setup   HAdd-AppxPackage -Path https://cdn.winget.microsoft.com/cache/source.msix   /$global:GIT_DIR = git rev-parse --show-toplevel   2$global:SCRIPTS_DIR = $GIT_DIR+"/setup/os/windows"       #   2# ââââââââââââââââ   2# ââââââââââââââââ   2# ââââââââââââââââ   #   !# Set powershell execution policy   ##   =Write-Host "Setting powershell to allow execution of scripts"   >Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser       ##   # Install Powershell modules   ##   Write-Host "   Installing Powershell Modules"   !.$SCRIPTS_DIR/Install-Modules.ps1       #   ># ââââââââââââââââââââ   ># ââââââââââââââââââââ   ># ââââââââââââââââââââ   #   # Install fonts   ##   Write-Host "   Installing fonts"   0.$SCRIPTS_DIR/Install-Fonts.ps1 $GIT_DIR"/fonts"       #   ¼# ââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ   ¼# ââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ   ¼# ââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ   #   # Enable developer mode   ##   Write-Host "   -Enabling developer mode and Windows Features"   (.$SCRIPTS_DIR/Enable-WindowsFeatures.ps1       #   # ââââââââââââââââââââââââââââââââââââââââââââââââ   # ââââââââââââââââââââââââââââââââââââââââââââââââ   # ââââââââââââââââââââââââââââââââââââââââââââââââ   #   # Install software   ##   Write-Host "   Installing software."   ".$SCRIPTS_DIR/Install-Programs.ps1       #   V# ââââââââââââââââââââââââââââ   V# ââââââââââââââââââââââââââââ   V# ââââââââââââââââââââââââââââ   # Install themes   ##       ##   # Customize windows taskbar   ##   Write-Host "   Customizing the taskbar"   #.$SCRIPTS_DIR/Customize-Taskbar.ps1       ##   # Customize windows explorer   ##   Write-Host "   Customizing explorer"   $.$SCRIPTS_DIR/Customize-Explorer.ps1       ##   # Update windows theme   ##   Write-Host "   'Installing Catppuccin Explorer Themes"    <.$SCRIPTS_DIR/Install-Theme.ps1 "$GIT_DIR/themes/Explorer/*"       ##   # Customize cursor   ##   Write-Host "   Installing Posy's Cursor"   b.$SCRIPTS_DIR/Install-Cursor.ps1 "$GIT_DIR//themes/Cursors/Posys Cursor/_install Posy Default.inf"   Write-Host "   Installing Posy's Cursor Black"   f.$SCRIPTS_DIR/Install-Cursor.ps1 "$GIT_DIR//themes/Cursors/Posys Cursor Black/_install Posy Black.inf"           # Need to test on VM first   #   # Write-Host "   %# Setting Catppuccin Windows Colors"    !#.$SCRIPTS_DIR/Color-Explorer.ps1       #   # ââââââââââââââââââââââââââââââââââââââââââââââââââââ   # ââââââââââââââââââââââââââââââââââââââââââââââââââââ   # ââââââââââââââââââââââââââââââââââââââââââââââââââââ   #   # Copy/Link Config Files   ##   Write-Host "   Installing Config Files"    .$SCRIPTS_DIR/Configure-Apps.ps1       Write-Host "   Adding programs to startup"   .$SCRIPTS_DIR/Startup.ps1       Write-Host "   S[!!] Dotfiles finished installation. Some changes require a reboot to take effect!"5õ            |   S   }               Á      Â      õ    }                      Â                     5_Ð                    a   +    ÿÿÿÿ                                                                                                                                                                                                                                                                                                                                                  V        fÜìÅ     õ   `   b   }      b.$SCRIPTS_DIR/Install-Cursor.ps1 "$GIT_DIR//themes/Cursors/Posys Cursor/_install Posy Default.inf"5õ    `   +                                       5_Ð                    d   +    ÿÿÿÿ                                                                                                                                                                                                                                                                                                                                                  V        fÜìÇ     õ   c   e   }      f.$SCRIPTS_DIR/Install-Cursor.ps1 "$GIT_DIR//themes/Cursors/Posys Cursor Black/_install Posy Black.inf"5õ    c   +                  $                     5_Ð                     e        ÿÿÿÿ                                                                                                                                                                                                                                                                                                                                                  V        fÜìÕ    õ   }               õ               }   #   °# ââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ   °# ââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ   °# ââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ   #   # Set up Windows Configurations   ##       #Variables setup   HAdd-AppxPackage -Path https://cdn.winget.microsoft.com/cache/source.msix   /$global:GIT_DIR = git rev-parse --show-toplevel   2$global:SCRIPTS_DIR = $GIT_DIR+"/setup/os/windows"       #   2# ââââââââââââââââ   2# ââââââââââââââââ   2# ââââââââââââââââ   #   !# Set powershell execution policy   ##   =Write-Host "Setting powershell to allow execution of scripts"   >Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser       ##   # Install Powershell modules   ##   Write-Host "   Installing Powershell Modules"   !.$SCRIPTS_DIR/Install-Modules.ps1       #   ># ââââââââââââââââââââ   ># ââââââââââââââââââââ   ># ââââââââââââââââââââ   #   # Install fonts   ##   Write-Host "   Installing fonts"   0.$SCRIPTS_DIR/Install-Fonts.ps1 $GIT_DIR"/fonts"       #   ¼# ââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ   ¼# ââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ   ¼# ââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ   #   # Enable developer mode   ##   Write-Host "   -Enabling developer mode and Windows Features"   (.$SCRIPTS_DIR/Enable-WindowsFeatures.ps1       #   # ââââââââââââââââââââââââââââââââââââââââââââââââ   # ââââââââââââââââââââââââââââââââââââââââââââââââ   # ââââââââââââââââââââââââââââââââââââââââââââââââ   #   # Install software   ##   Write-Host "   Installing software."   ".$SCRIPTS_DIR/Install-Programs.ps1       #   V# ââââââââââââââââââââââââââââ   V# ââââââââââââââââââââââââââââ   V# ââââââââââââââââââââââââââââ   # Install themes   ##       ##   # Customize windows taskbar   ##   Write-Host "   Customizing the taskbar"   #.$SCRIPTS_DIR/Customize-Taskbar.ps1       ##   # Customize windows explorer   ##   Write-Host "   Customizing explorer"   $.$SCRIPTS_DIR/Customize-Explorer.ps1       ##   # Update windows theme   ##   Write-Host "   'Installing Catppuccin Explorer Themes"    <.$SCRIPTS_DIR/Install-Theme.ps1 "$GIT_DIR/themes/Explorer/*"       ##   # Customize cursor   ##   Write-Host "   Installing Posy's Cursor"   a.$SCRIPTS_DIR/Install-Cursor.ps1 "$GIT_DIR/themes/Cursors/Posys Cursor/_install Posy Default.inf"   Write-Host "   Installing Posy's Cursor Black"   e.$SCRIPTS_DIR/Install-Cursor.ps1 "$GIT_DIR/themes/Cursors/Posys Cursor Black/_install Posy Black.inf"           # Need to test on VM first   #   # Write-Host "   %# Setting Catppuccin Windows Colors"    !#.$SCRIPTS_DIR/Color-Explorer.ps1       #   # ââââââââââââââââââââââââââââââââââââââââââââââââââââ   # ââââââââââââââââââââââââââââââââââââââââââââââââââââ   # ââââââââââââââââââââââââââââââââââââââââââââââââââââ   #   # Copy/Link Config Files   ##   Write-Host "   Installing Config Files"    .$SCRIPTS_DIR/Configure-Apps.ps1       Write-Host "   Adding programs to startup"   .$SCRIPTS_DIR/Startup.ps1       Write-Host "   S[!!] Dotfiles finished installation. Some changes require a reboot to take effect!"5õ            |   S   }               ¿      À      õ    }                      À                     5çª