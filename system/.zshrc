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

## PLUGINS
zplug 'zsh-users/zsh-syntax-highlighting'
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# THEME
DEFAULT_USER=lenaic
DEFAULT_MACHINE='XPS13'
zplug 'lcouellan/0e4a409e653efba2d9bb0d9d5485d024', from:gist, use:lcouellan.zsh-theme, as:theme

## GLOBAL VARs
export EDITOR='nvim'

## ALIASES
# Override lses
alias ls='exa'
alias ll='exa -alFh'
alias la='exa -A'

#AWS
alias aws-login='$(aws ecr get-login --no-include-email)'

#Bindkeys
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[3~" delete-char

# TAR
compress () { tar cfvz $1.tgz $1 }
extract () { tar xfvz $1 }

# Navigation
alias home='cd ~'
alias knp='cd ~/Documents/Knp'
alias dotfiles='cd ~/.dotfiles'
alias perso='cd ~/Documents/Perso'
alias deliver='cd ~/Documents/Knp/Deliver/deliver-events'
alias yousign='cd ~/Documents/Knp/yousign'

# Display
alias screenOff='xrandr --output eDP1 --off'
alias screenOn='xrandr --output eDP1 --auto && xrandr --output eDP1 --left-of DP1'

# Docker
alias d-kill='docker stop $(docker ps -aq) && docker rm $(docker ps -aq)'
alias d-clean='docker volume rm $(docker volume ls -qf dangling=true)'
alias d-up='docker-compose up -d'
alias d-stop='docker-compose stop'
alias d-build='docker-compose build'
alias d-ps='docker-compose ps'
alias d-pull='docker-compose pull'
alias d-logs='docker-compose logs'
alias d-prune='docker system prune'
alias d-volume='docker volume ls'
alias d-volume-d='docker volume ls -qf dangling=true'

# Git
alias ga='git add'
alias gaa='git add -A'
alias gb='git branch'
alias gcm='git commit -m'
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
export PATH=$PATH:$HOME/.local/bin/

## History wrapper
function omz_history {
  local clear list
  zparseopts -E c=clear l=list

  if [[ -n "$clear" ]]; then
    # if -c provided, clobber the history file
    echo -n >| "$HISTFILE"
    echo >&2 History file deleted. Reload the session to see its effects.
  elif [[ -n "$list" ]]; then
    # if -l provided, run as if calling `fc' directly
    builtin fc "$@"
  else
    # unless a number is provided, show all history events (starting from 1)
    [[ ${@[-1]-} = *[0-9]* ]] && builtin fc -l "$@" || builtin fc -l "$@" 1
  fi
}

# Timestamp format
case ${HIST_STAMPS-} in
  "mm/dd/yyyy") alias history='omz_history -f' ;;
  "dd.mm.yyyy") alias history='omz_history -E' ;;
  "yyyy-mm-dd") alias history='omz_history -i' ;;
  "") alias history='omz_history' ;;
  *) alias history="omz_history -t '$HIST_STAMPS'" ;;
esac

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

neofetch
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
