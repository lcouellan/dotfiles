# Detect non-interactive shells
if [[ ! $- == *i* ]]; then
  return;
fi

################################################
## ZPLUG
if [ ! -d ~/.zplug ]; then
  git clone https://github.com/zplug/zplug ~/.zplug
fi
source ~/.zplug/init.zsh


## CONFIG
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LSCOLORS=exgxcxdxcxexexabagacad


## PLUGINS
zplug 'zsh-users/zsh-syntax-highlighting'
zplug 'zplug/zplug', hook-build:'zplug --self-manage'


# THEME
DEFAULT_USER=lenaic
DEFAULT_MACHINE='XPS13'
zplug 'lcouellan/0e4a409e653efba2d9bb0d9d5485d024', from:gist, use:lcouellan.zsh-theme, as:theme

## GLOBAL VARs
export EDITOR='nvim'

## ALIASES
# Override lses
alias ll='ls -alFh'
alias la='ls -A'

# TAR
compress () { tar cfvz $1.tgz $1 }
extract () { tar xfvz $1 }

# Navigation
alias home='cd ~'
alias knp='cd ~/Documents/Knp'
alias perso='cd ~/Documents/Perso'
alias deliver='cd ~/Documents/Knp/Deliver'

# Docker
alias d-kill='docker stop $(docker ps -aq) && docker rm $(docker ps -aq)'
alias d-clean='docker volume rm $(docker volume ls -qf dangling=true)'
alias d-up='docker-compose up -d'
alias d-stop='docker-compose stop'
alias d-build='docker-compose build'
alias d-ps='docker-compose ps'
alias d-pull='docker-compose pull'
alias d-logs='docker-compose logs'
alias d-top='docker run -ti -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest'
alias d-prune='docker system prune'
alias d-volume='docker volume ls'
alias d-volume-d='docker volume ls -qf dangling=true'

# Git
alias ga='git add'
alias gaa='git add -A'
alias gb='git branch'
alias gcm='git commit -am'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gs='git status'
alias gph='git push'
alias gpl='git pull'

# VIM
alias vim='nvim'

# Install packages
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  else
    echo
  fi
fi
zplug load

fpath=(~/.zsh/completion $fpath)

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
