# dotfiles

run .local/bin/dotstow (later just dotstow) to create symlinks to the dotfile directory in ~
run omz to install oh-my-zsh and plugins and themes
read .config/nix/configuration.nix to see other required programs
mkpasswd | tee /etc/passhash
distrobox create --name arch --pull -i quay.io/toolbx/arch-toolbox:latest
sudo pacman -S python-pip npm neovim cargo wl-clipboard ripgrep fzf terraform
gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing false
