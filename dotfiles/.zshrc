# Aliases
alias ssn="sudo shutdown now"							# Shut down the system
alias srn="sudo reboot now"		  					# Reboot the system
alias lg="lazygit"      		  						# Shorthand for lazygit

# Options
export SAVEHIST=1000
unsetopt beep
bindkey -e
export EDITOR="hx"
export VISUAL="hx"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_THEME="Enki-Tokyo-Night"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Apply Powerlevel10k theme
# source ~/.p10k.zsh

# Hook direnv
eval "$(direnv hook zsh)"
