fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N fancy-ctrl-z
# bindkey '^Z' fancy-ctrl-z

# Important paths
export PATH="~/.cargo/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

alias nvim="/usr/local/bin/nvim"
alias v='nvim'
alias vim='nvim'
alias vim-home="/home/luis/.config/nvim"

# Git aliases
alias g='git'
# Stage all
alias ga='git add .'
# Stage modified and deleted files only
alias gu='git add -u'
# Branches status
alias gb='git branch'
# Create new branch
alias gcb='git checkout -b'
# Commit new, modified and deleted files w message.
alias gcam='git commit -a -m'
# Commit with message
alias gm='git commit -m'
# Switch branches easily
alias gco='git checkout $@'
# When I forget to stage a file into a commit, 'git add' the missed file, then
alias oops='git commit --amend -C HEAD'
# Pretty print commit history
alias ggr="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias gd='git diff'
alias gdc='git diff --cached'
alias gpom='git push origin main'
alias gbd='git push origin --delete'
alias gr='git remote'
alias gs='git status'
alias gp='!git push origin $(git rev-parse --abbrev-ref HEAD)'
alias gpl='!git pull origin $(git rev-parse --abbrev-ref HEAD)'


# exa aliases
alias ls='exa -l --icons'
alias l='exa -lah --icons'
alias lg='exa --git -l --icons'
alias lt='exa --tree --level=2 --long'


# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '(on  %b)'
 
setopt PROMPT_SUBST
PROMPT='%B%F{green}${PWD/#$HOME/~} %F{magenta}λ ${vcs_info_msg_0_} '

[ -f "/home/luis/.ghcup/env" ] && source "/home/luis/.ghcup/env" # ghcup-env
source $HOME/.config/zsh-vi-mode/zsh-vi-mode.plugin.zsh
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
function my_init() {
    bindkey '^Z' fancy-ctrl-z
}
zvm_after_init_commands+=(my_init)
source $HOME/.config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.config/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.config/zsh-autopair/autopair.zsh
source $HOME/.profile
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
