{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  inputs.disko.url = "github:nix-community/disko/latest";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";

  outputs =
    {
      self,
      disko,
      nixpkgs,
    }:
    with {
      pkgs = import nixpkgs {
        config.allowUnfree = true;
        system = "aarch64-linux";
      };
    };
    {
      nixosConfigurations.mymachine = pkgs.nixos [
        ./hardware-configuration.nix
        disko.nixosModules.disko
        {
          services.openssh = {
            enable = true;
            settings.PasswordAuthentication = false;
            settings.KbdInteractiveAuthentication = false;
          };
          nix.settings.experimental-features = "nix-command flakes";
          services.qemuGuest.enable = true;
          time.timeZone = "Europe/Helsinki";
          services.getty.autologinUser = "nixos";
          nix.channel.enable = false;
          system.rebuild.enableNg = true;
          users.users.nixos = {
            isNormalUser = true;
            extraGroups = [
              "wheel"
            ];
            hashedPassword = "$y$j9T$/VeCI/.2H2u8JKQOqa1P8/$whs7HbBAlKijHXsGXu1TUW32EXBiWUh3J6J8eeSURJ6";
            openssh.authorizedKeys.keys = [
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHEcD9ND7akyuONPgy1iRMBjZBNxOv5U0Cll9qP4qyZE"
            ];
          };
          users.users.root.openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHEcD9ND7akyuONPgy1iRMBjZBNxOv5U0Cll9qP4qyZE"
          ];
          nix.settings.trusted-users = [
            "nixos"
          ];
          users.mutableUsers = false;
          console.keyMap = "fi";
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
          security.sudo.wheelNeedsPassword = false;
          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;
          system.stateVersion = "25.05"; # Did you read the comment?
          nix.registry.nixpkgs.flake = nixpkgs;

          programs.hyprland.enable = true;
          environment.systemPackages = with pkgs; [
            kitty
            foot
            alacritty
            vim
          ];

          boot.loader.timeout = 0;
          disko.devices = {
            disk = {
              main = {
                device = "/dev/sda";
                type = "disk";
                content = {
                  type = "gpt";
                  partitions = {
                    ESP = {
                      type = "EF00";
                      size = "500M";
                      content = {
                        type = "filesystem";
                        format = "vfat";
                        mountpoint = "/boot";
                        mountOptions = [ "umask=0077" ];
                      };
                    };
                    root = {
                      size = "100%";
                      content = {
                        type = "filesystem";
                        format = "ext4";
                        mountpoint = "/";
                      };
                    };
                  };
                };
              };
            };
          };
        }
      ];
    };
}
