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
    # add programs.zsh.enable = true to host config

    home.packages = with pkgs; [
        nix-your-shell
        microfetch
        starship
        bat
        zoxide
        eza
    ];

    home.file.".zshrc".source = symlink "${dots}/.zshrc";
    xdg.configFile."bat" = {
        source = symlink "${dots}/bat";
        recursive = true;
    };
    xdg.configFile."starship.toml" = {
        source = symlink "${dots}/starship.toml";
    };
} 
