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
  fdupes
  fastfetch
  direnv
  zip
  unzip
  openssl
  jq
  yq
  fzf
  ripgrep
  bc
  dtrx
  gita
  hugo
  openrazer-daemon
  docker-compose
  dive
  gnumake
  pciutils
  iw
  aircrack-ng
  ffmpeg-full
  parted
  ps_mem
  stress-ng
  lshw
  usbutils
  pulsemixer
  modprobed-db
  wl-clipboard
  sqlite
  fzf
  ripgrep
  guestfs-tools
  nmap
  wireguard-tools
  dnsutils
  virt-viewer
  qrencode
  htop
  dust
  bat
  fd
  tldr
  #
  talosctl
  kubectl
  opentofu
  kubernetes-helm
  argocd
  flux
  kustomize


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
  pkgs-unstable.deno # deno jupyter --unstable --install
  pipx
  poetry
  ansible
  python3
  pkgs-unstable.pnpm
  pkgs-unstable.nodejs
  awscli2
  #jdk

  # GUI APPS
  kitty
  gnome-software
  libreoffice-fresh
  #prismlauncher
  vlc
  bruno
  drawio
  owncloud-client
  signal-desktop
  kismet
  polychromatic
  filezilla
  vscode


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
