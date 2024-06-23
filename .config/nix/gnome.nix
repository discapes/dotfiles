{
  environment.gnome.excludePackages = (with pkgs; [ gnome-tour ])
    ++ (with pkgs.gnome; [
      epiphany
      yelp
      geary
      gnome-contacts
      gnome-shell-extensions
      gnome-weather
      gnome-calendar
      simple-scan
      gnome-maps
    ]);

  users.users.miika.packages = (with pkgs; [
    gnome-extension-manager
    gnome.dconf-editor
    gnomeExtensions.dash-to-dock
    gnome.gnome-tweaks
    papirus-icon-theme
  ]);

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "miika";

  home-manager.users.miika = { pkgs, lib, ... }:
    with lib.hm; {
      dconf = {

        enable = true;
        settings = {
          "org/gnome/desktop/input-sources" = {
            sources = [
              (gvariant.mkTuple [ "xkb" "us" ])
              (gvariant.mkTuple [ "xkb" "fi+nodeadkeys" ])
            ];
          };
          "org/gnome/desktop/interface".color-scheme = "prefer-dark";
          "org.gnome.desktop.wm.keybindings".close = [ "<Alt><Super>Q" ];
          "org/gnome/settings-daemon/plugins/media-keys" = {
            custom-keybindings = [
              "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
            ];
          };
          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
            {
              binding = "<Super>Return";
              command = "kitty";
              name = "Run kitty";
            };
          "org/gnome/shell".enabled-extensions = [
            "dash-to-dock@micxgx.gmail.com"
            "system-monitor-indicator@mknap.com"
          ];
          "org/gnome/shell".favorite-apps = [
            "org.gnome.Nautilus.desktop"
            "code.desktop"
            "kitty.desktop"
            "firefox.desktop"
          ];
          "org/gnome/shell/extensions/dash-to-dock" = {
            extend-height = true;
            dock-fixed = true;
            dock-position = "LEFT";
          };
        };
      };
      # The state version is required and should stay at the version you
      # originally installed.
      home.stateVersion = "23.11";
    };
}
