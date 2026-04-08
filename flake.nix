{
  description = "my system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, nix-homebrew, ... }: {
    darwinConfigurations."coruscant" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./hosts/coruscant.nix
        home-manager.darwinModules.home-manager
        nix-homebrew.darwinModules.nix-homebrew
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.daniel = import ./home/common.nix;
          nix-homebrew = {
                    enable = true;
                    enableRosetta = true;
                    user = "daniel";
                    autoMigrate = true;  # migrates your existing brew install
          };
        }
      ];
    };
    darwinConfigurations."kashyyk" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./hosts/kashyyk.nix
        home-manager.darwinModules.home-manager
        nix-homebrew.darwinModules.nix-homebrew
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.daniel = import ./home/common.nix;
          nix-homebrew = {
                    enable = true;
                    enableRosetta = true;
                    user = "daniel";
                    autoMigrate = true;  # migrates your existing brew install
          };
        }
      ];
    };
  };
}
