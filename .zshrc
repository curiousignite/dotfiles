# Oh-my-zsh installation path
ZSH=/usr/share/oh-my-zsh/

# Powerlevel10k theme path
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# List of plugins used
plugins=( sudo zsh-256color zsh-autosuggestions zsh-syntax-highlighting )
source $ZSH/oh-my-zsh.sh

# Helpful aliases
alias c='clear' # clear terminal
alias l='eza -lh --icons=auto' # long list
alias ls='eza -1 --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all

# Directory navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
alias mkdir='mkdir -p'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Display Pokemon
# pokemon-colorscripts --no-title -r 1

export SUDO_EDITOR=/usr/bin/nvim
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim

# For setting python enviroment
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
