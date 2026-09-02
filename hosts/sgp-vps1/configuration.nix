{ config, lib, pkgs, inputs, ... }:
let 
    keys = import ../../lib/keys.nix;
in
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
    ];

    boot.loader.grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
    };

    networking.hostName = "sgp-vps1";

    services.openssh = {
        enable = true;
        settings = {
            PermitRootLogin = "no";
            PasswordAuthentication = false;
        };
    };

    users.users.banana.openssh.authorizedKeys.keys = keys.ssh;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
   
    system.stateVersion = "26.05";
}
