export EDITOR='vim'
export TERM="xterm-256color"
export SCRIPTS=$HOME/scripts
export PATH=$PATH:~/phpctags/phpctags.phar
export PATH=$PATH:~/.local/bin
export PS1="\[\033[38;5;38m\]\u\[\]\[\033[38;5;15m\]@\[\]\[\033[38;5;172m\]\h\[\]\[\033[38;5;15m\] \[\]\w\[\]\n\[\]\[\033[38;5;41m\]\$\[\]\[\033[38;5;15m\] \[\]"
export TMUX_TMPDIR=/tmp/tmp.tmux
if [ -f /usr/bin/fd ]; then
	export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude google-api-php-client --exclude *.min.js --exclude tags --exclude .svn'
fi
export DT='/c/Users/kimura.AZET/Desktop/'

alias ~='cd $HOME'
alias ll='ls -l'
alias rc='source $HOME/.bashrc'
alias vrc='vim $HOME/.bashrc'
alias showpath="sed 's/:/\n/g' <<< \"$PATH\""

alias mux='tmuxinator'

alias srans='~/srlscripts/answer.sh'
alias srans2='~/srlscripts/answer2.sh'
alias vi="nvim"
alias vim="nvim"
alias e="emacs -nw"
alias emacs="emacs -nw"
alias ctags="/usr/local/bin/ctags -R --options=$HOME/.ctags"
alias yahoo="w3m yahoo.co.jp"
alias ml="tmuxinator list"

#run weasel-pageant on WSL
if [[ $(uname -r) =~ Microsoft$ ]]; then eval $(/c/weasel-pageant/weasel-pageant -rq); fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

PATH="/home/yuta/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/yuta/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/yuta/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/yuta/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/yuta/perl5"; export PERL_MM_OPT;

pandochtml () {
    f=$1
    pandoc -s --toc --self-contained -t html5 -c "$HOME/.config/pandoc/markdown-css-themes/markdown10.css" --metadata title=' ' --highlight-style=tango $1 -o ${f::-3}.html
}

pandochtml2 () {
    f=$1
    pandoc -s -t html5 -c "$HOME/.config/pandoc/markdown-css-themes/markdown10.css" --metadata title=' ' --highlight-style=tango $1 -o ${f::-3}.html
}

mdtoh () {
    f=$1
    pandoc -s --self-contained -t html5 -c "$HOME/.config/pandoc/markdown-css-themes/markdown$2.css" --metadata title=' ' --highlight-style=tango $1 -o ${f::-3}.html
}

# export DISPLAY=localhost:0.0
