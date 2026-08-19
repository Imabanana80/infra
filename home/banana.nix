{ config, pkgs, inputs, ... }:

let
    inherit (import ./modules/lib.nix config) dots symlink;
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


    services.udiskie = {
        enable = true;
        settings = {
            # workaround for
            # https://github.com/nix-community/home-manager/issues/632
            program_options = {
                # replace with your favorite file manager
                file_manager = "${pkgs.nautilus}/bin/nautilus";
            };
        };
    };

    home.packages = with pkgs; [
        # nix
        nil
        nixpkgs-fmt

        # js/ts
        nodejs
        bun
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
        
        # web
        astro-language-server

        # CLI
        bc
        hledger
        pass
        
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
