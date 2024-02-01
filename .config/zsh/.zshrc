export PATH="~/.cargo/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="/opt/idea-IC-232.9559.62/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export READER='zathura'
export EDITOR='nvim'
BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

# export COURSIER_REPOSITORIES="https://packages.corp.com/artifactory/maven/"
alias idea='idea.sh'
# Scala
alias sc='scala-cli run --jvm 17'
alias sn='scala-helper $@'

# Ocaml
dnp() {
	dune init project $1 && cd $1 && dune build
}

# DUNE COMPILE AND RUN
alias dcr='dune exec ./bin/main.exe'
alias drw='dune build -w'
alias db='dune build'
alias drt='dune runtest'

# LateX
alias ltxw='latexmk -pdf -pvc'

alias sz="source $HOME/.config/zsh/.zshrc"
alias doom="$HOME/.emacs.d/bin/doom"
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/.bare/ --work-tree=$HOME'

#emacs
# alias emacs='emacsclient -c'
# alias e='emacsclient -nw'
# alias es='systemctl start --user emacs'
# alias est="emacsclient -e '(kill-emacs)'"

alias ssql='systemctl start mysqld'
alias lsql='mysql -u root -p'

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
alias ls='/opt/coreutils/bin/ls'
alias l='exa -lah --icons --git '
alias lt='exa --tree --level=3 --long --git'
alias n='nnn -e'
alias cw='cargo watch -q -c -w src/ -x run'
alias cwt='cargo watch -x test'
alias cb='cargo build'
alias sw-qa='cd v2-qa && git rebase v2 && gp && cd ..'
alias sw-dev='cd v2-dev && git rebase v2 && gp && cd ..'
alias pt='prettier --write "**/*.jsx"'
alias ptt='prettier --write "**/*.js"'

# Docker
alias dk='sudo docker kill'
alias dp='sudo docker ps -a'
alias dbt='docker build -t'
alias docker-on='systemctl start docker'
alias docker-clean='docker rmi $(docker images --filter "dangling=true" -q --no-trunc) --force'



# Monitor management
# alias dual='xrandr --output HDMI-2 --mode 2560x1080 --same-as eDP-1 && xrandr --output eDP-1 --off'
alias dual='xrandr --output HDMI-2 --mode 1920x1080 --same-as eDP-1 && xrandr --output eDP-1 --off'
alias monitor-on='xrandr --output eDP-1 --auto'
# alias dual='xrandr --output HDMI-2 --mode 2560x1080 --same-as eDP-1'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


autoload -U compinit
compinit

export DOT_REPO="https://github.com/luisvgs/dotfiles.git"
export DOT_DIR="$HOME/.dotfiles"
fpath=($HOME/.config/zsh/scripts/dot/dot.sh $fpath)
source $HOME/.config/zsh/scripts/dot/dot.sh
source $HOME/.config/zsh/scripts/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.config/zsh/scripts/zsh-scripts/fzf_git_functions.zsh
source $HOME/.config/zsh/scripts/zsh-scripts/key-binding.zsh
source $HOME/.config/zsh/scripts/fancy-ctrlz/fancy.zsh
source $HOME/.config/zsh/scripts/git-prompt/git-prompt.zsh
source $HOME/.config/zsh/scripts/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.config/zsh/scripts/scala-helper/scala-helper.zsh
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh
[ -f "/home/luis/.ghcup/env" ] && source "/home/luis/.ghcup/env" # ghcup-env

eval $(opam env)

# >>> scala-cli completions >>>
fpath=("/home/luis/.local/share/scalacli/completions/zsh" $fpath)
compinit
# <<< scala-cli completions <<<
