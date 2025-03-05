default:
	just --list

hswitch:
	home-manager switch

add pkg: && hswitch
	sed -i $'/SED_ADD_PKGS_HERE/a\\\t{{pkg}}' ~/.config/home-manager/home.nix

switch:
	#!/usr/bin/env -S sh -xeu
	prof=$(powerprofilesctl get)
	powerprofilesctl set performance	
	sudo nixos-rebuild switch --flake $(readlink -f ~/.config/nix)
	powerprofilesctl set $prof 

prune: prune-nix prune-docker

prune-nix:
	sudo nix-collect-garbage -d
	sudo nix-collect-garbage
	nix-store --optimise

prune-docker:
	podman container prune 
	podman image prune -a --external

update-flake:
	nix flake update --flake $(readlink -f ~/.config/nix)

update: update-flake switch
