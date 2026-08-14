{
  config,
  pkgs,
  ...
}: {
    home.packages = with pkgs; [
        nix-your-shell
        microfetch
    ];

    programs.direnv = {
        enable = true;
    };
    programs.nix-your-shell = {
        enable = true;
        enableFishIntegration = true;
    };
    programs.fish = {
        enable = true;
        interactiveShellInit = ''
            set fish_greeting

            set -gx EDITOR nvim
            set -gx MANPATH /usr/local/man $MANPATH
            set -gx LEDGER_FILE $HOME/finance/index.journal
            set -gx PASSWORD_STORE_ENABLE_EXTENSIONS true
            set -gx TODO_DIR $HOME/.todo

            fish_add_path -P ~/.local/bin/ ~/.cargo/bin/ ~/go/bin/ 

            if command -q nix-your-shell
                nix-your-shell fish | source
            end

            microfetch
        '';
        shellAliases = {
            gl = "git log --all --graph --pretty=format:'%C(magenta)%h %C(white) %an %ar%C(auto) %D%n%s%n'";
            gs = "git status";
            gd = "git diff";
            ga = "git add";
            gaa = "git add .";
            gap = "git add --patch";
            gc = "git commit";
            gp = "git push";
            gu = "git pull --rebase";
            c = "clear";
            v = "nvim";
            h = "hledger";
            todo = "tuxedo";
        };
    };
}
