set unstable := true

@_default:
    just --list

switch := 'switch'
ppc_path := which('powerprofilesctl')
original_prof := if ppc_path != '' { shell('powerprofilesctl get') } else { '' }

_boost:
    {{ if ppc_path != '' { 'powerprofilesctl set performance' } else { '' } }}

_unboost:
    {{ if ppc_path != '' { 'powerprofilesctl set ' + original_prof } else { '' } }}

hswitch: _boost && _unboost
    home-manager switch --flake $(readlink -f ~/.config/home-manager)

[linux]
add pkg: && hswitch
    sed -i '/SED_ADD_PKGS_HERE/a\    {{ pkg }}' ~/.config/home-manager/home.nix

[macos]
add pkg: && hswitch
    sed -i '' $'s/SED_ADD_PKGS_HERE/&\\\n    {{ pkg }}/' ~/.config/home-manager/home.nix

[linux]
switch switch=(switch): _boost && _unboost
    sudo nixos-rebuild {{ switch }} --flake $(readlink -f ~/.config/nix)#nixos

[macos]
switch switch='switch':
    # doesn't work as sudo
    darwin-rebuild {{ switch }} --flake $(readlink -f ~/.config/nix-darwin)#darwin

prune: _prune-nix _prune-docker

_prune-nix:
    sudo nix-collect-garbage -d
    sudo nix-collect-garbage
    nix-store --optimise

_prune-docker:
    podman container prune 
    podman image prune -a --external

[macos]
_update-flake:
    nix flake update --flake $(readlink -f ~/.config/nix-darwin)

[linux]
_update-flake:
    nix flake update --flake $(readlink -f ~/.config/nix)

_update-home-flake:
    nix flake update --flake $(readlink -f ~/.config/home-manager)

_update-brew:
    brew update
    brew upgrade

[linux]
update: _update-home-flake hswitch _update-flake switch

[macos]
update: _update-brew _update-home-flake hswitch _update-flake switch
