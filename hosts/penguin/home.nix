{ config, pkgs, inputs, ... }:

let
    inherit (import ../../lib/homelink.nix config) dots symlink;
in
{
    imports = [
        ../../modules/home/niri.nix
        ../../modules/home/neovim.nix
        ../../modules/home/fish.nix
        ../../modules/home/ghostty.nix
        ../../modules/home/tmux.nix
        ../../modules/home/zen.nix
        ./packages.nix
    ];

    # Tuxedo is installed via Cargo (and not on nixpkgs yet lol)
    xdg.configFile."tuxedo" = {
        source = symlink "${dots}/tuxedo";
    };

    xdg.configFile."git" = {
        source = symlink "${dots}/git";
        recursive = true;
    };

    home.stateVersion = "26.05";
}
