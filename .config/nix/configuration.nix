# Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).

{ self, config, pkgs, unstable, ... }: {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    neededForBoot = true;
    options = [ "defaults" "size=2G" "mode=755" ];
  };

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      "/home"
      "/nix"
    ];
    files = [ "/etc/machine-id" ];
  };

  nix.optimise.automatic = true;
  nix.optimise.dates = [ "03:45" ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];

  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fi_FI.UTF-8";
    LC_IDENTIFICATION = "fi_FI.UTF-8";
    LC_MEASUREMENT = "fi_FI.UTF-8";
    LC_MONETARY = "fi_FI.UTF-8";
    LC_NAME = "fi_FI.UTF-8";
    LC_NUMERIC = "fi_FI.UTF-8";
    LC_PAPER = "fi_FI.UTF-8";
    LC_TELEPHONE = "fi_FI.UTF-8";
    LC_TIME = "fi_FI.UTF-8";
  };
  services.xserver = { layout = "us"; };
  console.keyMap = "us";

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];

  services = {
    syncthing = {
      enable = true; # a
      user = "miika";
      dataDir = "/home/miika"; # Default folder for new synced folders
      configDir = "/home/miika/.config/syncthing";
    };
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  virtualisation.docker.enable = true;
  services.flatpak.enable = true;

  users.users.root.initialHashedPassword = "";
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.miika = {
    isNormalUser = true;
    description = "Miika Tuominen";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    initialHashedPassword = "";
    packages = (with pkgs; [
      firefox
      wl-clipboard
      gptfdisk
      stow
      lsd
      tmux
      lf
      kitty
      fzf
      zoxide
      bat
      cargo
      ctpv
      gnome-extension-manager
      neofetch
      thunderbird
      spotify
      sage
      keepassxc
      gimp-with-plugins
      vscode
      gnomeExtensions.dash-to-dock
      nixfmt
      gnome.dconf-editor
      ansible
      gnome.gnome-tweaks
      nodejs_latest
      (python3.withPackages (ps:
        with ps; [
          jupyterlab # s
          pipenv
        ]))
      papirus-icon-theme
      imagemagick
      flatpak
    ]) ++ (with unstable; [ discord slack obsidian stremio zim ]);
  };
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

  security.sudo.wheelNeedsPassword = false;

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "miika";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ wget git ecryptfs ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

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

  programs = {
    firefox = {
      enable = true;
      policies = {
        DisablePocket = true;
        ExtensionSettings = {
          "uBlock0@raymondhill.net" = {
            # uBlock Origin
            install_url =
              "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
        };
      };
      preferences = {
        "browser.startup.page" = 3; # resume
      };
    };
  };

  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
