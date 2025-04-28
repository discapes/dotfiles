{
  config,
  pkgs,
  lib,
  ...
}:

# Here I put packages that I'm certain to only need on NixOS. So most CLI tools and packages that I would use on macOS
# too would be in home-manager, so I can install them easily. However, packages that are Linux-specific belong here
# (or in the future I might move everything to home-manager if I use another Linux distro), and also packages that are
# "provided by the OS" like partitioning tools or system management utilities, or GUI apps that might be safer to
# manage with something other than nix.
with pkgs;
{
  environment.systemPackages =
    let
      std_utils = [
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
        lshw
        nmap
        openssl
        pciutils
        unzip
        usbutils
        vim
        virt-viewer
        virtiofsd
        wget
        wireguard-tools
        wl-clipboard
        zip
      ];
      cli_niceties = [
        # moved to home-manager
        ps_mem # not available on macOS
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
        distrobox
        ansible
        nodejs
        vscode
        python3
        go
        clang
        apacheHttpd # for htpasswd
      ];
    in
    std_utils ++ cli_niceties ++ apps ++ dev;
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
