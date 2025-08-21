{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-index-database,
      nixpkgs-unstable,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          # defaults:
          environment.systemPackages = [
            pkgs.vim
          ];
          nix.settings.experimental-features = "nix-command flakes";
          system.configurationRevision = self.rev or self.dirtyRev or null;
          system.stateVersion = 6;
          nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."VR7MKFK7Q1" = nix-darwin.lib.darwinSystem {
        modules = [
          ./configuration.nix
          configuration
          nix-index-database.darwinModules.nix-index
          { programs.nix-index-database.comma.enable = true; }
          {
            nix.registry = {
              pkgs.flake = nixpkgs-unstable;
            };
          }
        ];
      };
    };
}
