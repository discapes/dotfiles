{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    #    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # home-manager.url = "github:nix-community/home-manager/release-24.05";
    impermanence.url = "github:nix-community/impermanence";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, impermanence, nixpkgs-unstable, nix-index-database }@inputs: {
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
            nix-index-database.nixosModules.nix-index
            { programs.nix-index-database.comma.enable = true; }
            # home-manager.nixosModules.home-manager
          ];
        }
      );
  };
}
