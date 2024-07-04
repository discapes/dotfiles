{ config, lib, pkgs, unstable, ... }: {
  imports = [ ./hardware-configuration.nix ];

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    neededForBoot = true;
    options = [ "defaults" "size=2G" "mode=755" ];
  };

  # after installing, clean up /persist
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/fprint"
      "/var/lib/docker"
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
  services.blueman.enable = true;
  services.syncthing = {
    enable = true; # a
    user = "miika";
    dataDir = "/home/miika"; # Default folder for new synced folders
    configDir = "/home/miika/.config/syncthing";
  };
  services.getty.autologinUser = "miika";
  services.fprintd.enable = true; # remember to enroll fingerprint
  services.flatpak.enable =
    true; # flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo --user
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;
    };
  };

  powerManagement.enable = true;
  powerManagement.powertop.enable = true;

  environment.localBinInPath = true;
  environment.systemPackages = with pkgs; [
    wget
    git
    gptfdisk
    wireguard-tools
    powertop
  ];

  security.pam.services.passwd.fprintAuth =
    false; # we want passsword to be primary
  security.pam.services.passwd.nodelay = true;
  security.sudo.wheelNeedsPassword = false;
  security.rtkit.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "03:45" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;

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

  programs.hyprland.enable = true;
  #  programs.sway.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  programs.zsh.enable = true;
  programs.firefox = import ./firefox.nix;

  # mkpasswd | sudo tee /etc/persist/passhash
  users.users.root.hashedPasswordFile = "/persist/etc/passhash";
  users.mutableUsers = false;
  hardware.opengl.enable = true;
  hardware.bluetooth.enable = true;
  virtualisation.docker.enable = true;
  # nixpkgs.config.allowUnfree = true;
  # system.copySystemConfiguration = true;  # unavailable with impermeance
  users.users.miika = {
    isNormalUser = true;
    description = "Miika Tuominen";
    extraGroups = [ "wheel" "docker" "networkmanager" ];
    hashedPasswordFile = "/persist/etc/passhash";
    shell = pkgs.zsh;
    packages = (import ./user-packages.nix) {
      inherit pkgs;
      inherit unstable;
    };
  };
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=20s
  '';

  system.stateVersion = "24.05"; # Did you read the comment?
}

