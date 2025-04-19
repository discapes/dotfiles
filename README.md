# dotfiles

**How to use:**  
`sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply discapes`  
OR  
`nix-shell -p chezmoi --run "chezmoi init --apply discapes"`

**Install software, tools, and utilities:**

- I manage installed software using home-manager instead of configuration.nix to reduce the overhead of installing new
  packages.
- Install them with `nix-shell -p home-manager just --run "just hswitch"` after installing Nix

**Install NixOS configuration, if using NixOS:**

- Run `mkpasswd | sudo tee /etc/passhash` to create an encrypted password used by the configuration
- Run `sudo nixos-rebuild boot --flake ~/.config/nix` to apply the NixOS configuration on the next boot
  - You can use `just switch` later to do the same thing
  - `just` is a make-like task runner that reads `~/.justfile`
- Reboot

**Install nix-darwin configuration, if using macOS:**

- Run `sudo nix run nix-darwin/nix-darwin-24.11#darwin-rebuild -- switch --flake ~/.config/nix-darwin#darwin` to apply
  the configuration
- You can use `just switch` later to do the same thing

TODO:

- neovim
  - better chezmoi integration
  - disable root detection
