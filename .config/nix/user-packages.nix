{ pkgs, pkgs-unstable }:
(with pkgs; [
  # CLI TOOLS
  stow
  lsd
  ripgrep
  file
  zoxide
  ctpv
  distrobox
  tmux
  ncdu
  lf
  fzf
  fdupes
  fastfetch
  direnv
  zip
  unzip
  openssl
  jq
  yq
  bc
  dtrx
  gita
  hugo
  openrazer-daemon

  polychromatic
  vscodium

  #nmap
  #hashdeep
  #restic
  # iftop
  #nethogs
  # iotop
  # agedu
  #tig

  # PROGRAMMING LANGUAGES
  #nodejs
  #pnpm
  #clang
  #go
  #cargo
  deno # deno jupyter --unstable --install
  pipx
  ansible
  python3
  #jdk

  # DESKTOP 
  wl-clipboard

  # GUI APPS
  kitty
  gnome.gnome-software
  libreoffice-fresh
  #prismlauncher
  vlc
  bruno
  drawio
  owncloud-client

  # OTHER
  #glib.bin
  #cava
  #bat
  ## extra pkgs for MATLAB from https://gitlab.com/doronbehar/nix-matlab/-/blob/master/common.nix
  #(steamPackages.steam-fhsenv-without-steam.override {
  #  extraPkgs = pkgs: [ pam libselinux libsndfile unzip cacert libglvnd jre ];
  #}).run
  #micromamba
  #xorg.xhost
  #gnome.adwaita-icon-theme

  #lua-language-server
])
