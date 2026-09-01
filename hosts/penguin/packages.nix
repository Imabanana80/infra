{ pkgs, ... }:
{
    home.packages = with pkgs; [
        # nix
        nil
        nixpkgs-fmt

        # java
        temurin-bin-21
        jetbrains.idea

        # python
        python3

        # go
        go
        gcc
        gopls

        # web
        nodejs
        bun
        prettierd
        astro-language-server

        udiskie

        # CLI
        bc
        dig
        hledger
        typst
        bootdev-cli


        # GUI
        mpv
        vesktop
        obsidian
        telegram-desktop
        prismlauncher
        bambu-studio
        bruno
        blockbench
        blender
        aseprite
    ];
}
