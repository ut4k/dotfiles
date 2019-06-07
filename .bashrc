alias ls='ls --color=auto'
alias ll='ls -l'
alias srl='cd d:/workspace/surala'
alias work='cd d:/workspace'

export BASH_IT="/home/Kimura/.bash_it"
export BASH_IT_THEME='rjorgenson'
export GIT_HOSTING='git@git.domain.com'
unset MAILCHECK
export IRC_CLIENT='irssi'
export TODO="t"
export SCM_CHECK=true

#ssh-pagent
eval $(/usr/bin/ssh-pageant -r -a "/tmp/.ssh-pageant-$USERNAME")
