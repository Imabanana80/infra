{ config, lib, pkgs, inputs, ... }:
let 
    keys = import ../../lib/keys.nix;
in
{
    imports = [ 
        ./disk-config.nix
    ];

    time.timeZone = "Asia/Singapore";

    boot.loader.grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
    };

    networking.hostName = "sgp-vps1";

    services.openssh = {
        enable = true;
        settings.PermitRootLogin = "prohibit-password";
    };

    environment.systemPackages = with pkgs; [
        curl
        gitMinimal
        vim
        btop
    ];

    users.users.root.openssh.authorizedKeys.keys = keys.ssh;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
   
    system.stateVersion = "26.05";
}

