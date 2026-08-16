{ config, pkgs, inputs, ... }:

let
    inherit (import ./lib.nix config) dots symlink;
in
{
    home.username = "banana";
    home.homeDirectory = "/home/banana";

    imports = [
        ./modules/niri.nix
        ./modules/ghostty.nix
        ./modules/neovim.nix
        ./modules/tmux.nix
        ./modules/zen.nix
        ./modules/fish.nix
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

        # zig
        zig
        zls

        # rust
        cargo
        rustc

        # java
        temurin-bin-25

        # python
        python3

        # csharp
        dotnet-sdk
        jetbrains.rider

        # CLI
        bc
        hledger
        
        # GUI
        vesktop
        obsidian
        telegram-desktop
        prismlauncher
        bambu-studio
        bruno
        freecad
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
