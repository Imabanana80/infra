{
  config,
  pkgs,
  ...
}: {
    programs.direnv = {
        enable = true;
    };
    programs.fish = {
        enable = true;
        interactiveShellInit = ''
            set fish_greeting

            set -gx EDITOR nvim
            set -gx MANPATH /usr/local/man $MANPATH
            set -gx BUN_INSTALL $HOME/.bun
            set -gx LEDGER_FILE $HOME/finance/index.journal
            set -gx PASSWORD_STORE_ENABLE_EXTENSIONS true
            set -gx TODO_DIR $HOME/.todo

            if command -q nix-your-shell
                nix-your-shell fish | source
            end
        '';
        shellAliases = {
            dotfiles = "cd ~/.dotfiles";
            vi = "nvim";
            cat = "bat";
            ls = "eza -l --icons";
            tree = "eza --icons --tree";
            gl = "git log --all --graph --pretty=format:'%C(magenta)%h %C(white) %an %ar%C(auto) %D%n%s%n'";
            gs = "git status";
            gd = "git diff";
            ga = "git add";
            gaa = "git add .";
            gap = "git add --patch";
            gc = "git commit";
            gp = "git push";
            gu = "git pull --rebase";
            cls = "clear";
            h = "hledger";
            t = "tuxedo";
        };
    };
    programs.zoxide = {
        enable = true;
        enableFishIntegration = true;
    };

    home.packages = with pkgs; [
        nix-your-shell
    ];
}
