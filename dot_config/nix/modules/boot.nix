{
  config,
  pkgs,
  lib,
  ...
}:
{
  # BOOTLOADER CONFIG
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 10;
    #grub.enable = true;
    #grub.efiSupport = true;
    #grub.device = "nodev";
    #grub.configurationLimit = 10;
    #grub.timeoutStyle = "hidden";

    efi.canTouchEfiVariables = true;
    timeout = 0;
  };

  boot.plymouth = {
    enable = true;
    theme = "breeze";
  };

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  boot.binfmt.preferStaticEmulators = true;
  boot.kernel.sysctl."kernel.sysrq" = 502;
  boot.kernelParams = [ "quiet" ];
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  boot.initrd.systemd.enable = true;
  boot.supportedFilesystems = [
    "nfs"
    "ntfs"
  ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtl88xxau-aircrack
  ];

  # how to override kernel options
  # boot.kernelPackages = pkgs.linuxKernel.packagesFor (pkgs.linuxKernel.kernels.linux_zen.override {
  #   ignoreConfigErrors = true;
  # });

  zramSwap.enable = true;
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    neededForBoot = true;
    options = [
      "defaults"
      "mode=755"
      "size=999%"
    ];
  };

  # after installing, clean up /persist
  # tip to see if files take space in /:
  # dust -x /
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/cache"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/fprint"
      "/var/lib/docker"
      "/var/lib/tailscale"
      "/var/lib/libvirt"
      "/var/lib/containers"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      "/etc/wireguard"
      "/home"
      "/root/.cache"
      "/nix"
    ];
    files = [
      "/etc/machine-id"
      "/etc/passhash"
    ];
  };

}
