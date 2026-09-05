{ config, lib, pkgs, inputs, ... }:
{
    imports = [ 
        ./disk-config.nix
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
        ./hosts/sgp-vps1/hardware-configuration.nix
    ];

    networking.hostName = "sgp-vps1";

    security.sudo.wheelNeedsPassword = false;

    boot.loader.grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
    };

    services.openssh = {
        enable = true;
        settings = {
            PermitRootLogin = "no";
            PasswordAuthentication = false;
        };
    };
    users.users.banana.openssh.authorizedKeys.keys = [
        keys.ssh.penguin
        keys.ssh.sequoia
        keys.ssh.beetle
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
   
    system.stateVersion = "26.05";
}
