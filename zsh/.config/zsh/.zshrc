export PATH="~/.cargo/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export EDITOR='nvim'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
'
alias n='nnn -e'
alias g='git'
alias gc='git clone'
alias ga='git add .'
alias gu='git add -u'
alias gb='git branch'
alias gcb='git checkout -b'
alias gcam='git commit -a -m'
alias gm='git commit -m'
alias gsw='git switch $@'
alias oops='git commit --amend -C HEAD'
alias ggr="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias gpp="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias gd='git diff'
alias gpom='git push origin main'
alias gpo='git push origin'
alias grd='git push origin -d'
alias gbd='git branch -d'
alias gr='git remote'
alias gs='git status'
alias gp='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias gpl='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias gx='f(){git checkout -b $1 && git pull origin $1};f'
alias cat='bat'
alias nvim="/usr/local/bin/nvim"
alias v='nvim'
alias vim='nvim'
alias doom='~/.emacs.d/bin/doom'
alias ls='exa -l --icons'
alias l='exa -lah --icons'
alias lg='exa --git -l --icons'
alias lt='exa --tree --level=1 --long'

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(on  %b)'
setopt PROMPT_SUBST
PROMPT='%B%F{green}${PWD/#$HOME/~} %F{magenta}λ ${vcs_info_msg_0_} '

[ -f "/home/luis/.ghcup/env" ] && source "/home/luis/.ghcup/env" # ghcup-env
source $HOME/.config/zsh/scripts/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.config/zsh/scripts/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.config/zsh/scripts/zsh-autopair/autopair.zsh
source $HOME/.config/zsh/scripts/fzf-functions/fzf-functions.sh
source $HOME/.config/zsh/scripts/fzf-functions/key-binding.zsh
source $HOME/.config/zsh/scripts/ctrl-z/ctrlz.zsh
source $HOME/.config/zsh/scripts/git-prompt/git-prompt.zsh
source $HOME/.profile
# source $HOME/.config/zsh/scripts/git-prompt/git-prompt.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
