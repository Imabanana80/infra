{
    description = "Banana's Nix Based Infrastructure";
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-26.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs = {
              nixpkgs.follows = "nixpkgs";
              home-manager.follows = "home-manager";
            };
        };    
    };
    outputs = { self, nixpkgs, home-manager, zen-browser, ... } @inputs: {
        nixosConfigurations.penguin = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./host/penguin/configuration.nix
                home-manager.nixosModules.home-manager
                {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        users.banana = import ./home/banana.nix;
                        backupFileExtension = "backup";
                        extraSpecialArgs = { inherit inputs zen-browser; };
                    };

                }
            ];
        };
    };
}
