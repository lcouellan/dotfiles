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
export TERM="xterm-256color"

## PLUGINS
zplug 'zsh-users/zsh-syntax-highlighting'
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# THEME
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_STATUS_CROSS=true

POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4

POWERLEVEL9K_TIME_BACKGROUND="yellow"
POWERLEVEL9K_TIME_FOREGROUND="black"
POWERLEVEL9K_TIME_FORMAT="%B%D{%H:%M:%S}"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

POWERLEVEL9K_OS_ICON_FOREGROUND="108"
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'

if [ "$TERM" != 'linux' ]; then
  source $HOME/.oh-my-zsh/custom/themes/powerlevel9k/powerlevel9k.zsh-theme
else
  export PS1="%{%F{yellow}%}%n%{%f%} %~ › "
fi

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
alias formation='cd ~/Documents/Knp/Formation'
alias dotfiles='cd ~/.dotfiles'
alias perso='cd ~/Documents/Perso'
alias deliver='cd ~/Documents/Knp/Deliver/deliver-events'
alias i24='cd ~/Documents/Knp/i24news'

# Display
alias screenOff='xrandr --output eDP1 --off'
alias screenOn='xrandr --output eDP1 --auto && xrandr --output eDP1 --left-of DP1'

# Docker
alias d-kill='docker stop $(docker ps -aq) && docker rm $(docker ps -aq)'
alias d-clean='docker volume rm $(docker volume ls -qf dangling=true)'
alias dc='docker-compose'

# Git
alias ga='git add'
alias gaa='git add -A'
alias gcm='git commit -m'
alias gco='git checkout'
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

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
