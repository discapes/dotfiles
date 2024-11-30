{ lib, config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;
  boot.kernel.sysctl."kernel.sysrq" = 502;

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  boot.kernelPatches = [{
    name = "logo";
    patch = ./my.patch;
    extraConfig = ''
      LOGO y
      LOGO_LINUX_CLUT224 y
    '';
  }];
  #      EXT4_FS y
  #      USB_STORAGE y


  # https://github.com/NixOS/nixpkgs/blob/nixos-24.05/nixos/modules/system/boot/kernel.nix
  # we don't want sd_mod or usb_storage, since they are built-in to the kernel
  #boot.initrd.availableKernelModules = lib.mkForce [ "nvme" "xhci_pci" ];

  boot.initrd.availableKernelModules = lib.mkForce [
    "nvme"
    "xhci_pci"

    # Misc. x86 keyboard stuff.
    "atkbd"
    "i8042"

    # x86 RTC needed by the stage 2 init script.
    "rtc_cmos"

    "btrfs"

    "dm_crypt"
    "dm_mod"
    "cryptd"

    "loop"
    "overlay"

    "blake2b_generic"
    "sha256_generic"
    "crc32c"
    "input_leds"
    "aes"
    "aes_generic"
    "cbc"
    "sha1"
    "sha256"
    "sha512"
    "af_alg"
    "algif_skcipher"
  ];

  # we need to disable these or nixos tries to copy them into initrd, but they were removed by make localmodconfig from being modules
  #https://github.com/NixOS/nixpkgs/blob/1170690e2465389b0220dde7d519ba2157621b81/nixos/modules/tasks/filesystems/ext.nix#L5
  # boot.initrd.supportedFilesystems = {
  #   ext2 = lib.mkForce false;
  #   ext3 = lib.mkForce false;
  #   ext4 = lib.mkForce false;
  # };
  # boot.supportedFilesystems = {
  #   ext2 = lib.mkForce false;
  #   ext3 = lib.mkForce false;
  #   ext4 = lib.mkForce false;
  # };

  zramSwap.enable = true;

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    neededForBoot = true;
    options = [ "defaults" "mode=755" "size=999%" ];
  };

  # after installing, clean up /persist
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/cache"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/fprint"
      "/var/lib/docker"
      "/var/lib/libvirt"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      "/home"
      "/root/.cache"
      "/nix"
    ];
    files = [ "/etc/machine-id" "/etc/passhash" ];
  };
}
