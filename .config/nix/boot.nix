{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;
  boot.kernel.sysctl."kernel.sysrq" = 502;

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    neededForBoot = true;
    options = [ "defaults" "size=10G" "mode=755" ];
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
      "/var/lib/opensnitch"
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
