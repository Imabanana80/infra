{
    config,
    pkgs,
    inputs,
    ...
}: 
let
    inherit (import ./lib.nix config) dots symlink;
in

{
    imports = [
        ./swaylock.nix
    ];

    # add programs.niri.enable = true to host config

    home.packages = with pkgs; [
        xwayland-satellite
        fuzzel
        swaybg
        nautilus
        inputs.qml-niri.packages.${pkgs.system}.quickshell
        libnotify
        wl-clipboard
        jq
    ];

    services.dunst = {
        enable = true;
        settings = {
            global = {
                width = "(300,500)";
                offset = "(0,32)";
                scale = "1.5";
                seperator_color = "frame";
                frame_color = "#181825";
                highlight = "#11111b";
                background = "#11111b";
                foreground= "#cdd6f4";
                font = "JetBrains Mono Nerd Font";
                show_indicators = false;
            };
        };
    };

    xdg.configFile."fuzzel" = {
        source = symlink "${dots}/fuzzel";
        recursive = true;
    };
    xdg.configFile."quickshell" = {
        source = symlink "${dots}/quickshell";
        recursive = true;
    };
    # Uses ghostty as default
    xdg.configFile."niri/config.kdl" = {
        source = ../config/niri/config.kdl;
    };
} 
