Vim�UnDo� �N2��F��/=hq�FK5�Ж��!�"���U,F                     (       (   (   (    f��j   	 _�                             ����                                                                                                                                                                                                                                                                                                                                                  V        fܲI     �             �             5��                          *              4       5�_�                       	    ����                                                                                                                                                                                                                                                                                                                                                  V        fܲK     �                function which {5��       	                 3                    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        fܲS     �                     param($bin) Get-Command $bin5��                        C                    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        fܲV     �                !    param($file) Get-Command $bin5��                        V                    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        fܲY     �                "    param($file) Get-Command $file5��                        I                    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        fܲ^    �                   �                   -# $scripts = "$(Split-Path $PROFILE)\Scripts"   -# $modules = "$(Split-Path $PROFILE)\Modules"   8# $desktop =  $(resolve-path "$Env:userprofile\desktop")       n# oh-my-posh init pwsh --config 'C:\Users\berke\posh\Themes\catppuccin\catppuccin.omp.json'| Invoke-Expression   boh-my-posh init pwsh --config $HOME\posh\themes\catppuccin\catppuccin.omp.json | Invoke-Expression   .Import-Module git-aliases -DisableNameChecking   Import-Module PSReadLine   VImport-Module 'C:\Users\berke\.config\PowerShell\Modules\translate\0.1\translate.psm1'   @$Env:KOMOREBI_CONFIG_HOME = 'C:\\Users\berke\\.config\\komorebi'       function fastfetch_wrapper {       param (           [object[]]$Object       )       Write-Host $Object   }       function ll {   !    # Get-ChildItem -Force $args        eza -la --hyperlink   }   function which {        param($bin) Get-Command $bin   }   function img{   %    param($file) wezterm imgcat $file   }   function clr {       Clear-Host;       fastfetch   }5��                                  �      �      �                           �                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             f��6     �      
        �      	        5��                          �                     5�_�      	              	       ����                                                                                                                                                                                                                                                                                                                                                             f��8     �      
   !      Import-Module PSReadLine5��              
       	   �      
       	       5�_�      
           	   
        ����                                                                                                                                                                                                                                                                                                                            
          
          V       f��@     �   	      !      VImport-Module 'C:\Users\berke\.config\PowerShell\Modules\translate\0.1\translate.psm1'5��    	                     �      W       Y       5�_�   	              
   
        ����                                                                                                                                                                                                                                                                                                                            
          
          V       f��A    �   !               �               !   -# $scripts = "$(Split-Path $PROFILE)\Scripts"   -# $modules = "$(Split-Path $PROFILE)\Modules"   8# $desktop =  $(resolve-path "$Env:userprofile\desktop")       n# oh-my-posh init pwsh --config 'C:\Users\berke\posh\Themes\catppuccin\catppuccin.omp.json'| Invoke-Expression   boh-my-posh init pwsh --config $HOME\posh\themes\catppuccin\catppuccin.omp.json | Invoke-Expression   .Import-Module git-aliases -DisableNameChecking   Import-Module PSReadLine   Import-Module translate   X# Import-Module 'C:\Users\berke\.config\PowerShell\Modules\translate\0.1\translate.psm1'   @$Env:KOMOREBI_CONFIG_HOME = 'C:\\Users\berke\\.config\\komorebi'       function fastfetch_wrapper {       param (           [object[]]$Object       )       Write-Host $Object   }       function ll {   !    # Get-ChildItem -Force $args        eza -la --hyperlink   }   function which {        param($bin) Get-Command $bin   }   function img{   %    param($file) wezterm imgcat $file   }   function clr {       Clear-Host;       fastfetch   }5��                   !               �      �      �    !                      �                     5�_�   
                 
        ����                                                                                                                                                                                                                                                                                                                                                V       f��A    �   !               �               !   -# $scripts = "$(Split-Path $PROFILE)\Scripts"   -# $modules = "$(Split-Path $PROFILE)\Modules"   8# $desktop =  $(resolve-path "$Env:userprofile\desktop")       n# oh-my-posh init pwsh --config 'C:\Users\berke\posh\Themes\catppuccin\catppuccin.omp.json'| Invoke-Expression   boh-my-posh init pwsh --config $HOME\posh\themes\catppuccin\catppuccin.omp.json | Invoke-Expression   .Import-Module git-aliases -DisableNameChecking   Import-Module PSReadLine   Import-Module translate   X# Import-Module 'C:\Users\berke\.config\PowerShell\Modules\translate\0.1\translate.psm1'   @$Env:KOMOREBI_CONFIG_HOME = 'C:\\Users\berke\\.config\\komorebi'       function fastfetch_wrapper {       param (           [object[]]$Object       )       Write-Host $Object   }       function ll {   !    # Get-ChildItem -Force $args        eza -la --hyperlink   }   function which {        param($bin) Get-Command $bin   }   function img{   %    param($file) wezterm imgcat $file   }   function clr {       Clear-Host;       fastfetch   }5��                   !               �      �      �    !                      �                     5�_�                    	       ����                                                                                                                                                                                                                                                                                                                                                             f��V     �      
   !      Import-Module translate5��              	          �      	              5�_�                    	       ����                                                                                                                                                                                                                                                                                                                                                             f��^     �      
   !      Import-Module $HOME\.5��                         �                     �                         �                     �                         �                     �                         �                     �                         �                     �                         �                     �                         �                     �                         �                     �                         �                     �                         �                     �                         �                     �                         �                     �                         �                     �                        �                    5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             f��     �         !      -# $modules = "$(Split-Path $PROFILE)\Modules"5��                         .       .       ,       5�_�                    	       ����                                                                                                                                                                                                                                                                                                                                                             f��     �      
   !      Import-Module $PROFILE5��                         �                     5�_�                    	       ����                                                                                                                                                                                                                                                                                                                                                             f��     �      
   !      Import-Module 5��                         �                     5�_�                    	        ����                                                                                                                                                                                                                                                                                                                                                             f��     �      
   !       Import-Module $modules\translate5��                          �                     5�_�                    	   #    ����                                                                                                                                                                                                                                                                                                                                                             f��     �      
   !      #Import-Module $modules\translate\0.5��       #                  �                     5�_�                    	   /    ����                                                                                                                                                                                                                                                                                                                                                             f��     �      
   !      /Import-Module $modules\translate\0.1\translate.5��       /                  �                     5�_�                    	   2    ����                                                                                                                                                                                                                                                                                                                                                             f��    �   !               �               !   -# $scripts = "$(Split-Path $PROFILE)\Scripts"   +$modules = "$(Split-Path $PROFILE)\Modules"   8# $desktop =  $(resolve-path "$Env:userprofile\desktop")       n# oh-my-posh init pwsh --config 'C:\Users\berke\posh\Themes\catppuccin\catppuccin.omp.json'| Invoke-Expression   boh-my-posh init pwsh --config $HOME\posh\themes\catppuccin\catppuccin.omp.json | Invoke-Expression   .Import-Module git-aliases -DisableNameChecking   Import-Module PSReadLine   3Import-Module $modules\translate\0.1\translate.psm1   X# Import-Module 'C:\Users\berke\.config\PowerShell\Modules\translate\0.1\translate.psm1'   @$Env:KOMOREBI_CONFIG_HOME = 'C:\\Users\berke\\.config\\komorebi'       function fastfetch_wrapper {       param (           [object[]]$Object       )       Write-Host $Object   }       function ll {   !    # Get-ChildItem -Force $args        eza -la --hyperlink   }   function which {        param($bin) Get-Command $bin   }   function img{   %    param($file) wezterm imgcat $file   }   function clr {       Clear-Host;       fastfetch   }5��                   !               �      �      �    !                      �                     5�_�                    
   2    ����                                                                                                                                                                                                                                                                                                                                                             f��     �   	   
          X# Import-Module 'C:\Users\berke\.config\PowerShell\Modules\translate\0.1\translate.psm1'5��    	                      �      Y               5�_�                   
       ����                                                                                                                                                                                                                                                                                                                                                             f���     �   
           �   
           5��    
                      #              A       5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             f���     �   
      !      @$Env:KOMOREBI_CONFIG_HOME = 'C:\\Users\berke\\.config\\komorebi'5��    
          $       
   ?      $       
       5�_�                       &    ����                                                                                                                                                                                                                                                                                                                                                             f���     �   
      !      &$Env:KOMOREBI_CONFIG_HOME = $profile\.5��    
   &                  I                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             f���     �   
      !      5$Env:KOMOREBI_CONFIG_HOME = $profile\.config\komorebi5��    
                     ?                     5�_�                       6    ����                                                                                                                                                                                                                                                                                                                                                             f���     �   
      !      6$Env:KOMOREBI_CONFIG_HOME = "$profile\.config\komorebi5��    
   6                  Y                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             f���     �   
      !      7$Env:KOMOREBI_CONFIG_HOME = "$profile\.config\komorebi"5��    
                    A                    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             f��    �   !               �               !   -# $scripts = "$(Split-Path $PROFILE)\Scripts"   +$modules = "$(Split-Path $PROFILE)\Modules"   8# $desktop =  $(resolve-path "$Env:userprofile\desktop")       n# oh-my-posh init pwsh --config 'C:\Users\berke\posh\Themes\catppuccin\catppuccin.omp.json'| Invoke-Expression   boh-my-posh init pwsh --config $HOME\posh\themes\catppuccin\catppuccin.omp.json | Invoke-Expression   .Import-Module git-aliases -DisableNameChecking   Import-Module PSReadLine   3Import-Module $modules\translate\0.1\translate.psm1   @$Env:KOMOREBI_CONFIG_HOME = 'C:\\Users\berke\\.config\\komorebi'   7$Env:KOMOREBI_CONFIG_HOME = "$PROFILE\.config\komorebi"       function fastfetch_wrapper {       param (           [object[]]$Object       )       Write-Host $Object   }       function ll {   !    # Get-ChildItem -Force $args        eza -la --hyperlink   }   function which {        param($bin) Get-Command $bin   }   function img{   %    param($file) wezterm imgcat $file   }   function clr {       Clear-Host;       fastfetch   }5��                   !               �      �      �    !                      �                     5�_�                             ����                                                                                                                                                                                                                                                                                                                                                             f��    �   !               �               !   -# $scripts = "$(Split-Path $PROFILE)\Scripts"   +$modules = "$(Split-Path $PROFILE)\Modules"   8# $desktop =  $(resolve-path "$Env:userprofile\desktop")       n# oh-my-posh init pwsh --config 'C:\Users\berke\posh\Themes\catppuccin\catppuccin.omp.json'| Invoke-Expression   boh-my-posh init pwsh --config $HOME\posh\themes\catppuccin\catppuccin.omp.json | Invoke-Expression   .Import-Module git-aliases -DisableNameChecking   Import-Module PSReadLine   3Import-Module $modules\translate\0.1\translate.psm1   @$Env:KOMOREBI_CONFIG_HOME = 'C:\\Users\berke\\.config\\komorebi'   7$Env:KOMOREBI_CONFIG_HOME = "$PROFILE\.config\komorebi"       function fastfetch_wrapper {       param (           [object[]]$Object       )       Write-Host $Object   }       function ll {   !    # Get-ChildItem -Force $args        eza -la --hyperlink   }   function which {        param($bin) Get-Command $bin   }   function img{   %    param($file) wezterm imgcat $file   }   function clr {       Clear-Host;       fastfetch   }5��                   !               �      �      �    !                      �                     5�_�      !               
        ����                                                                                                                                                                                                                                                                                                                                                 v       f��     �   	      !      @$Env:KOMOREBI_CONFIG_HOME = 'C:\\Users\berke\\.config\\komorebi'5��    	                     �      A       C       5�_�       "           !   
        ����                                                                                                                                                                                                                                                                                                                                                 v       f��    �   !               �               !   -# $scripts = "$(Split-Path $PROFILE)\Scripts"   +$modules = "$(Split-Path $PROFILE)\Modules"   8# $desktop =  $(resolve-path "$Env:userprofile\desktop")       n# oh-my-posh init pwsh --config 'C:\Users\berke\posh\Themes\catppuccin\catppuccin.omp.json'| Invoke-Expression   boh-my-posh init pwsh --config $HOME\posh\themes\catppuccin\catppuccin.omp.json | Invoke-Expression   .Import-Module git-aliases -DisableNameChecking   Import-Module PSReadLine   3Import-Module $modules\translate\0.1\translate.psm1   B# $Env:KOMOREBI_CONFIG_HOME = 'C:\\Users\berke\\.config\\komorebi'   7$Env:KOMOREBI_CONFIG_HOME = "$PROFILE\.config\komorebi"       function fastfetch_wrapper {       param (           [object[]]$Object       )       Write-Host $Object   }       function ll {   !    # Get-ChildItem -Force $args        eza -la --hyperlink   }   function which {        param($bin) Get-Command $bin   }   function img{   %    param($file) wezterm imgcat $file   }   function clr {       Clear-Host;       fastfetch   }5��                   !               �      �      �    !                      �                     5�_�   !   #           "          ����                                                                                                                                                                                                                                                                                                                                                 v       f��3     �   
      !      7$Env:KOMOREBI_CONFIG_HOME = "$PROFILE\.config\komorebi"5��    
                    C                    5�_�   "   $           #      !    ����                                                                                                                                                                                                                                                                                                                                                 v       f��6    �   !               �               !   -# $scripts = "$(Split-Path $PROFILE)\Scripts"   +$modules = "$(Split-Path $PROFILE)\Modules"   8# $desktop =  $(resolve-path "$Env:userprofile\desktop")       n# oh-my-posh init pwsh --config 'C:\Users\berke\posh\Themes\catppuccin\catppuccin.omp.json'| Invoke-Expression   boh-my-posh init pwsh --config $HOME\posh\themes\catppuccin\catppuccin.omp.json | Invoke-Expression   .Import-Module git-aliases -DisableNameChecking   Import-Module PSReadLine   3Import-Module $modules\translate\0.1\translate.psm1   B# $Env:KOMOREBI_CONFIG_HOME = 'C:\\Users\berke\\.config\\komorebi'   4$Env:KOMOREBI_CONFIG_HOME = "$HOME\.config\komorebi"       function fastfetch_wrapper {       param (           [object[]]$Object       )       Write-Host $Object   }       function ll {   !    # Get-ChildItem -Force $args        eza -la --hyperlink   }   function which {        param($bin) Get-Command $bin   }   function img{   %    param($file) wezterm imgcat $file   }   function clr {       Clear-Host;       fastfetch   }5��                   !               �      �      �    !                      �                     5�_�   #   %           $   
   !    ����                                                                                                                                                                                                                                                                                                                                                 v       f��G     �   	   
          B# $Env:KOMOREBI_CONFIG_HOME = 'C:\\Users\berke\\.config\\komorebi'5��    	                      �      C               5�_�   $   &           %      !    ����                                                                                                                                                                                                                                                                                                                                                 v       f��S     �                n# oh-my-posh init pwsh --config 'C:\Users\berke\posh\Themes\catppuccin\catppuccin.omp.json'| Invoke-Expression5��                          �       o               5�_�   %   '           &      !    ����                                                                                                                                                                                                                                                                                                                                                 v       f��Y     �                 -# $scripts = "$(Split-Path $PROFILE)\Scripts"5��                                   .               5�_�   &   (           '      !    ����                                                                                                                                                                                                                                                                                                                                                 v       f��Z     �             �             5��                          ,               .       5�_�   '               (           ����                                                                                                                                                                                                                                                                                                                                                 v       f��i   	 �                  �                  +$modules = "$(Split-Path $PROFILE)\Modules"   -# $scripts = "$(Split-Path $PROFILE)\Scripts"   8# $desktop =  $(resolve-path "$Env:userprofile\desktop")       boh-my-posh init pwsh --config $HOME\posh\themes\catppuccin\catppuccin.omp.json | Invoke-Expression   .Import-Module git-aliases -DisableNameChecking   Import-Module PSReadLine   3Import-Module $modules\translate\0.1\translate.psm1   4$Env:KOMOREBI_CONFIG_HOME = "$HOME\.config\komorebi"       function fastfetch_wrapper {       param (           [object[]]$Object       )       Write-Host $Object   }       function ll {   !    # Get-ChildItem -Force $args        eza -la --hyperlink   }   function which {        param($bin) Get-Command $bin   }   function img{   %    param($file) wezterm imgcat $file   }   function clr {       Clear-Host;       fastfetch   }5��                                 �      �      �                          �                     5�_�                       $    ����                                                                                                                                                                                                                                                                                                                                                             f��      �   
      !      7$Env:KOMOREBI_CONFIG_HOME = "$PROFILE\.config\komorebi"5��    
   7                  Z                     5�_�                    
       ����                                                                                                                                                                                                                                                                                                                                                             f���     �   	             $$Env:KOMOREBI_CONFIG_HOME = $profile5��    	          $          �      $              5��