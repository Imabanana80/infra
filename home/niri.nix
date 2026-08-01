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
    ];

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
