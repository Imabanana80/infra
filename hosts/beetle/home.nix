{ config, pkgs, inputs, ... }:

let
    inherit (import ../../lib/homelink.nix config) dots symlink;
in
{
    imports = [
        ../../modules/home/neovim.nix
        ../../modules/home/fish.nix
        ../../modules/home/tmux.nix
    ];

    home.packages = with pkgs; [
        # nix
        nil
        nixpkgs-fmt

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

        # CLI
        bc
        dig
        typst
        bootdev-cli
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
