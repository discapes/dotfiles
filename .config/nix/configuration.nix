# dit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, unstable, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    neededForBoot = true;
    options = [ "defaults" "size=2G" "mode=755" ];
  };

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      "/home"
      "/nix"
    ];
    files = [ "/etc/machine-id" "/etc/passhash" ];
  };

  # from https://salsa.debian.org/debian/brightnessctl/-/blob/debian/sid/90-brightnessctl.rules
  # to allow brightnessctl to work without root
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils-full}/bin/chgrp users /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils-full}/bin/chmod g+w /sys/class/backlight/%k/brightness"
  '';

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "03:45" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "fi";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fi_FI.UTF-8";
    LC_IDENTIFICATION = "fi_FI.UTF-8";
    LC_MEASUREMENT = "fi_FI.UTF-8";
    LC_MONETARY = "fi_FI.UTF-8";
    LC_NAME = "fi_FI.UTF-8";
    LC_NUMERIC = "fi_FI.UTF-8";
    LC_PAPER = "fi_FI.UTF-8";
    LC_TELEPHONE = "fi_FI.UTF-8";
    LC_TIME = "fi_FI.UTF-8";
  };

  networking.hostName = "nixpad";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];
  networking.firewall.enable = true;
  networking.nftables.enable = true;
  networking.extraHosts = ''
    10.0.0.3 pi
  '';

  # mkpasswd | sudo tee /etc/persist/passhash
  users.users.root.hashedPasswordFile = "/persist/etc/passhash";
  users.mutableUsers = false;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.hyprland.enable = true;
  #  programs.sway.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  programs.zsh.enable = true;
  security.sudo.wheelNeedsPassword = false;
  hardware.opengl.enable = true;
  virtualisation.docker.enable = true;
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [ wget git gptfdisk wireguard-tools ];
  programs = {
    firefox = {
      enable = true;
      policies = {
        DisablePocket = true;
        ExtensionSettings = {
          "uBlock0@raymondhill.net" = {
            # uBlock Origin
            install_url =
              "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
        };
      };
      preferences = {
        "browser.startup.page" = 3; # resume
      };
    };
  };
  # unavailable with impermeance
  # system.copySystemConfiguration = true;

  services = {
    syncthing = {
      enable = true; # a
      user = "miika";
      dataDir = "/home/miika"; # Default folder for new synced folders
      configDir = "/home/miika/.config/syncthing";
    };
  };
  # TODO gnome software working
  services.getty.autologinUser = "miika";
  users.users.miika = {
    isNormalUser = true;
    description = "Miika Tuominen";
    extraGroups = [ "wheel" "docker" "networkmanager" ];
    hashedPasswordFile = "/persist/etc/passhash";
    shell = pkgs.zsh;
    packages = (with pkgs; [
      firefox
      fprintd
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
      flatpak # flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo --user
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
    ]);
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}

