
PATH=$PATH:$HOME/.rvm/bin:$HOME/bin # Add RVM to PATH for scripting
TERM="screen-256color"
EDITOR="/usr/bin/vim"
export ERL_LIBS="$HOME/erlang/common"
bindkey -v
bindkey "^W" backward-kill-word    # vi-backward-kill-word
bindkey "^H" backward-delete-char  # vi-backward-delete-char
bindkey "^U" kill-line             # vi-kill-line
bindkey "^?" backward-delete-char  # vi-backward-delete-char

bindkey -M vicmd '?' history-incremental-search-backward

#HISTORY
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1717

setopt inc_append_history
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt hist_allow_clobber
#setopt share_history

#ZSH OPTS
setopt extendedglob
setopt correct correctall
setopt autocd autolist
setopt auto_resume
setopt short_loops #for file in *.pdf; lp ${file}

unset beep
set nobeep


# Setup the prompt with pretty colors
setopt prompt_subst

# Promt theme
# Yay! High voltage and arrows!
# ls colors
autoload colors; colors;
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Enable ls colors
# Find the option for using colors in ls, depending on the version: Linux or BSD
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'


ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""

promt()
{
local EXIT_STATUS="$?"
local AT="@"
local HOST="%{$fg[yellow]%}%m%{$reset_color%}"
local IN=":"
local DIRNAME="%{$fg[cyan]%}%0~%{$reset_color%}"
local GIT_DELIM="|"
local GIT_INFO="$(git_prompt_info)"

if [[ "${GIT_INFO}" == "" ]]
then
   local GIT=" "
else
   local GIT="${GIT_DELIM}${GIT_INFO}"
fi

if [[ "${EXIT_STATUS}" -eq 0 ]]
then
   local STATUS_COLOR="%{$fg[green]%}"
else
   local STATUS_COLOR="%{$fg[red]%}"
fi

if [[ "${USER}" == "root" ]]
then
   local STATUS_MARK="#"
   local NAME_COLOR="%{$fg[red]%}"
else
   local STATUS_MARK="$"
   local NAME_COLOR="%{$fg[green]%}"
fi

local NAME="${NAME_COLOR}%n%{$reset_color%}"

local STATUS="${STATUS_COLOR}${STATUS_MARK}%{$reset_color%}"
# ${NAME}${AT}${HOST}${IN}
local PROMT="${DIRNAME}${GIT}${STATUS} "
echo "${PROMT}"
}

PROMPT='$(promt)'


# Git
# get the name of the branch we are on
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}


# http://reza.jelveh.me/2011/09/18/zsh-tmux-vi-mode-cursor
# use cursor as indicator of vi mode
zle-keymap-select () {
  if [[ $TMUX = '' ]]; then
      zle-keymap-select-xterm 
  else
    tput smcup
    print -n '\ePtmux;\e'
    zle-keymap-select-xterm 
    print -n '\e\\'
    tput rmcup
  fi
}

zle-keymap-select-xterm () {
  if [ $KEYMAP = vicmd ]; then
    print -n '\e]12;pink\a'
  else
    print -n '\e]12;grey\a'
  fi
}

zle-line-init () {
  zle -K viins
  zle-keymap-select 
}

if [[ $DISPLAY != '' ]]; then
zle -N zle-keymap-select
zle -N zle-line-init
fi


alias rebar='nocorrect rebar'

settitle() {
#   printf "\033k$1\033\\"
    printf "\033]2;$1\033\\"
}

settitle ""
#printf '\033]2;%s\033\\' ''
