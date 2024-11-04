{ pkgs, pkgs-unstable, inputs, ... }: {

  services.getty.autologinUser = "user";
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  #  programs.sway.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 50;
    };
  };

  users.users.user.packages = with pkgs; [
  #gnome.nautilus
  #networkmanagerapplet
  #obs-studio
    swaybg
    hyprlock
    hypridle
    waybar
    brightnessctl
    tofi
    fuzzel
    clipman
    wob
    dunst
    lxqt.lxqt-policykit
    grim
    slurp
  ]

    }
