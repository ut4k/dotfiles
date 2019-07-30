# ---
# cygwin
# ---
if [[ $(uname -s) == CYGWIN* ]];then
	# bin path
	export PATH=/cygdrive/c/cygwin64/bin
	export PATH=$PATH:/cygdrive/c/cygwin64/usr/local/bin
	export PATH=$PATH:/cygdrive/c/ProgramData/chocolatey/bin #Windows choco
	# cygwinはwindowsのnodeをつかう
	export PATH=$PATH:/cygdrive/c/Program\ Files/nodejs
	export PATH=$PATH:/cygdrive/c/Users/kimura.AZET/AppData/Roaming/npm
	export PATH=$PATH:/cygdrive/c/cygwin64/home/Kimura/.composer/vendor/phpmd/phpmd/src/bin
	export PATH=$PATH:/cygdrive/d/apps/SmoothCSV-1.0.7/SmoothCSV/
	export SCRIPTS=$HOME/scripts
	export DESKTOP=/cygdrive/c/Users/kimura.AZET/Desktop

	alias pandoc_html="pandoc -s --self-contained -t html5 -c d:/pandoc_style/markdown7.css"

	#ssh-agent
	# if ! pgrep -x "ssh-agent" > /dev/null
	# then
	# 	eval `ssh-agent`
	# 	if [ -f $HOME/.ssh/suralacore01.key ]; then
	# 		ssh-add $HOME/.ssh/suralacore01.key
	# 	fi
	# fi

	#ssh-pagent
	if [ -f /usr/bin/ssh-pageant ]; then
	    eval $(/usr/bin/ssh-pageant -r -a "/tmp/.ssh-pageant-$USERNAME")
	fi

fi

# ---
# unix
# ---
alias ~='cd $HOME'
alias work='cd d:/workspace'
alias wifi='sudo wifi-menu'
alias ls='ls --color=auto'
alias ll='ls -l'
alias srl='cd d:/workspace/surala'
alias work='cd d:/workspace'
alias rc='source $HOME/.bashrc'
alias vrc='vim $HOME/.bashrc'
alias path="sed 's/:/\n/g' <<< \"$PATH\""
alias mux='tmuxinator'
alias srans='~/srlscripts/answer.sh'

export EDITOR='vim'
export TERM="xterm-256color"

alias chromium="/usr/bin/chromium-browser --start-fullscreen --disable-session-crashed-bubble --disable-infobars"
alias v="vim"
alias e="emacs -nw"
alias emacs="emacs -nw"
alias playcd="sudo mplayer -cdrom-device /dev/sr0 cdda://"


RESET="\[\033[0m\]"
RED="\[\033[0;31m\]"
GREEN="\[\033[01;32m\]"
BLUE="\[\033[01;34m\]"
YELLOW="\[\033[0;33m\]"

PS_LINE=`printf -- '- %.0s' {1..200}`
PS_INFO="$GREEN\u@\h$RESET:$BLUE\w"
PS_TIME="\[\033[\$((COLUMNS-10))G\] $RED[\t]"
export PS1="\${PS_FILL}\[\033[0G\]${PS_INFO} ${PS_TIME}\n${RESET}\$ "

#export PS1="\[\e[32m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]\[\e[32m\]]\[\e[m"
export TMUX_TMPDIR=/tmp/tmp.tmux
