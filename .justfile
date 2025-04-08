@_default:
	just --list

ppc_path := shell('command -v powerprofilesctl || true')
original_prof := if ppc_path != '' { shell('powerprofilesctl get') } else { '' }

_boost:
	{{ if ppc_path != '' { 'powerprofilesctl set performance' } else { '' } }}

_unboost:
	{{ if ppc_path != '' { 'powerprofilesctl set ' + original_prof } else { '' } }}

hswitch: _boost && _unboost
	home-manager switch --flake $(readlink -f ~/.config/home-manager)

add pkg: && hswitch
	sed -i '/SED_ADD_PKGS_HERE/a\    {{pkg}}' ~/.config/home-manager/home.nix

switch: _boost && _unboost
	sudo nixos-rebuild switch --flake $(readlink -f ~/.config/nix)#nixos

prune: _prune-nix _prune-docker

_prune-nix:
	sudo nix-collect-garbage -d
	sudo nix-collect-garbage
	nix-store --optimise

_prune-docker:
	podman container prune 
	podman image prune -a --external

_update-flake:
	nix flake update --flake $(readlink -f ~/.config/nix)#nixos

update: _update-flake switch
