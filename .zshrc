autoload -U compinit
compinit

export GOPATH="$HOME/go"

# autoload predict-on
# predict-on

setopt auto_pushd
setopt correct
setopt auto_cd
setopt list_packed

# cdr, add-zsh-hook を有効にする
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
 
# cdr の設定
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true

bindkey -v

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey -M viins '\er' history-incremental-pattern-search-forward
bindkey -M viins '^?'  backward-delete-char
bindkey -M viins '^A'  beginning-of-line
bindkey -M viins '^B'  backward-char
bindkey -M viins '^D'  delete-char-or-list
bindkey -M viins '^E'  end-of-line
bindkey -M viins '^F'  forward-char
bindkey -M viins '^G'  send-break
bindkey -M viins '^H'  backward-delete-char
bindkey -M viins '^K'  kill-line
bindkey -M viins '^N'  down-line-or-history
bindkey -M viins '^P'  up-line-or-history
bindkey -M viins '^R'  history-incremental-pattern-search-backward
bindkey -M viins '^U'  backward-kill-line
bindkey -M viins '^W'  backward-kill-word
bindkey -M viins '^Y'  yank

bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward


HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt hist_ignore_all_dups
setopt share_history        # share command history data


# vi モード表示
autoload -Uz colors; colors
autoload -Uz add-zsh-hook
autoload -Uz terminfo
terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]
left_down_prompt_preexec() {
    print -rn -- $terminfo[el]
}
add-zsh-hook preexec left_down_prompt_preexec

PROMPT="%{${fg_bold[black]}%}%n%#%{$reset_color%} "
#RPROMPT="%{[31m%}%/%{[m%} "
RPROMPT="%{${fg[black]}%}%/%{[m%} "
#PROMPT2="%{[31m%}%_%#%{[m%} "
PROMPT2="%{${fg_bold[black]}%}%_%#%{[m%} "
function zle-keymap-select zle-line-init zle-line-finish
{
    case $KEYMAP in
        main|viins)
            PROMPT_2="%{${fg_bold[black]}%}%n%#%{$reset_color%} "
            ;;
        vicmd)
            #PROMPT_2="%{${bg[black]}${fg[white]}%}%n%#%{$reset_color%} "
            PROMPT_2="%{${fg_bold[blue]}%}%n%#%{$reset_color%} "
            ;;
        vivis|vivli)
            PROMPT_2="%{${bg[yellow]}${fg[black]}%}%n%#%{$reset_color%} "
            ;;
    esac
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%{${fg[black]}%}[${HOST%%.*}]${PROMPT_2}" || PROMPT="${PROMPT_2}"

    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
zle -N edit-command-line


export EDITOR='/usr/local/bin/vim'
export LANG=ja_JP.UTF-8
[ -d "$HOME/anaconda3/bin/" ] && export PATH="$HOME/anaconda3/bin:$PATH"
[ -d "$GOPATH/bin/" ] && export PATH="$GOPATH/bin:$PATH"
[ -d "/usr/local/go/bin" ] && export PATH="/usr/local/go/bin:$PATH"
#!/bin/sh
#export PATH="/home/isomoto/anaconda3/bin:$PATH"
export GOPATH

#########[ "$TMUX" = "" ] && /usr/bin/tmux

function percol_select_history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
    CURSOR=$#BUFFER             # move cursor
    zle -R -c                   # refresh
}
zle -N percol_select_history
bindkey '^R' percol_select_history

# w3m でGoogle translate English->Japanese
function gte() {
  google_translate "$*" "en-ja"
}
 
# w3m でGoogle translate Japanese->English
function gtj() {
  google_translate "$*" "ja-en"
}
 
# 実行方法
# google_translate "検索文字列" [翻訳オプション(en-ja 英語->日本語)]
function google_translate() {
  local str opt cond
 
  if [ $# != 0 ]; then
    str=`echo $1 | sed -e 's/  */+/g'` # 1文字以上の半角空白を+に変換
    cond=$2
    if [ $cond = "ja-en" ]; then
      # ja -> en 翻訳
      opt='?hl=ja&sl=ja&tl=en&ie=UTF-8&oe=UTF-8'
    else
      # en -> ja 翻訳
      opt='?hl=ja&sl=en&tl=ja&ie=UTF-8&oe=UTF-8'
    fi
  else
    opt='?hl=ja&sl=en&tl=ja&ie=UTF-8&oe=UTF-8'
  fi
 
  opt="${opt}&text=${str}"
  w3m +13 "http://translate.google.com/${opt}"
}


alias ll='ls -l --color=auto'
alias la='ls -la --color=auto'
alias ptipython='ptipython --vi'
alias lstokyo='cat /media/sf_vdata/192.168.20.7.old.txt |nkf -Luw '
alias bitcoin='docker exec testnet /usr/local/bin/bitcoin-cli '
