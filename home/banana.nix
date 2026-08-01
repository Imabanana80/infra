{ config, pkgs, inputs, ... }:

let
    inherit (import ./lib.nix config) dots symlink;
in
{
    home.username = "banana";
    home.homeDirectory = "/home/banana";

    imports = [
        ./niri.nix
        ./ghostty.nix
        ./neovim.nix
        ./tmux.nix
        ./zen.nix
        ./zsh.nix
    ];

    programs.mpv.enable = true;

    home.packages = with pkgs; [
        # Dev stuffs
        nil
        nixpkgs-fmt
        nodejs
        prettierd
        gcc
        cargo
        rustc
        temurin-bin-25

        # Rest 
        bc
        prismlauncher
        vesktop
        obsidian
        telegram-desktop
        bruno
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
