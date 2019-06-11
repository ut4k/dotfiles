#cygwin
if [[ $(uname -s) == CYGWIN* ]];then
	#tmux bin
  alias tmuxinator='/cygdrive/c/Ruby25-x64/bin/tmuxinator.bat'
  alias mux='/cygdrive/c/Ruby25-x64/bin/tmuxinator.bat'
	#ssh-pagent
	eval $(/usr/bin/ssh-pageant -r -a "/tmp/.ssh-pageant-$USERNAME")
fi

#unix
alias ls='ls --color=auto'
alias ll='ls -l'
alias srl='cd d:/workspace/surala'
alias work='cd d:/workspace'
alias rc='source ~/.bashrc'
# ruby aliases
export RUBYBIN=/cygdrive/c/Ruby25-x64/bin
alias ruby="$RUBYBIN"/ruby
alias gem="$RUBYBIN"/gem.cmd
alias bundle="$RUBYBIN"/bundle.bat

export EDITOR='vim'

