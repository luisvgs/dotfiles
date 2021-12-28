# Switch between the shell and vim
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

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/luis/.oh-my-zsh"
export PATH="~/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
# ZSH_THEME="cypher"
#half-life
# "powerlevel10k/powerlevel10k"
alias nvim="/usr/local/bin/nvim"
alias vim-home="/home/luis/.config/nvim"
alias g='git'
alias ga='git add .'
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

DISABLE_AUTO_UPDATE="true"

plugins=(zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
alias v='nvim'
alias vim='nvim'
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, oveeval “$(starship init zsh)”rriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"





# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# eval "$(starship init zsh)"

# opam configuration
# test -r /home/luis/.opam/opam-init/init.zsh && . /home/luis/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"


# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats 'on  %b'
 
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%B%F{green}${PWD/#$HOME/~} %F{magenta}λ ${vcs_info_msg_0_} '

# source ~/.oh-my-zsh/plugins/git/git.plugin.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f "/home/luis/.ghcup/env" ] && source "/home/luis/.ghcup/env" # ghcup-env
