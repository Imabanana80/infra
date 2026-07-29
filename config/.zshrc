zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: tab for more %s'
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit

path () {
    export PATH="$PATH:$@"
}

export ZSH_AUTOSUGGEST_STRATEGY=(completion)
export EDITOR='nvim'
export MANPATH="/usr/local/man:$MANPATH"
export BUN_INSTALL="$HOME/.bun"
export LEDGER_FILE="$HOME/finance/index.journal"
export PASSWORD_STORE_ENABLE_EXTENSIONS=true
export TODO_DIR="$HOME/.todo"


path ~/scripts
path ~/.scripts
path ~/bin
path ~/.local/bin
path ~/.cargo/bin
path ~/go/bin
path /snap/bin
path /usr/local/bin
path /usr/local/go/bin
path $BUN_INSTALL/bin

alias infra="vi ~/infra"
alias vi="nvim"
alias py="python3"
alias py3="python3.14"
alias spt="spotify_player"
alias cat="bat"
alias cd="z"
alias ls="eza -l --icons"
alias tree="eza --icons --tree"
alias gl="git log --all --graph --pretty=format:'%C(magenta)%h %C(white) %an %ar%C(auto) %D%n%s%n'"
alias gs="git status"
alias gd="git diff"
alias ga="git add"
alias gaa="git add ."
alias gap="git add --patch"
alias gc="git commit"
alias gp="git push"
alias gu="git pull --rebase"
alias cls="clear"
alias h="hledger"
alias t="tuxedo"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
[ -s "/home/$HOME/.bun/_bun" ] && source "/home/$HOME/.bun/_bun"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

fastfetch
