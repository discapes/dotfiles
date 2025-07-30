{ pkgs, ... }:
{
  # nix.registry.nixpkgs.to = {
  #   type = "path";
  #   path = pkgs.path;
  # };
  # nix.registry.nixpkgs.flake = pkgs;

  security.pam.services.sudo_local.touchIdAuth = true;

  system.primaryUser = "miika.tuominen";

  system.defaults.NSGlobalDomain = {
    KeyRepeat = 2;
    ApplePressAndHoldEnabled = false;
    AppleShowAllExtensions = true;
    NSWindowShouldDragOnGesture = true;
  };
  system.defaults.finder.ShowPathbar = true;

  # removed in 25.05
  # system.activationScripts.postUserActivation.text = ''
  #   # Following line should allow us to avoid a logout/login cycle
  #   /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  # ''; # https://medium.com/@zmre/nix-darwin-quick-tip-activate-your-preferences-f69942a93236

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
        "32".enabled = false;
        "33".enabled = false;
      };
    };
  };

}
