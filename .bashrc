export MAINDRIVE='/mnt/c'
export EDITOR='vim'
export TERM="xterm-256color"
export SCRIPTS=$HOME/scripts
export PATH=$PATH:~/phpctags/phpctags.phar
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/.composer/vendor/bin
export PATH=$PATH:~/.emacs.d/bin
export PATH=$PATH:~/.yarn/bin
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export PS1="\[\033[38;5;38m\]\u\[\]\[\033[38;5;15m\]@\[\]\[\033[38;5;172m\]\h\[\]\[\033[38;5;15m\] \[\]\w\[\]\n\[\]\[\033[38;5;41m\]$\[\]\[\033[38;5;15m\] \[\]"
export TMUX_TMPDIR=/tmp/tmp.tmux
export DT="$MAINDRIVE/Users/kimura.AZET/Desktop"
export WO="$MAINDRIVE/workspace"
export W="$MAINDRIVE/workspace"

alias w="cd $W"
alias s="cd $W/surala"
alias dbsc="cd $MAINDRIVE/メモ/すらら/DBスクリプト/db_script"
alias ll="ls -l"
alias rc="source $HOME/.bashrc"
alias vrc="vim $HOME/.bashrc"
alias frc="vim $HOME/.config/fish/config.fish"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias sv='cd $W/surala && nvim'
alias vimdiff='nvim -d'
alias e="emacs -nw"
alias emacs="emacs -nw"
alias ctags="/usr/local/bin/ctags -R --options=$HOME/.ctags"
alias rg="rg --ignore-file=$HOME/.config/ignore/ignore "

alias fl="find . -type f -printf '/%P\n' | sort"

#run weasel-pageant on WSL
if [[ "`uname -r | grep -i Microsoft`"  ]]; then
  if [[ -f /mnt/c/app/weasel-pageant/weasel-pageant ]]; then
  	eval $(/mnt/c/app/weasel-pageant/weasel-pageant -rqb -a $HOME/.weasel-pageant.sock);
  fi
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

PATH="/home/yuta/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/yuta/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/yuta/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/yuta/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/yuta/perl5"; export PERL_MM_OPT;

mdtoh () {
    f=$1
    pandoc -s --self-contained -t html5 -c "$MAINDRIVE/markdown-css/markdown$2.css" --toc --metadata title=' ' --highlight-style=tango $1 -o ${f::-3}.html
}

if [[ $(uname -r) =~ Microsoft$ ]]; then
	mdpdf () {
		f=$(echo $1 | sed -e "s/.md//")
		echo $f
		mdtoh $1 6
		wkhtmltopdf.exe $f.html $f.pdf
	}
fi

# convert .png to .ico with imagemagick
png2ico () {
    local i="${1}" o="${2:-${1:r}.ico}" s="${png2ico_size:-256}"
    convert -resize x${s} -gravity center -crop ${s}x${s}+0+0 "$i" -flatten -colors 256 -background transparent "$o"
}

# compreses jpeg with imagemagick
jpgc () {
  local out=compressed.$1
  convert $1 -sampling-factor 4:2:0 -strip -quality 50 -interlace JPEG -colorspace sRGB $out
  mogrify -resize 50% $out
}

heic2jpg () {
  for file in `\find . -maxdepth 1 -type f`; do
    heif-convert $file $file.jpg
  done
}

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#Added by bash script from https://astherier.com/blog/2021/07/windows11-wsl2-wslg-japanese/
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export DefaultIMModule=fcitx
if [ $SHLVL = 1 ] ; then
  (fcitx-autostart > /dev/null 2>&1 &)
  xset -r 49  > /dev/null 2>&1
fi
#Added by bash script: end
