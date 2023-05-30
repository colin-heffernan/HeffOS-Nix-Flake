# Powerlevel10k instant prompt
# if [[ -r "${XDF_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
# 	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Aliases
# alias ls="ls -lah --color=auto"							# Format ls
# alias mkdir="mkdir -pv"								# Create parent directories in mkdir
# alias mv="mv -i"								# Add confirmations to mv
# alias cp="cp -i"								# Add confirmations to cp
# alias rm="rm -i"								# Add confirmations to rm
# alias ln="ln -i"								# Add confirmations to ln
alias ssn="sudo shutdown now"							# Shut down the system
alias srn="sudo reboot now"							# Reboot the system
alias lg="lazygit"								# Shorthand for lazygit

# Options
export SAVEHIST=1000
unsetopt beep
bindkey -e
export EDITOR="hx"
export VISUAL="hx"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_THEME="Enki-Tokyo-Night"

# Apply Powerlevel10k theme
source ~/.p10k.zsh

# Hook direnv
eval "$(direnv hook zsh)"

# Setup Zoxide
eval "$(zoxide init zsh)"
