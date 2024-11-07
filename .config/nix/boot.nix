{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;
  boot.kernel.sysctl."kernel.sysrq" = 502;

  zramSwap.enable = true;

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    neededForBoot = true;
    options = [ "defaults" "mode=755" "999%" ];
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
