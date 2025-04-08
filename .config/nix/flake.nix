{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    #nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs: {
    nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        ./modules/hardware-configuration.nix
        ./modules/boot.nix
        ./modules/configuration.nix
        ./modules/de/gnome.nix
        ./modules/locale.nix
        ./modules/packages.nix
        ./modules/firefox.nix
        inputs.impermanence.nixosModules.impermanence
        inputs.nix-index-database.nixosModules.nix-index
        { programs.nix-index-database.comma.enable = true; }
        #./overlay.nix
      ];
    };
  };
}
