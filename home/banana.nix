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
        # nix
        nil
        nixpkgs-fmt

        # js/ts
        nodejs
        prettierd

        # c
        gcc

        # rust
        cargo
        rustc

        # java
        temurin-bin-25

        # python
        python3

        jetbrains.rider

        # Rest 
        bc
        hledger
        prismlauncher
        vesktop
        obsidian
        telegram-desktop
        bambu-studio
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
