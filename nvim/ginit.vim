" Enable Mouse
set mouse=a
" Set Editor Font
if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    GuiFont Hack Nerd Font Mono:h14
else
  set guifont=Hack\ Nerd\ Font\ Mono:h16
endif
if exists(':GuiWindowOpacity')
     GuiWindowOpacity 0.9
endif
" Disable GUI Tabline
if exists(':GuiTabline')
    GuiTabline 0
endif

" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
    GuiPopupmenu 0
endif

" Enable GUI ScrollBar
if exists(':GuiScrollBar')
    GuiScrollBar 1
endif
