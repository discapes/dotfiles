#!/usr/bin/env bash
set -euo pipefail
set -x


DIR=`dirname -- "$( readlink -f -- "$0"; )";`

sudo nixos-rebuild switch --flake "$DIR"
GEN=`readlink /nix/var/nix/profiles/system | cut -d- -f2`
git -C "$DIR" commit -am "Generation $GEN"
