#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/berke/.lmstudio/bin"
# End of LM Studio CLI section



# Added by Antigravity CLI installer
export PATH="/home/berke/.local/bin:$PATH"
