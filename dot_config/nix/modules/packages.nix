{
  config,
  pkgs,
  lib,
  ...
}:
with pkgs;
{
  environment.systemPackages =
    let
      std_utils = [
        hello
        home-manager
        bc
        btrfs-progs
        dnsutils
        e2fsprogs
        ffmpeg-full
        file
        git
        gptfdisk
        htop
        jq
        lshw
        nmap
        openssl
        pciutils
        stow
        tmux
        unzip
        usbutils
        vim
        virt-viewer
        virtiofsd
        wget
        wireguard-tools
        wl-clipboard
        yq
        zip
        rclone
      ];
      cli_niceties = [
        bat
        ctpv
        dive
        dtrx
        dust
        fastfetch
        fd
        fdupes
        fzf
        gita
        lf
        lsd
        ncdu
        ps_mem
        ripgrep
        tldr
        zoxide
        lazygit
      ];
      kube = [
        # argocd
        flux
        kubectl
        kubernetes-helm
        kustomize
        talosctl
      ];
      apps = [
        kitty
        signal-desktop
        gnome-software
        libreoffice-fresh
        drawio
        gparted
      ];
      dev = [
        podman-tui
        docker-compose
        direnv
        distrobox
        ansible
        opentofu
        nodejs
        vscode
        python3
        go
        clang
        just
        apacheHttpd # for htpasswd
      ];
      rust = [
        rustc
        rustfmt
        rust-analyzer
        clippy
        cargo
      ];
    in
    std_utils ++ cli_niceties ++ apps ++ dev ++ rust;
}

## extra pkgs for MATLAB from https://gitlab.com/doronbehar/nix-matlab/-/blob/master/common.nix
#(steamPackages.steam-fhsenv-without-steam.override {
#  extraPkgs = pkgs: [ pam libselinux libsndfile unzip cacert libglvnd jre ];
#}).run

#aircrack-ng
#awscli2
#cava
#filezilla
#glib.bin
#gnome.adwaita-icon-theme
#gnumake
#go
#hashdeep
#hugo
#iw
#jdk
#kismet
#libguestfs
#lua-language-server
#micromamba
#modprobed-db
#nethogs
#nmap
#openrazer-daemon
#owncloud-client
#picocrypt
#pnpm
#prismlauncher
#pulsemixer
#qrencode
#restic
#sqlite
#stress-ng
#tig
#vlc
#xfsprogs
#xorg.xhost
