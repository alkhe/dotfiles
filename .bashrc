#
# ~/.bashrc
#

### Session
[[ $- != *i* ]] && return

### Filesystem 
alias ls='ls --color=auto'
alias l='ls -CaFl'
alias lh='l -h'
alias d.='du -hd0'

### Git
alias upsm='git submodule foreach git pull origin master'

### Archlinux
alias rnet='sudo systemctl restart NetworkManager'
alias psyu='sudo packer -Syu --noconfirm'
alias xr='xrandr --output eDP1 --scale .5x.5'
alias open='xdg-open'
inth() {
	mv $1 /usr/share/themes/
}

### Language
alias es='babel-node'
alias rh='runhaskell'

### Testing
bnch() {
	time (for i in {1..100}; do $@ > /dev/null; done)
}

### Prompt

# no print
np() {
	echo "\[\033[38;5;$1m\]"
}

# reset color
rs="\[$(tput sgr0)\]"

# new color
c() {
	echo "$rs$(np $1)"
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

PROMPT_COMMAND="gitaware; $PROMPT_COMMAND"
export PS1="$(np 67)[$(c 43)\h$(c 159):\w$(c 67)]$(c 131) \$git_prompt$(c 141)>> $rs"

unset rs
unset -f {np,c}

### Files
backup() {
	cp $1 $1%
}

restore() {
	cp $1% $1
}

bitrate() {
	echo `file "$1" | sed 's/.*, \(.*\)kbps.*/\1/' | tr -d " " ` kbps
}
