@_default:
	just --list

original_prof := shell('powerprofilesctl get')

_boost:
	powerprofilesctl set performance

_unboost:
	powerprofilesctl set {{original_prof}}

hswitch: _boost && _unboost
	home-manager switch

add pkg: && hswitch
	sed -i '/SED_ADD_PKGS_HERE/a\    {{pkg}}' ~/.config/home-manager/home.nix

switch: _boost && _unboost
	# not needed because we use just variables instead of $()
	##!/usr/bin/env -S sh -xeu
	sudo nixos-rebuild switch --flake $(readlink -f ~/.config/nix)

prune: _prune-nix _prune-docker

_prune-nix:
	sudo nix-collect-garbage -d
	sudo nix-collect-garbage
	nix-store --optimise

_prune-docker:
	podman container prune 
	podman image prune -a --external

_update-flake:
	nix flake update --flake $(readlink -f ~/.config/nix)

update: _update-flake switch
