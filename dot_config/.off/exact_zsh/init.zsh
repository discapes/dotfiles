# prompt
USE_STARSHIP=
if [[ -z $USE_STARSHIP && -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${USER}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${USER}.zsh"
else
	PROMPT='%(?.%F{blue}⏺.%F{red}⏺)%f %2~ > '
	RPROMPT='%F{8}⏱ %*%f'
fi
#
##
# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename ~/.zshrc

autoload -Uz compinit
compinit -d ~/.cache/.zcompdump
# End of lines added by compinstall

# run these if we are on a host with dotfiles installed
if [ -z "$SSH_CLIENT" ] && [ -f ~/.config/zsh/env.zsh ]; then
	source ~/.config/zsh/env.zsh
	[ -z "$WAYLAND_DISPLAY" ] && [ "$TTY" = "/dev/tty1" ] && exec Hyprland
	DISABLE_AUTO_UPDATE="true"

	if [ -n "$CONTAINER_ID" ]; then
		# we want to use the host podman in distrobox
		export CONTAINER_HOST=unix:///run/host/run/user/1000/podman/podman.sock
	fi

  if [ -n "$USE_STARSHIP" ]; then
    # export STARSHIP_CONFIG=~/.config/starship.toml
    eval "$(starship init zsh)"
  else
    source ~/.config/zsh/ohmyzsh.zsh
    source ~/.config/zsh/p10k.zsh
  fi
else
  command -v fastfetch &>/dev/null && fastfetch
  echo
  if command -v fortune &>/dev/null; then
    fortune
  elif [ -f /usr/games/fortune ]; then
    /usr/games/fortune
  fi
  echo Welcome, $USER.
fi

if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# options - after omz
HISTFILE=~/.cache/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt notify
setopt complete_aliases
unsetopt autocd beep extendedglob nomatch
bindkey -v

# these depend on brew, and zoxide depends on compinit
command -v mise &>/dev/null && eval "$(mise activate zsh)"
command -v zoxide &>/dev/null && eval "$(zoxide init zsh --cmd cd)"
command -v direnv &>/dev/null && eval "$(direnv hook zsh)"
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# this overrides some omz aliases
source ~/.config/zsh/aliases.zsh
