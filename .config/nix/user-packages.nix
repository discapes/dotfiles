{ pkgs, pkgs-unstable }:
(with pkgs; [
  #
  #  extraPkgs = pkgs: [ pam libselinux libsndfile unzip cacert libglvnd jre ];
  #  polychromatic
  # CLI TOOLS
  # GUI APPS
  # OTHER
  # PROGRAMMING LANGUAGES
  # agedu
  # iftop
  # iotop
  ## extra pkgs for MATLAB from https://gitlab.com/doronbehar/nix-matlab/-/blob/master/common.nix
  #(steamPackages.steam-fhsenv-without-steam.override {
  #argocd
  #bat
  #cargo
  #cava
  #clang
  #glib.bin
  #gnome.adwaita-icon-theme
  #go
  #hashdeep
  #jdk
  #lua-language-server
  #micromamba
  #modprobed-db
  #nethogs
  #nmap
  #nodejs
  #owncloud-client
  #pnpm
  #prismlauncher
  #restic
  #stress-ng
  #tig
  #xorg.xhost
  #}).run

  aircrack-ng
  ansible
  awscli2
  bat
  bc
  bruno
  btrfs-progs
  ctpv
  direnv
  distrobox
  dive
  dnsutils
  docker-compose
  drawio
  dtrx
  dust
  e2fsprogs
  fastfetch
  fd
  fdupes
  ffmpeg-full
  file
  filezilla
  flux
  fzf
  gita
  gnome-software
  gnumake
  guestfs-tools
  htop
  hugo
  iw
  jq
  #  kismet
  kitty
  kubectl
  kubernetes-helm
  kustomize
  lf
  libreoffice-fresh
  lsd
  lshw
  megasync
  ncdu
  nmap
  #  openrazer-daemon
  openssl
  opentofu
  parted
  pciutils
  pipx
  #pkgs-unstable.deno # deno jupyter --unstable --install
  pkgs-unstable.nodejs
  pkgs-unstable.pnpm
  poetry
  ps_mem
  pulsemixer
  python3
  qrencode
  ripgrep
  signal-desktop
  sqlite
  stow
  talosctl
  tldr
  tmux
  unzip
  usbutils
  virt-viewer
  vlc
  vscode
  wireguard-tools
  wl-clipboard
  xfsprogs
  yq
  zip
  zoxide
])
