{ config, lib, pkgs, inputs, ... }:
{
    imports = [ 
        ../default.nix
        inputs.home-manager.nixosModules.home-manager {
            home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.banana = import ./home.nix;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit inputs; };
            };
        }
    ];

    wsl.defaultUser = "banana";
    networking.hostName = "beetle";

    wsl.docker-desktop.enable = true;
  
    /*
    services.syncthing = {
        enable = true;
        openDefaultPorts = true;
        user = "banana";
        dataDir = "/home/banana";
    };
    */

    programs.fish.enable = true;
    programs.nix-ld.enable = true;

    environment.systemPackages = with pkgs; [
    ];

    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        lexend
        merriweather
        garamond-libre
    ];
  
    system.stateVersion = "26.05";
}

