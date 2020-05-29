#
# ~/.bashrc
#

### Session
[[ $- != *i* ]] && return

### Editor
if [[ ! -z $(command -v nvim) ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

### Term
alias x256='export TERM=xterm-256color'
alias tmux='tmux -2'

### System
alias sudo='sudo '

### Filesystem
export CLICOLOR=1
ls --color=auto &> /dev/null && alias ls='ls --color=auto' # GNU/BSD ls color compatibility
alias l='ls -CaFl'
alias lh='l -h'
alias d.='du -hd0'
alias ..='cd ..'

### Directories
alias pd='cd ~/Documents/projects'

### Edit (neovim)
alias nv=$EDITOR

### Git
alias git-update-submodules='git submodule foreach git pull origin master'

### Prompt

# styles
reset="\001$(tput sgr0)\002"
bold="\001$(tput bold)\002"

# new color
co() {
  echo "\001\033[38;5;$1m\002"
}

# git aware
ga_branch() {
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    git_branch="($branch)"
  else
    git_branch=""
  fi
}

ga_dirty() {
  local status=$(git status --porcelain 2> /dev/null)
  if [[ "$status" != "" ]]; then
    git_dirty='*'
  else
    git_dirty=''
  fi
}

git_aware() {
  ga_branch
  ga_dirty
  git_prompt=$git_branch$git_dirty
  if [[ "$git_prompt" != "" ]]; then
    git_prompt="$git_prompt "
  fi
}

PROMPT_COMMAND="git_aware; $PROMPT_COMMAND"

PS1=""
if [[ -n $SSH_CLIENT ]]; then
  PS1+="$(co 43)$bold(\u) $reset" # if remote, show user
fi
PS1+="$(co 243)\h " # hostname
PS1+="$(co 249)\w " # working directory
PS1+="$(co 131)\$git_prompt" # git info
PS1+="$(co 67):: " # delimiter
PS1+="$(co 209)" # user input

trap '[[ -t 1 ]] && tput sgr0' DEBUG

unset reset bold
unset -f co

export PATH=~/.local/bin:$PATH

