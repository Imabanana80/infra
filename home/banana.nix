{ config, pkgs, inputs, ... }:

let 
    dots = "${config.home.homeDirectory}/infra/config";
    symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in

{
    home.username = "banana";
    home.homeDirectory = "/home/banana";

    imports = [
        ./zen.nix
        ./niri.nix
        ./tmux.nix
    ];

    programs.mpv.enable = true;

    home.packages = with pkgs; [
        fuzzel
        swaybg
        nautilus
        inputs.qml-niri.packages.${pkgs.system}.quickshell

        neovim
        ripgrep
        tree-sitter
        prettierd
        nil
        nixpkgs-fmt
        nodejs
        gcc

        cargo
        rustc

        microfetch
        nix-your-shell
        starship
        bat
        zoxide
        eza
        bc
        btop

        temurin-bin-25
        prismlauncher

        vesktop
        obsidian
        telegram-desktop
        bruno
    ];


    home.file.".zshrc".source = symlink "${dots}/.zshrc";
    xdg.configFile."quickshell" = {
        source = symlink "${dots}/quickshell";
        recursive = true;
    };


    xdg.configFile."git" = {
        source = symlink "${dots}/git";
        recursive = true;
    };
    xdg.configFile."nvim" = {
        source = symlink "${dots}/nvim";
        recursive = true;
    };
    xdg.configFile."ghostty" = {
        source = symlink "${dots}/ghostty";
        recursive = true;
    };
    xdg.configFile."fuzzel" = {
        source = symlink "${dots}/fuzzel";
        recursive = true;
    };

    xdg.configFile."bat" = {
        source = symlink "${dots}/bat";
        recursive = true;
    };
    xdg.configFile."starship.toml" = {
        source = symlink "${dots}/starship.toml";
    };
    xdg.configFile."niri/config.kdl" = {
        source = ../config/niri/config.kdl;
    };

    xdg.configFile."tuxedo" = {
        source = symlink "${dots}/tuxedo";
    };

    home.stateVersion = "26.05";
}
