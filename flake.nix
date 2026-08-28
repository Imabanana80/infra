{
    description = "Banana's Nix Based Infrastructure";
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs = {
              nixpkgs.follows = "nixpkgs";
              home-manager.follows = "home-manager";
            };
        };    
        quickshell = {
            url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        qml-niri = {
            url = "github:imiric/qml-niri/main";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.quickshell.follows = "quickshell";
        };
    };
    outputs = { self, nixpkgs, ... } @inputs: {
        nixosConfigurations.penguin = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
                ./hosts/penguin/configuration.nix
                
            ];
        };
        nixosConfiguration.beetle = nixpkgs.lib.nixosSystem {
            system = "x86_64-linx";
            specialArgs = { inherit inputs; };
            modules = [
                nixos-wsl.nixosModules.default
                {
                    wsl.enable = true;
                }
            ];
        };
    };
}
