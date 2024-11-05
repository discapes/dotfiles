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
  python3
  ansible
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
  #(python3.withPackages (p: [
  #  p.ansible-core
  #  p.jupyterlab
  #  p.jupyterlab-widgets
  #  p.rpy2
  #  p.ipywidgets
  #]))
  ## extra pkgs for MATLAB from https://gitlab.com/doronbehar/nix-matlab/-/blob/master/common.nix
  #(steamPackages.steam-fhsenv-without-steam.override {
  #  extraPkgs = pkgs: [ pam libselinux libsndfile unzip cacert libglvnd jre ];
  #}).run
  #(rWrapper.override {
  #  packages = with rPackages; [ IRkernel ];
  #}) # sudo R, IRkernel::installspec(), copy to ~/.local/share/jupyter/kernels
  #micromamba
  #xorg.xhost
  #gnome.adwaita-icon-theme

  #lua-language-server
])
