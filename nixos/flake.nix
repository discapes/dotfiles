{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    {
      self,
      nixpkgs,
      nix-index-database,
    }:
    {
      nixosConfigurations.v15 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./extra.nix
          ./extra2.nix
          nix-index-database.nixosModules.nix-index
          { programs.nix-index-database.comma.enable = true; }
        ];
      };
    };
}
