if [ -z "$SSH_CLIENT" ]; then
	# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
	# Initialization code that may require console input (password prompts, [y/n]
	# confirmations, etc.) must go above this block; everything else may go below.
	if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
	fi

	source ~/.config/zsh/env.zsh
	#[ -z "$WAYLAND_DISPLAY" ] && [ "$TTY" = "/dev/tty1" ] && exec Hyprland
	DISABLE_AUTO_UPDATE="true"
	source ~/.config/zsh/ohmyzsh.zsh
	source ~/.config/zsh/p10k.zsh

	if [ -n "$CONTAINER_ID" ]; then
		# we want to use the host podman in distrobox
		export CONTAINER_HOST=unix:///run/host/run/user/1000/podman/podman.sock
	fi
else
	PROMPT='%(?.%F{blue}⏺.%F{red}⏺)%f %2~ > '
	RPROMPT='%F{8}⏱ %*%f'
fi


source ~/.config/zsh/global_env.zsh
source ~/.config/zsh/aliases.zsh

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename ~/.zshrc

autoload -Uz compinit
compinit -d ~/.cache/.zcompdump
# End of lines added by compinstall


# HOOKS
command -v mise &>/dev/null && eval "$(mise activate zsh)"
command -v zoxide &>/dev/null && eval "$(zoxide init zsh --cmd cd)"
command -v direnv &>/dev/null && eval "$(direnv hook zsh)"
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
