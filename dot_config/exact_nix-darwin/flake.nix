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
    {
      self,
      nix-darwin,
      nixpkgs,
      nix-index-database,
    }:
    {
      darwinConfigurations."darwin" = nix-darwin.lib.darwinSystem {

        modules = [
          ./configuration.nix
          nix-index-database.darwinModules.nix-index
          # optional to also wrap and install comma
          { programs.nix-index-database.comma.enable = true; }
        ];
        specialArgs = { inherit self; };
      };
    };
}
