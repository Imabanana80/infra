
{
    config,
    pkgs,
    inputs,
    ...
}: 
let
    inherit (import ../../lib/homelink.nix config) dots symlink;
in

{
    home.packages = with pkgs; [
        ghostty
    ];

    xdg.configFile."ghostty" = {
        source = symlink "${dots}/ghostty";
        recursive = true;
    };
} 
