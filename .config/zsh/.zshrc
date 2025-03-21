source ~/.config/zsh/env.zsh
setopt complete_aliases

#[ -z "$WAYLAND_DISPLAY" ] && [ "$TTY" = "/dev/tty1" ] && exec Hyprland

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

DISABLE_AUTO_UPDATE="true"
source ~/.config/zsh/ohmyzsh.zsh
source ~/.config/zsh/p10k.zsh

if [ -z "$CONTAINER_ID" ]; then
	# no aliases in distrobox
	source ~/.config/zsh/aliases.zsh
else
	# we want to use the host podman in distrobox
	export CONTAINER_HOST=unix:///run/host/run/user/1000/podman/podman.sock
fi


###########################
#
#
# Lines configured by zsh-newuser-install
HISTFILE=~/.local/state/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt notify
unsetopt autocd beep extendedglob nomatch
bindkey -v
# End of lines configured by zsh-newuser-install



# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename ~/.zshrc

autoload -Uz compinit
compinit
# End of lines added by compinstall

if command -v zoxide &>/dev/null; then
	eval "$(zoxide init zsh --cmd cd)"
fi
if command -v mise &>/dev/null; then
	eval "$(mise activate zsh)"
fi

if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
eval "$(direnv hook zsh)"
