{ config, pkgs, ... }:
{

  environment.variables = {
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  };

  # enables running binaries
  programs.nix-ld.enable = true;
  nix.channel.enable = false;
  system.rebuild.enableNg = true;
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=20s
  '';

  users.users.me.extraGroups = [
    "wheel"
    "docker"
    "networkmanager"
    "openrazer"
    "wireshark"
    "podman"
    "docker"
    "adbusers"
    "plugdev"
    "kvm"
  ];

  # so it won't be full
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.timeout = 0;
  # boot animation animation
  boot.plymouth.enable = true;
  # breeze looks slightly better than default
  boot.plymouth.theme = "breeze";
  # required for LUKS decryption to be integrated with plymouth
  boot.initrd.systemd.enable = true;

  # unused
  # ##########
  # programs.java.enable = false;
  # nix.optimise.automatic = true;
  # nix.optimise.dates = [ "03:45" ];
  # virtualisation.libvirtd.enable = true;
  # virtualisation.libvirtd.qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  # programs.virt-manager.enable = true;
  # programs.adb.enable = true;
  # programs.wireshark.enable = true;
  # programs.wireshark.package = pkgs.wireshark;
  # programs.steam.enable = true;

  # immutable users
  # #########
  # # mkpasswd | sudo tee /etc/persist/passhash
  # users.mutableUsers = false;
  # users.users.root.hashedPasswordFile = "/persist/etc/passhash";
  # users.users.user.hashedPasswordFile = "/persist/etc/passhash";

  # unfree packages
  # #######
  # nixpkgs.config.allowUnfree = true;
  # OR
  # nixpkgs.config.allowUnfreePredicate =
  #   pkg:
  #   builtins.elem (lib.getName pkg) [
  #     "steam"
  #     "steam-unwrapped"
  #     "steam-original"
  #     "steam-run"
  #     "vscode"
  #     "drawio"
  #   ];
}
