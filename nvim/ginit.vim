" Set Editor Font
if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    GuiFont Hack Nerd Font Mono:h16
else
  set guifont=Hack\ Nerd\ Font\ Mono:h16
endif
if exists(':GuiWindowOpacity')
    GuiWindowOpacity 0.87
endif
"Warning This feature is experimental. See related Issue
" if exists(':GuiClipboard')
"       call GuiClipboard()
"   endif
