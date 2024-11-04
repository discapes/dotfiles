{ pkgs, pkgs-unstable, inputs, lib, ... }: {
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

  users.users.user.packages = (with pkgs; [
    gnome-extension-manager
    gnome.dconf-editor
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
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "user";


  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        settings = {
          "org/gnome/desktop/input-sources" = {
            sources = [
              (lib.gvariant.mkTuple [ "xkb" "fi+nodeadkeys" ])
            ];
          };
          "org/gnome/desktop/interface".color-scheme = "prefer-dark";
          "org/gnome/desktop/wm/keybindings" = {
            close = [ "<Super>Q" ];
            switch-windows = [ "<Alt>Tab" ];
            switch-windows-backward = [ "<Shift><Alt>Tab" ];
            move-to-workspace-1 = [ "<Shift><Super>1" ];
            move-to-workspace-2 = [ "<Shift><Super>2" ];
            move-to-workspace-3 = [ "<Shift><Super>3" ];
            move-to-workspace-4 = [ "<Shift><Super>4" ];
            switch-to-workspace-1 = [ "<Super>1" ];
            switch-to-workspace-2 = [ "<Super>2" ];
            switch-to-workspace-3 = [ "<Super>3" ];
            switch-to-workspace-4 = [ "<Super>4" ];
          };
          "org/gnome/settings-daemon/plugins/media-keys" = {
            www = [ "<Super>w" ];
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
            "just-perfection-desktop@just-perfection"
          ];
          "org/gnome/shell/extensions/just-perfection" = {
            dash = false;
            search = false;
          };
          # "org/gnome/shell".favorite-apps = [
          #   "org.gnome.Nautilus.desktop"
          #   "code.desktop"
          #   "kitty.desktop"
          #   "firefox.desktop"
          # ];
          # "org/gnome/shell/extensions/dash-to-dock" = {
          #   extend-height = true;
          #   dock-fixed = true;
          #   dock-position = "LEFT";
          # };
        };
      }
    ];
  };
}
