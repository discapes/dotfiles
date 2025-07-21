{
  config,
  pkgs,
  lib,
  ...
}:
{
  system.stateVersion = "24.05"; # Did you read the comment?

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.nameservers = [
    "1.1.1.1"
    "9.9.9.9"
  ];
  # WILL BREAK VIRTD DHCP
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];
  networking.firewall.enable = false;
  networking.nftables.enable = true;
  networking.extraHosts = '''';
  networking.networkmanager.dns = "none";

  environment.variables = {
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  };

  hardware.pulseaudio.enable = false;
  hardware.hackrf.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.syncthing = {
    enable = true;
    user = "user";
    group = "users";
    dataDir = "/home/user/Sync"; # Default folder for new synced folders
    configDir = "/home/user/.config/syncthing";
  };
  services.tailscale.enable = true;
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
  environment.localBinInPath = true;
  security.pam.services.passwd.nodelay = true;
  security.sudo.wheelNeedsPassword = false;
  programs.java.enable = true;
  programs.nix-ld.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.channel.enable = false;
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "03:45" ];
  system.rebuild.enableNg = true;

  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  virtualisation.waydroid.enable = true;

  # system.copySystemConfiguration = true;  # unavailable with impermeance
  programs = {
    wireshark.enable = true;
    wireshark.package = pkgs.wireshark;
    steam.enable = true;
    virt-manager.enable = true;
    zsh.enable = true;
    zsh.enableGlobalCompInit = false; # we don't want .zcompdump in ~/.config/zsh
    adb.enable = true;
    gnupg.agent.enable = true;
  };

  # mkpasswd | sudo tee /etc/persist/passhash
  users.users.root.hashedPasswordFile = "/persist/etc/passhash";
  users.mutableUsers = false;

  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
      "openrazer"
      "wireshark"
      "podman"
      "adbusers"
      "plugdev"
      "kvm"
    ];
    hashedPasswordFile = "/persist/etc/passhash";
    shell = pkgs.zsh;
  };
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=20s
  '';

  # nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"
      "steam-original"
      "steam-run"
      "vscode"
      "drawio"
    ];
}
