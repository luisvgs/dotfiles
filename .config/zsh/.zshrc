export PATH="~/.cargo/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export EDITOR='nvim'
BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

alias nvim="/usr/local/bin/nvim"
alias v='nvim'
alias vim='nvim'
alias vim-home="$HOME/.config/nvim"
alias g='git'
alias gw='git worktree'
alias ga='git add .'
alias gu='git add -u'
alias gb='git branch'
alias gcb='git checkout -b'
alias gcam='git commit -a -m'
alias gm='git commit -m'
alias gco='git checkout $@'
alias oops='git commit --amend -C HEAD'
alias ggr="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias gd='git diff'
alias gdc='git diff --cached'
alias gpom='git push origin main'
alias gbd='git push origin --delete'
alias gr='git remote'
alias gs='git status'
alias gp='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias gpl='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias gtest='git merge dev --no-ff --no-commit'
alias ls='exa -l --icons'
alias l='exa -lah --icons'
alias lg='exa --git -l --icons'
alias lt='exa --tree --level=2 --long'
alias n='nnn -e'
alias sc='scala-cli run'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U compinit
compinit

source /home/luis/.config/zsh/scripts/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/luis/.config/zsh/scripts/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/luis/.config/zsh/scripts/zsh-scripts/fzf_git_functions.zsh
source /home/luis/.config/zsh/scripts/zsh-scripts/key-binding.zsh
source /home/luis/.config/zsh/scripts/fancy-ctrlz/fancy.zsh
source /home/luis/.config/zsh/scripts/git-prompt/git-prompt.zsh
