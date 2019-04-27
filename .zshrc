#environment variable
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:$HOME/.config/composer/vendor/bin
export ZSH="$HOME/.oh-my-zsh"
export UPDATE_ZSH_DAYS=13
export LANG=ja_JP.UTF-8

#zsh settings
ZSH_THEME="tjkirch"
DISABLE_AUTO_UPDATE="false"
DISABLE_LS_COLORS="false"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

#load oh-my-zsh
source $ZSH/oh-my-zsh.sh

#source custom config
[ -f ~/.zsh/myconfig.zsh ] && source ~/.zsh/myconfig.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias chromium="/usr/bin/chromium-browser --start-fullscreen --disable-session-crashed-bubble --disable-infobars"
alias wifi="sudo wifi-menu"
alias v="vim"
alias e="emacs -nw"
alias emacs="emacs -nw"
alias pandoc_html="pandoc -s --self-contained -t html5 -c d:/pandoc_style/markdown7.css"
