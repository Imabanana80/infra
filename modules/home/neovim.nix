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
        neovim
        ripgrep
        tree-sitter
        lua-language-server
    ];

    xdg.configFile."nvim" = {
        source = symlink "${dots}/nvim";
        recursive = true;
    };
} 
