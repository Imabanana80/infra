{ config, pkgs, inputs, ... }:
{
    imports = [
        ../../modules/home/neovim.nix
    ];
    
    home.stateVersion = "26.05";
}
