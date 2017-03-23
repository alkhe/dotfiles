#
# ~/.bashrc
#

### Session
[[ $- != *i* ]] && return

### Term
alias x256='export TERM=xterm-256color'
alias tmux='tmux -2'

### System
alias sudo='sudo '

### Filesystem
alias ls='ls -G'
alias l='ls -CaFl'
alias lh='l -h'
alias d.='du -hd0'
alias ..='cd ..'
alias ...='cd ../..'

### Directories
alias md='cd ~/Music/Library'
alias pd='cd ~/Documents/projects'

export MUSIC="$HOME/Music/Library"
export PROJECTS="$HOME/Documents/projects"

### neovim
alias nv='nvim'

### fun
alias fun='cmatrix | lolcat'
alias text='toilet -fmono12'
alias stext='toilet -fmono9'
alias jap='gotran en ja'

### Utils
note() {
	cd ~/notes && nv -c startinsert "$1"
}

alias ev='node -pe'

### Git
alias upsm='git submodule foreach git pull origin master'
git-undo() {
	git rebase --onto $1^ $1
}

### Node
alias bab='yarn add --dev babel-{cli,preset-{stage-0,latest}} && cp ~/Documents/.babelrc .'

### Audio
flac_to_aac() {
	ffmpeg -i "$1" -c:a libfdk_aac -vbr 5 "$2"
}

bitrate() {
	echo `file "$1" | sed 's/.*, \(.*\)kbps.*/\1/' | tr -d " " ` kbps
}

### Upload
alias mixtape='pomf mixtape'

### Dev
alias herokulogs='heroku logs --source app'

### X
alias xcopy='xsel -bi'
alias xpaste='xsel -bo'

### Archlinux
alias psyu='sudo packer -Syu --noconfirm'
alias xr='xrandr --output eDP1 --scale .5x.5'
alias xrr='xrandr --output eDP1 --scale 1x1'
alias xrh='xrandr --output HDMI1 --scale 1x1'
alias gtt='gnome-tweak-tool'


### Language
alias es='babel-node'
alias no='node --harmony'
alias rh='runhaskell -Wno-tabs'
alias mh='ghc -O'
re() {
	rebuild -quiet $1.native
	./$1.native
}

### Path
addpath() {
	export PATH="$1:$PATH"
}

### Testing
bench100() {
	time (for i in {1..100}; do $@ > /dev/null; done)
}

bench1000() {
	time (for i in {1..1000}; do $@ > /dev/null; done)
}

### OCaml
# eval $(opam config env)

### Prompt

# no print
np1="\[\033[38;5;"
np2="m\]"

# reset color
rs="\[$(tput sgr0)\]"

# new color
co() {
	echo "$rs$np1$1$np2"
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

gitaware() {
	ga_branch
	ga_dirty
	git_prompt=$git_branch$git_dirty$([ -n "$git_branch" ] && echo " ")
}

set_tricolor() {
	tricolor=$((RANDOM % 18 + 238))
}

get_tricolor() {
	echo $tricolor
}

ttycolor=`[[ -n $SSH_CLIENT ]] && echo $(co 43) || echo $(co 243)`

PROMPT_COMMAND="gitaware; $PROMPT_COMMAND"

# PS1=$rs$np1
PS1="$(co 36)"
# PS1+='$(get_tricolor)'
# PS1+=$np2
# PS1+="▲ "
PS1+="$ttycolor\h$(co 249) \w$(co 131) \$git_prompt$(co 67)"
PS1+=":: $(co 209)"
trap '[[ -t 1 ]] && tput sgr0' DEBUG

unset rs
unset -f {np,c}

### Files
backup() {
	cp $1 $1%
}

restore() {
	cp $1% $1
}
