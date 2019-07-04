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
  # ssh-pagent
  eval $(/usr/bin/ssh-pageant -r -a "/tmp/.ssh-pageant-$USERNAME")
  # ssh-agent
  # eval `ssh-agent`
	# ssh-add $HOME/.ssh/suralacore01.key
fi

# ---
# unix
# ---
alias ~='cd $HOME'
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
