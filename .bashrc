# ---
# cygwin
# ---
if [[ $(uname -s) == CYGWIN* ]];then
	#bin path
	export PATH=/cygdrive/c/cygwin64/bin
	export PATH=$PATH:/cygdrive/c/cygwin64/usr/local/bin
	export PATH=$PATH:/cygdrive/c/ProgramData/chocolatey/bin #Windows choco
	#my env var
	export SCRIPTS=$HOME/scripts
  # ssh-pagent
  eval $(/usr/bin/ssh-pageant -r -a "/tmp/.ssh-pageant-$USERNAME")
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

# environment variable
export EDITOR='vim'

