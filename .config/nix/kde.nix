{ pkgs, pkgs-unstable, inputs, ... }: {

  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;
  services.power-profiles-daemon.enable = false;

}
