{ pkgs, pkgs-unstable, inputs, lib, ... }: {
  imports = [ ./de/gnome.nix ];

  system.stateVersion = "24.05"; # Did you read the comment?

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
  services.xserver.xkb = {
    layout = "fi";
    variant = "nodeadkeys";
  };


  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];
  networking.firewall.enable = true;
  networking.nftables.enable = true;
  networking.extraHosts = ''
  '';


  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  services.flatpak.enable =
    true; # flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo --user
  environment.localBinInPath = true;
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    gptfdisk
    wireguard-tools
  ];
  security.pam.services.passwd.nodelay = true;
  security.sudo.wheelNeedsPassword = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "03:45" ];

  programs.zsh.enable = true;
  programs.firefox = import ./firefox.nix;

  # mkpasswd | sudo tee /etc/persist/passhash
  users.users.root.hashedPasswordFile = "/persist/etc/passhash";
  users.mutableUsers = false;


  virtualisation.containers.enable = true;
  virtualisation.podman.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # nixpkgs.config.allowUnfree = true;
  # system.copySystemConfiguration = true;  # unavailable with impermeance
  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [ "wheel" "docker" "networkmanager" ];
    hashedPasswordFile = "/persist/etc/passhash";
    shell = pkgs.zsh;
    packages = (import ./user-packages.nix) {
      inherit pkgs;
      inherit pkgs-unstable;
    };
  };
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=20s
  '';

  #nixpkgs.config.allowUnfreePredicate = pkg:
  #  builtins.elem (lib.getName pkg) [ "steam" "steam-original" "steam-run" ];
  #programs.steam.enable = true;
}

