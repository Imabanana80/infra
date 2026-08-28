{ config, lib, pkgs, inputs, ... }:
{
    imports = [ 
        ../default.nix
        ./hardware-configuration.nix

        inputs.home-manager.nixosModules.home-manager {
            home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.banana = import ./home.nix;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit inputs; };
            };
        }

        ./backup.nix
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "penguin";
    networking.networkmanager.enable = true;
  
    services.xserver = {
        enable = true;
        autoRepeatDelay = 200;
        autoRepeatInterval = 35;
    };
    services.displayManager.ly.enable = true;
    services.udisks2.enable = true;

    services.syncthing = {
        enable = true;
        openDefaultPorts = true;
        user = "banana";
        dataDir = "/home/banana";
    };

    programs.fish.enable = true;
    programs.niri.enable = true;
    programs.nix-ld.enable = true;
    programs.firefox.enable = true;

    programs.steam = {
        enable = true;
    };

    environment.systemPackages = with pkgs; [
        udiskie
    ];

    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        lexend
        merriweather
        garamond-libre
    ];

    virtualisation.docker = {
        enable = true;
        rootless = {
            enable = true;
            setSocketVariable = true;
        };
    };
  
    system.stateVersion = "26.05";
}

