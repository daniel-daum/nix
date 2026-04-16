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
          home-manager.extraSpecialArgs = {
            jjSigningConfig = ./dotfiles/jj-signing-coruscant.toml;
            gitSigningKey = "/Users/daniel/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/PublicKeys/7547f1a1ede91e329c6851fb20f37eaa.pub";
            gitAllowedSigner = "daniel@danieldaum.net ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIaK2hJB4MiDRomD+XIS1KufbiPSR5c2Erpqom0BYmgAYjULdkYe5wn1zHlCh8VNxifKQ0lFCt7GJ4pLmH8cwAE= coruscant@secretive.coruscant.local";
          };
          home-manager.users.daniel = import ./home/macos.nix;
          nix-homebrew = {
                    enable = true;
                    enableRosetta = true;
                    user = "daniel";
                    autoMigrate = true;
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
          home-manager.extraSpecialArgs = {
            jjSigningConfig = ./dotfiles/jj-signing-kashyyk.toml;
            gitSigningKey = "/Users/daniel/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/PublicKeys/d31dd9a441afe369d2645ee7261bf0cc.pub";
            gitAllowedSigner = "daniel@danieldaum.net ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBDOAqk5teLMOm4Lbr2Ts/stwv5qVWRec5fwPA/yb+9F8MsnJ+iBAMbU3t208jf94TOgy6LezAv9mJWPKMynOnC0= kashyyk@secretive.kashyyk.local";
          };
          home-manager.users.daniel = import ./home/macos.nix;
          nix-homebrew = {
                    enable = true;
                    enableRosetta = true;
                    user = "daniel";
                    autoMigrate = true;
          };
        }
      ];
    };

    nixosConfigurations."mars-coruscant" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./hosts/mars.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            configName = "mars-coruscant";
            jjSigningConfig = ./dotfiles/jj-signing-coruscant.toml;
            gitSigningKey = "key::ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIaK2hJB4MiDRomD+XIS1KufbiPSR5c2Erpqom0BYmgAYjULdkYe5wn1zHlCh8VNxifKQ0lFCt7GJ4pLmH8cwAE= coruscant@secretive.coruscant.local";
            gitAllowedSigner = "daniel@danieldaum.net ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIaK2hJB4MiDRomD+XIS1KufbiPSR5c2Erpqom0BYmgAYjULdkYe5wn1zHlCh8VNxifKQ0lFCt7GJ4pLmH8cwAE= coruscant@secretive.coruscant.local";
          };
          home-manager.users.daniel = import ./home/mars.nix;
        }
      ];
    };

    nixosConfigurations."mars-kashyyk" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./hosts/mars.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            configName = "mars-kashyyk";
            jjSigningConfig = ./dotfiles/jj-signing-kashyyk.toml;
            gitSigningKey = "key::ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBDOAqk5teLMOm4Lbr2Ts/stwv5qVWRec5fwPA/yb+9F8MsnJ+iBAMbU3t208jf94TOgy6LezAv9mJWPKMynOnC0= kashyyk@secretive.kashyyk.local";
            gitAllowedSigner = "daniel@danieldaum.net ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBDOAqk5teLMOm4Lbr2Ts/stwv5qVWRec5fwPA/yb+9F8MsnJ+iBAMbU3t208jf94TOgy6LezAv9mJWPKMynOnC0= kashyyk@secretive.kashyyk.local";
          };
          home-manager.users.daniel = import ./home/mars.nix;
        }
      ];
    };
  };
}
