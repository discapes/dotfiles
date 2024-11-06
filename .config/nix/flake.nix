{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # home-manager.url = "github:nix-community/home-manager/release-24.05";
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = { self, nixpkgs, impermanence, nixpkgs-unstable }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem
      (
        let system = "x86_64-linux";
        in {
          inherit system;
          specialArgs = {
            inherit inputs;
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
          modules = [
            ./overlay.nix
            ./hardware-configuration.nix
            ./boot.nix
            ./configuration.nix
            impermanence.nixosModules.impermanence
            # home-manager.nixosModules.home-manager
          ];
        }
      );
  };
}
