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
    home.packages = with pkgs; [
        neovim
        ripgrep
        tree-sitter
    ];

    xdg.configFile."nvim" = {
        source = symlink "${dots}/nvim";
        recursive = true;
    };
} 
