# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
 
# User specific aliases and functions
export http_proxy="http://192.168.20.3:3128/"
export https_proxy="http://192.168.20.3:3128/"
export HTTP_PROXY="http://192.168.20.3:3128/"
export HTTPS_PROXY="http://192.168.20.3:3128/"

# History
function share_history {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTCONTROL=ignoreboth
export HISTIGNORE="fg*:bg*:cd*:fc*:!*"


EDITOR=/usr/bin/vim

SMOPATH='/mnt/smo/'
SMO_SEARCH_PATH='/mnt/smo/SMO_F/01_システム開発/99_個人用フォルダ/磯本/検索資料'
alias  smogrepdoc='find $SMO_SEARCH_PATH -type f -exec grep ^ {} \; |sed -e "s;^$SMO_SEARCH_PATH;;" -e "s;\.txt:;:;" |grep '
alias  smogrepsv='cat ~/smo.list|grep '
alias pbcopy='xsel --clipboard --input'

PS1='\[\e[1;31m\]\h:\W \[\e[1;31m\]\$\[\e[m\] '

# Ctrl-Sでロックされるのを回避
stty stop undef

#パス追加
PATH=$PATH:~/bin
PYTHON3HOME=/usr/local/python35
export PATH=$PYTHON3HOME/bin:$PATH

#tmux起動
#[[ -z "$TMUX" && ! -z "$PS1" ]] && tmux


# added by Anaconda3 2.5.0 installer
export PATH="/home/isomoto/anaconda3/bin:$PATH"
