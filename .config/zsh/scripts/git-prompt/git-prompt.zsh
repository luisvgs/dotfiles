autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '[on  %b]'

setopt PROMPT_SUBST
PROMPT='%B%F{green}${PWD/#$HOME/~} %F{magenta}λ ::-> ${vcs_info_msg_0_} '
