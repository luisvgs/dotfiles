fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

export ZSH="/home/luis/.oh-my-zsh"
export PATH="~/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

alias nvim="/usr/local/bin/nvim"
alias vim-home="/home/luis/.config/nvim"
alias g='git'
alias ga='git add .'
alias gu='git add -u'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit -a'
alias gcam='git commit -a -m'
alias gce='git commit -e'
alias gcm='git commit -m'
alias gco='git checkout'
alias ggr='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias gdc='git diff --cached'
alias gpom='git push origin main'
alias gbd='git push origin --delete'
alias gr='git remote'
alias gs='git status'
alias gp='!git push origin $(git rev-parse --abbrev-ref HEAD)'
alias gpl='!git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias lx='exa -l --icons'
alias lc='exa -lah --icons'
alias lg='exa --git -l --icons'
alias lt='exa --tree --level=2 --long'
DISABLE_AUTO_UPDATE="true"

plugins=(zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
alias v='nvim'
alias vim='nvim'

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats 'on  %b'
 
setopt PROMPT_SUBST
PROMPT='%B%F{green}${PWD/#$HOME/~} %F{magenta}λ ${vcs_info_msg_0_} '

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f "/home/luis/.ghcup/env" ] && source "/home/luis/.ghcup/env" # ghcup-env
