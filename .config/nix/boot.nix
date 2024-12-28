{ lib, config, pkgs, ... }:
{
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 10;
    efi.canTouchEfiVariables = true;
    timeout = 0;
  };

  boot.plymouth = {
    enable = true;
    theme = "breeze";
  };

  boot.kernel.sysctl."kernel.sysrq" = 502;
  boot.kernelParams = [ "quiet" ];
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  boot.initrd.systemd.enable = true;
  boot.supportedFilesystems = [ "nfs" ];



  #boot.loader.grub.enable = true;
  #boot.loader.grub.efiSupport = true;
  #boot.loader.grub.device = "nodev";
  #boot.loader.grub.configurationLimit = 10;
  #boot.loader.grub.timeoutStyle = "hidden";

  # boot.kernelPackages = pkgs.linuxKernel.packagesFor (pkgs.linuxKernel.kernels.linux_zen.override {
  #   ignoreConfigErrors = true;
  # });
  # boot.kernelPatches = [
  #   {
  #     name = "custom";
  #     patch = ./my.patch;
  #     extraStructuredConfig = with lib.kernel;
  #       {
  #         LOGO = lib.mkForce yes;
  #         LOGO_LINUX_CLUT224 = lib.mkForce yes;
  #         EXT4_FS = lib.mkForce yes;
  #         DRM_SIMPLEDRM = lib.mkForce no;
  #         FB = lib.mkForce no;
  #       };
  #   }
  # ];
  # FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER n


  # https://github.com/NixOS/nixpkgs/blob/nixos-24.05/nixos/modules/system/boot/kernel.nix
  # we don't want sd_mod or usb_storage, since they are built-in to the kernel

  # boot.initrd.availableKernelModules = lib.mkForce [
  #   "nvme"
  #   "xhci_pci"

  #   # Misc. x86 keyboard stuff.
  #   "atkbd"
  #   "i8042"

  #   # x86 RTC needed by the stage 2 init script.
  #   "rtc_cmos"

  #   "btrfs"

  #   "dm_crypt"
  #   "dm_mod"
  #   "cryptd"

  #   "loop"
  #   "overlay"

  #   "blake2b_generic"
  #   "sha256_generic"
  #   "crc32c"
  #   "input_leds"
  #   "aes"
  #   "aes_generic"
  #   "cbc"
  #   "sha1"
  #   "sha256"
  #   "sha512"
  #   "af_alg"
  #   "algif_skcipher"
  #   "amdgpu"
  # ];

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
      "/var/lib/containers"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      "/etc/wireguard"
      "/home"
      "/root/.cache"
      "/nix"
    ];
    files = [ "/etc/machine-id" "/etc/passhash" ];
  };
}
