#  Startup 
# Commands to execute on startup (before the prompt is shown)
# Check if the interactive shell option is set
# if [[ $- == *i* ]]; then
#     # This is a good place to load graphic/ascii art, display system information, etc.
#     if command -v pokego >/dev/null; then
#         pokego --no-title -r 1
#     elif command -v pokemon-colorscripts >/dev/null; then
#         pokemon-colorscripts --no-title -r 1
#     elif command -v fastfetch >/dev/null; then
#         if do_render "image"; then
#             fastfetch --logo-type kitty
#         fi
#     fi
# fi

#   Overrides 
# HYDE_ZSH_NO_PLUGINS=1 # Set to 1 to disable loading of oh-my-zsh plugins, useful if you want to use your zsh plugins system 
# unset HYDE_ZSH_PROMPT # Uncomment to unset/disable loading of prompts from HyDE and let you load your own prompts
# HYDE_ZSH_COMPINIT_CHECK=1 # Set 24 (hours) per compinit security check // lessens startup time
# HYDE_ZSH_OMZ_DEFER=1 # Set to 1 to defer loading of oh-my-zsh plugins ONLY if prompt is already loaded

if [[ ${HYDE_ZSH_NO_PLUGINS} != "1" ]]; then
    #  OMZ Plugins 
    # manually add your oh-my-zsh plugins here
    plugins=(
        "sudo"
    )
fi

alias pwc='pwd | wl-copy'
alias man='noglob man'
alias icat='kitten icat'
#Edited for LOCAL
. /etc/locale.conf
export LANG LC_MONETARY LC_TIME


# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete
[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# This will be our new default `ctrl+w` command
my-backward-delete-word() {
    # Copy the global WORDCHARS variable to a local variable. That way any
    # modifications are scoped to this function only
    local WORDCHARS=$WORDCHARS
    # Use bash string manipulation to remove `:` so our delete will stop at it
    WORDCHARS="${WORDCHARS//:}"
    # Use bash string manipulation to remove `/` so our delete will stop at it
    WORDCHARS="${WORDCHARS//\/}"
    # Use bash string manipulation to remove `.` so our delete will stop at it
    WORDCHARS="${WORDCHARS//.}"
    # zle <widget-name> will run an existing widget.
    zle backward-delete-word
}
# `zle -N` will create a new widget that we can use on the command line
zle -N my-backward-delete-word
# bind this new widget to `ctrl+w`
bindkey '^W' my-backward-delete-word

# This will be our `ctrl+alt+w` command
my-backward-delete-whole-word() {
    # Copy the global WORDCHARS variable to a local variable. That way any
    # modifications are scoped to this function only
    local WORDCHARS=$WORDCHARS
    # Use bash string manipulation to add `:` to WORDCHARS if it's not present
    # already.
    [[ ! $WORDCHARS == *":"* ]] && WORDCHARS="$WORDCHARS"":"
    # zle <widget-name> will run that widget.
    zle backward-delete-word
}
# `zle -N` will create a new widget that we can use on the command line
zle -N my-backward-delete-whole-word
# bind this new widget to `ctrl+alt+w`
bindkey '^[^w' my-backward-delete-whole-word
bindkey '^ ' autosuggest-accept
# autosuggest-accept: Accepts the current suggestion.
# autosuggest-execute: Accepts and executes the current suggestion.
# autosuggest-clear: Clears the current suggestion.
# autosuggest-fetch: Fetches a suggestion (works even when suggestions are disabled).
# autosuggest-disable: Disables suggestions.
