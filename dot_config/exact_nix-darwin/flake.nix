{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-index-database,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [
            pkgs.vim
          ];

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 5;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";

          security.pam.enableSudoTouchIdAuth = true;

          system.defaults.NSGlobalDomain = {
            KeyRepeat = 2;
            ApplePressAndHoldEnabled = false;
            AppleShowAllExtensions = true;
            NSWindowShouldDragOnGesture = true;
          };
          system.defaults.finder.ShowPathbar = true;

          system.activationScripts.postUserActivation.text = ''
            # Following line should allow us to avoid a logout/login cycle
            /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
          ''; # https://medium.com/@zmre/nix-darwin-quick-tip-activate-your-preferences-f69942a93236

          networking.dns = [
            "1.1.1.1"
            "8.8.8.8"
          ];
          networking.knownNetworkServices = [
            "Wi-Fi"
          ];

          nix.channel.enable = false;
          system.keyboard.enableKeyMapping = true;
          system.keyboard.remapCapsLockToEscape = true;
          system.defaults.finder.QuitMenuItem = true;
          system.defaults.dock.autohide = true;
          system.defaults.CustomUserPreferences = {
            "com.apple.symbolichotkeys" = {
              AppleSymbolicHotKeys = {
                # https://github.com/NUIKit/CGSInternal/blob/master/CGSHotKeys.h
                # see `defaults read com.apple.symbolichotkeys` for mapping
                # `rm ~/Library/Preferences/com.apple.symbolichotkeys.plist` to reset
                # Previous and Next Input source hotkeys conflict with C-space
                "60".enabled = false;
                "61".enabled = false;
              };
            };
          };

        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."darwin" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration

          nix-index-database.darwinModules.nix-index
          # optional to also wrap and install comma
          { programs.nix-index-database.comma.enable = true; }
        ];
      };
    };
}
