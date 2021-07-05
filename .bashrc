moon_emoji() {
 echo -e "\U1F319";
}

export EDITOR='vim'
export TERM="xterm-256color"
export SCRIPTS=$HOME/scripts
export PATH=$PATH:~/phpctags/phpctags.phar
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/.composer/vendor/bin
export PATH=$PATH:~/.emacs.d/bin
export PATH=$PATH:~/.yarn/bin
export PS1="\[\033[38;5;38m\]\u\[\]\[\033[38;5;15m\]@\[\]\[\033[38;5;172m\]\h\[\]\[\033[38;5;15m\] \[\]\w\[\]\n\[\]\[\033[38;5;41m\]$(moon_emoji)\[\]\[\033[38;5;15m\] \[\]"
export TMUX_TMPDIR=/tmp/tmp.tmux
# if [ -f /usr/bin/fd ]; then
# 	export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude google-api-php-client --exclude *.min.js --exclude tags --exclude .svn'
# fi
export DT='/mnt/c/Users/kimura.AZET/Desktop'
export WO='/mnt/d/workspace'

alias ~='cd $HOME'
alias ll='ls -l'
alias rc='source $HOME/.bashrc'
alias vrc='vim $HOME/.bashrc'
alias showpath="sed 's/:/\n/g' <<< \"$PATH\""

alias mux='tmuxinator'

alias vi="nvim"
alias vim="nvim"

# alias e="emacs -nw"
# alias emacs="emacs -nw"
alias ctags="/usr/local/bin/ctags -R --options=$HOME/.ctags"
alias yahoo="w3m -s -num yahoo.co.jp"
alias ml="tmuxinator list"

#mount azet network drive
alias mnaz="sudo mount -t drvfs '//Azetserver/すらら資料' /mnt/azet-server/"

#run weasel-pageant on WSL
if [[ "`uname -r | grep Microsoft`"  ]]; then
  eval $(/mnt/c/weasel-pageant/weasel-pageant -rqb -a $HOME/.weasel-pageant.sock);
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

PATH="/home/yuta/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/yuta/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/yuta/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/yuta/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/yuta/perl5"; export PERL_MM_OPT;

mdtoh () {
    f=$1
    pandoc -s --self-contained -t html5 -c "$HOME/.config/pandoc/markdown-css-themes/markdown$2.css" --metadata title=' ' --highlight-style=tango $1 -o ${f::-3}.html
}

# export DISPLAY=localhost:0.0

alias npm='/usr/bin/npm'
export GTAGSLABEL=pygments

# VcXsrv
umask 022
# export DISPLAY=localhost:0.0

alias fullls="ls -d -1 "$PWD/"*"

if [[ $(uname -r) =~ Microsoft$ ]]; then
	mdpdf () {
		f=$(echo $1 | sed -e "s/.md//")
		echo $f
		mdtoh $1 6
		wkhtmltopdf.exe $f.html $f.pdf
	}
fi

grep_php_comm() {
  grep -rn --include \*.php 'pre\|print_r\|echo\|var_dump\|var_export' .
}
