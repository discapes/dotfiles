{ config, pkgs, ... }:
{
  # VIRTUAL MACHINES
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "me" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # HIBERNATION
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 13812; # total in env free --mega
    }
  ];
  # don't use filefrag on btrfs!
  boot.kernelParams = [ "resume_offset=27043072" ]; # btrfs inspect-internal map-swapfile -r swap_file
  boot.resumeDevice = "/dev/disk/by-uuid/9590a55b-1f6e-48dd-ac23-a5ed39b24544";
  powerManagement.enable = true;
  # environment.systemPackages = with pkgs; [
  #   e2fsprogs # for filefrag
  # ];
  #
  services.tailscale.enable = true;
  services.syncthing.enable = true;
}
