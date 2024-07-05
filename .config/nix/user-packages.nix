{ pkgs, pkgs-unstable }:
(with pkgs; [
  lxqt.lxqt-policykit
  ripgrep
  brightnessctl
  kitty
  stow
  lsd
  swaybg
  hyprlock
  hypridle
  tmux
  glib.bin
  waybar
  tofi
  fuzzel
  wob
  lf
  dunst
  direnv
  cava
  fzf
  zoxide
  bat
  wl-clipboard
  ctpv
  keepassxc
  nixfmt
  python3
  nodejs
  clang
  zip
  unzip
  go
  cargo
  gnome.gnome-software
  grim
  slurp
  fastfetch
  ncdu
  libreoffice-fresh
  prismlauncher
  # extra pkgs for MATLAB from https://gitlab.com/doronbehar/nix-matlab/-/blob/master/common.nix
  (steamPackages.steam-fhsenv-without-steam.override {
    extraPkgs = pkgs: [ pam libselinux libsndfile unzip cacert libglvnd jre ];
  }).run
  distrobox
  networkmanagerapplet
])
