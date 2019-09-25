export EDITOR='vim'
export TERM="xterm-256color"
export SCRIPTS=$HOME/scripts
export PATH=$PATH:~/.config/composer/vendor/bin
export PATH=$PATH:~/phpctags/phpctags.phar
export PATH=$PATH:~/AppData/Local/hyper/app-2.0.0/resources/bin
export PATH=$PATH:~/.local/bin

alias ~='cd $HOME'
alias wifi='sudo wifi-menu'
alias ll='ls -l'
alias work='cd /d/workspace'
alias surala='cd /d/workspace/surala && vim'
alias rc='source $HOME/.bashrc'
alias vrc='vim $HOME/.bashrc'
alias showpath="sed 's/:/\n/g' <<< \"$PATH\""
alias mux='tmuxinator'
alias srans='~/srlscripts/answer.sh'
alias chromium="/usr/bin/chromium-browser --start-fullscreen --disable-session-crashed-bubble --disable-infobars"
alias vi="nvim"
alias vim="nvim"
alias e="emacs -nw"
alias emacs="emacs -nw"
alias playcd="sudo mplayer -cdrom-device /dev/sr0 cdda://"

pandochtml () {
    f=$1
    pandoc -s --self-contained -t html5 --syntax-definition=/d/pandoc_style/hi/bash.xml -c /d/pandoc_style/markdown10.css --metadata title=title --highlight-style=zenburn $1 -o ${f::-3}.html
}

RESET="\[\033[0m\]"
RED="\[\033[0;31m\]"
GREEN="\[\033[01;32m\]"
BLUE="\[\033[01;34m\]"
YELLOW="\[\033[0;33m\]"
PS_LINE=`printf -- '- %.0s' {1..200}`
PS_INFO="$GREEN\u@\h$RESET:$BLUE\w"
PS_TIME="\[\033[\$((COLUMNS-10))G\] $RED[\t]"

export PS1="\${PS_FILL}\[\033[0G\]${PS_INFO} ${PS_TIME}\n${RESET}\$ "
export TMUX_TMPDIR=/tmp/tmp.tmux

#run weasel-pageant on WSL
if [[ $(uname -r) =~ Microsoft$ ]]; then
    eval $(/c/weasel-pageant/weasel-pageant -rq)
fi

if [ -f /usr/bin/fd ]; then
	export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude google-api-php-client --exclude *.min.js --exclude tags --exclude .svn'
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

PATH="/home/yuta/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/yuta/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/yuta/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/yuta/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/yuta/perl5"; export PERL_MM_OPT;
