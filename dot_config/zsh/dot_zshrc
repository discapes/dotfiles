if [ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${USER}.zsh" ]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${USER}.zsh"
else
	PROMPT='%(?.%F{blue}⏺.%F{red}⏺)%f %2~ > '
	RPROMPT='%F{8}⏱ %*%f'
fi

### HOOKS (they add commands which aliases.zsh looks for
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi                                             # added by Nix installer
if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh; fi # on macOS
if [ -e /opt/homebrew/bin/brew ]; then eval "$(/opt/homebrew/bin/brew shellenv)"; fi

### this has no deps
source ~/.config/zsh/global_env.zsh

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename ~/.zshrc

autoload -Uz compinit
compinit -d ~/.cache/.zcompdump
# End of lines added by compinstall

if [ -z "$SSH_CLIENT" ]; then
	source ~/.config/zsh/env.zsh
	[ -z "$WAYLAND_DISPLAY" ] && [ "$TTY" = "/dev/tty1" ] && exec Hyprland
	DISABLE_AUTO_UPDATE="true"

	if [ -n "$CONTAINER_ID" ]; then
		# we want to use the host podman in distrobox
		export CONTAINER_HOST=unix:///run/host/run/user/1000/podman/podman.sock
	fi
	source ~/.config/zsh/ohmyzsh.zsh
	source ~/.config/zsh/p10k.zsh
fi

# these depend on brew, and zoxide depends on compinit
command -v mise &>/dev/null && eval "$(mise activate zsh)"
command -v zoxide &>/dev/null && eval "$(zoxide init zsh --cmd cd)"
command -v direnv &>/dev/null && eval "$(direnv hook zsh)"

# this overrides some omz aliases
source ~/.config/zsh/aliases.zsh
