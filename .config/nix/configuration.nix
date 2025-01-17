{ pkgs, pkgs-unstable, inputs, lib, ... }: {
  imports = [ ./de/gnome.nix ./locale.nix ];

  system.stateVersion = "24.05"; # Did you read the comment?

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];
  # WILL BREAK VIRTD DHCP
  #  networking.firewall.allowedTCPPorts = [ ];
  #  networking.firewall.allowedUDPPorts = [ ];
  networking.firewall.enable = false;
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

  services.tailscale.enable = true;
  services.flatpak.enable =
    true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
  environment.localBinInPath = true;
  environment.systemPackages =
    (import ./user-packages.nix)
      {
        inherit pkgs;
        inherit pkgs-unstable;
      } ++ (with pkgs; [
      vim
      wget
      git
      gptfdisk
      wireguard-tools
      podman-tui
      virtiofsd
    ]);
  security.pam.services.passwd.nodelay = true;
  security.sudo.wheelNeedsPassword = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "03:45" ];


  # mkpasswd | sudo tee /etc/persist/passhash
  users.users.root.hashedPasswordFile = "/persist/etc/passhash";
  users.mutableUsers = false;


  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.vhostUserPackages = with pkgs; [ virtiofsd ];

  # system.copySystemConfiguration = true;  # unavailable with impermeance
  programs = {
    wireshark.enable = true;
    wireshark.package = pkgs.wireshark;
    steam.enable = true;
    virt-manager.enable = true;
    zsh.enable = true;
    firefox = import ./firefox.nix;
  };
  services = {
    ratbagd.enable = true;
  };
  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [ "wheel" "docker" "networkmanager" "openrazer" "wireshark" "podman" ];
    hashedPasswordFile = "/persist/etc/passhash";
    shell = pkgs.zsh;
    # };
  };
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=20s
  '';

  # nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "steam" "steam-unwrapped" "steam-original" "steam-run" "vscode" "drawio" ];
  #hardware.openrazer.enable = true;
}

