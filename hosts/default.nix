{ config, lib, pkgs, ... }:

{
    time.timeZone = "Asia/Singapore";

    users.users.banana = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
    };

    nixpkgs.config.allowUnfreePredicate = pkg:
        builtins.trace "warning: allowing unfree package ${pkgs.lib.getName pkg}" true;

    environment.systemPackages = with pkgs; [
        vim
        btop
        git
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
