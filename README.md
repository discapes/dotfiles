# dotfiles

**How to use:**
- Clone the git repo anywhere like `~/code/dotfiles`
- Run `~/code/dotfiles/.local/bin/dotstow` to symlink the dotfiles to `~`
- Run `~/.local/bin/omz` to install oh-my-zsh, powerlevel10k, zsh-autosuggestions and zsh-syntax-highlighting to `~/.oh-my-zsh`

**Install software, tools and utilities:**
- I manage installed software using home-manager instead of configuration.nix to reduce the overhead of installing new packages
- Install them with `nix-shell -p home-manager just --run "just hswitch"` after installing Nix

**Install NixOS configuration, if using NixOS:**
- Run `mkpasswd | sudo tee /etc/passhash` to create an encrypted password used by the configuration
- Run `sudo nixos-rebuild boot --flake $(readlink -f ~/.config/nix)` to apply the NixOS configuration on the next boot
  - You can use `just switch` later to do the same thing 
  - `just` is a make-like task runner that reads `~/.justfile`
- Reboot

**Install nix-darwin configuration, if using macOS:**
- Run `sudo nix run nix-darwin/nix-darwin-24.11#darwin-rebuild -- switch --flake $(readlink -f ~/.config/nix-darwin)#darwin` to apply the configuration
    - You can use `just switch` later to do the same thing
    
