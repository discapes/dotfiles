{ pkgs, pkgs-unstable }:
(with pkgs; [
  # CLI TOOLS
  stow
  lsd
  ripgrep
  file
  nmap
  hashdeep
  tmux
  ncdu
  lf
  fzf
  restic
  fdupes
  fastfetch
  direnv
  brightnessctl
  zip
  unzip
  openssl
  jq
  yq
  # iftop
  nethogs
  # iotop
  # agedu
  tig
  bc
  dtrx

  # PROGRAMMING LANGUAGES
  nodejs
  pnpm
  clang
  go
  cargo
  deno # deno jupyter --unstable --install
  jdk

  # DESKTOP 
  swaybg
  hyprlock
  hypridle
  waybar
  tofi
  fuzzel
  clipman
  wob
  dunst
  lxqt.lxqt-policykit
  wl-clipboard
  grim
  slurp

  # GUI APPS
  kitty
  gnome.gnome-software
  libreoffice-fresh
  prismlauncher
  vlc
  bruno
  drawio
  gnome.nautilus
  networkmanagerapplet

  # OTHER
  glib.bin
  cava
  zoxide
  bat
  ctpv
  nixfmt
  (python3.withPackages (p: [
    p.ansible-core
    p.jupyterlab
    p.jupyterlab-widgets
    p.rpy2
    p.ipywidgets
  ]))
  # extra pkgs for MATLAB from https://gitlab.com/doronbehar/nix-matlab/-/blob/master/common.nix
  (steamPackages.steam-fhsenv-without-steam.override {
    extraPkgs = pkgs: [ pam libselinux libsndfile unzip cacert libglvnd jre ];
  }).run
  distrobox
  (rWrapper.override {
    packages = with rPackages; [ IRkernel ];
  }) # sudo R, IRkernel::installspec(), copy to ~/.local/share/jupyter/kernels
  micromamba
  xorg.xhost
  gnome.adwaita-icon-theme
])
