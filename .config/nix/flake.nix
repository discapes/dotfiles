{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # home-manager.url = "github:nix-community/home-manager/release-24.05";
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = { self, nixpkgs, impermanence, nixpkgs-unstable }@attrs: {
    nixosConfigurations.nixpad = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        unstable = import nixpkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };
      modules = [
        (import ./overlay.nix)
        ./configuration.nix
        # home-manager.nixosModules.home-manager
        impermanence.nixosModules.impermanence
      ];
    };
  };
}
