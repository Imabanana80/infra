{ config, lib, pkgs, inputs, keys, ... }:
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
        ./hardware-configuration.nix
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
        openFirewall = false;
    };
    users.users.banana.openssh.authorizedKeys.keys = [
        keys.ssh.penguin
        keys.ssh.sequoia
        keys.ssh.beetle
    ];

    
    networking.firewall.allowedUDPPorts = [ 51820 ];
    networking.firewall.interfaces.wg0.allowedTCPPorts = [ 22 ];
    networking.wireguard = {
        enable = true;  
        interfaces.wg0 = {                                                                                                                                                             •
            ips = [ "10.101.0.1/24" ];
            listenPort = 51820;
            privateKeyFile = "/etc/wireguard/private.key";
            peers = [
                {
                    publicKey = keys.wg.penguin;
                    allowedIPs = [ "10.101.0.2/32" ];
                }
            ];
        };
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
   
    system.stateVersion = "26.05";
}
