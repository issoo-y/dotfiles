autoload -U compinit
compinit

#色の定義
autoload -U colors ; colors
local DEFAULT=%{$reset_color%}
local RED=%{$fg[red]%}
local GREEN=%{$fg[green]%}
local YELLOW=%{$fg[yellow]%}
local BLUE=%{$fg[blue]%}
local PURPLE=%{$fg[purple]%}
local CYAN=%{$fg[cyan]%}
local WHITE=%{$fg[white]%}
local B_RED=%{$fg_bold[red]%}
local B_GREEN=%{$fg_bold[green]%}
local B_YELLOW=%{$fg_bold[yellow]%}
local B_BLUE=%{$fg_bold[blue]%}
local B_PURPLE=%{$fg_bold[purple]%}
local B_CYAN=%{$fg_bold[cyan]%}
local B_WHITE=%{$fg_bold[white]%}

setopt auto_param_slash      # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs             # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt list_types            # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt auto_menu             # 補完キー連打で順に補完候補を自動で補完
setopt auto_param_keys       # カッコの対応などを自動的に補完
setopt interactive_comments  # コマンドラインでも # 以降をコメントと見なす
setopt magic_equal_subst     # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt complete_in_word      # 語の途中でもカーソル位置で補完
setopt always_last_prompt    # カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt print_eight_bit       # 日本語ファイル名等8ビットを通す
setopt extended_glob         # 拡張グロブで補完(~とか^とか。例えばless *.txt~memo.txt ならmemo.txt 以外の *.txt にマッチ)
setopt globdots              # 明確なドットの指定なしで.から始まるファイルをマッチ
setopt list_packed           # リストを詰めて表示
setopt auto_pushd            # cdしたらカレントディレクトリをpushdする
setopt correct               # コマンド行のすべての引数に対してスペルミスの修正を行う
setopt auto_cd               # cdしたらカレントディレクトリをpushdする
setopt list_packed           # 選択時に横方向に移動する
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups     # 前と重複する行は記録しない
setopt share_history        # 同時に起動したzshの間でヒストリを共有する
setopt hist_reduce_blanks   # 余分なスペースを削除してヒストリに保存する
setopt HIST_IGNORE_SPACE    # 行頭がスペースのコマンドは記録しない
setopt HIST_IGNORE_ALL_DUPS # 履歴中の重複行をファイル記録前に無くす
setopt HIST_FIND_NO_DUPS    # 履歴検索中、(連続してなくとも)重複を飛ばす
setopt HIST_NO_STORE        # histroyコマンドは記録しない
zshaddhistory() {
    local line=${1%%$'\n'} #コマンドライン全体から改行を除去したもの
    local cmd=${line%% *}  # １つ目のコマンド
    # 以下の条件をすべて満たすものだけをヒストリに追加する
    [[ ${#line} -ge 5
        && ${cmd} != (l|l[sal])
        && ${cmd} != (cd)
        && ${cmd} != (m|man)
        && ${cmd} != (r[mr])
        && ${cmd} != (t|trans)
    ]]
}

export GOPATH="$HOME/dev"

# cdr, add-zsh-hook を有効にする
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
 
# cdr の設定
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true

# zplug
# $ curl -sL zplug.sh/installer | zsh
source ~/.zplug/init.zsh
zstyle ":anyframe:selector:" use peco
zplug 'mollifier/anyframe'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug 'zsh-users/zsh-completions'
zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-history-substring-search"

if ! zplug check --verbose; then
    printf 'Install?[y/n]: '
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

# keybind
bindkey -v

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
#bindkey -M viins '\er' history-incremental-pattern-search-forward
bindkey -M viins '^?'  backward-delete-char
bindkey -M viins '^A'  beginning-of-line
bindkey -M viins '^B'  backward-char
bindkey -M viins '^D'  delete-char-or-list
bindkey -M viins '^E'  end-of-line
#bindkey -M viins '^F'  forward-char
bindkey -M viins '^G'  send-break
bindkey -M viins '^H'  backward-delete-char
bindkey -M viins '^K'  kill-line
#bindkey -M viins '^N'  down-line-or-history
#bindkey -M viins '^P'  up-line-or-history
#bindkey -M viins '^R'  history-incremental-pattern-search-backward
bindkey -M viins '^U'  backward-kill-line
bindkey -M viins '^W'  backward-kill-word
bindkey -M viins '^Y'  yank
bindkey -M vicmd 'j' history-substring-search-up
bindkey -M vicmd 'k' history-substring-search-down

#bindkey '^p' history-beginning-search-backward
#bindkey '^n' history-beginning-search-forward
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down
#bindkey '^]' anyframe-widget-cd-ghq-repository
bindkey '^r' anyframe-widget-put-history
bindkey '^x^b' anyframe-widget-checkout-git-branch
bindkey '^xb' anyframe-widget-checkout-git-branch
#bindkey '^x^f' anyframe-widget-cdr
#bindkey '^xf' anyframe-widget-cdr
#bindkey '^f' anyframe-widget-insert-filename

# vi モード表示
autoload -Uz colors; colors
autoload -Uz add-zsh-hook
autoload -Uz terminfo
terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]
left_down_prompt_preexec() {
    print -rn -- $terminfo[el]
}
add-zsh-hook preexec left_down_prompt_preexec

#PROMPT="%{${fg_bold[green]}%}%n%#%{$reset_color%} "
#RPROMPT="%{${fg[green]}%}%/%{[m%} "
#PROMPT2="%{${fg_bold[green]}%}%_%#%{[m%} "
#function zle-keymap-select zle-line-init zle-line-finish
#{
    #case $KEYMAP in
        #main|viins)
            #PROMPT_2="%{${fg_bold[green]}%}%n%#%{$reset_color%} "
            #;;
        #vicmd)
            #PROMPT_2="%{${fg_bold[blue]}%}%n%#%{$reset_color%} "
            #;;
        #vivis|vivli)
            #PROMPT_2="%{${bg[yellow]}${fg[green]}%}%n%#%{$reset_color%} "
            #;;
    #esac
    #[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%{${fg[green]}%}[${HOST%%.*}]${PROMPT_2}" || PROMPT="${PROMPT_2}"
#
    #zle reset-prompt
#}
PROMPT="%{$B_RED%}%?:%#%{$DEFAULT%} "
RPROMPT="%{$GREEN%}%/%{[m%} "
PROMPT2="%{$B_GREEN%}%_%#%{[m%} "
function zle-keymap-select zle-line-init zle-line-finish
{
    case $KEYMAP in
        main|viins)
            PROMPT="%{$B_RED%}%?:%#%{$DEFAULT%} "
            ;;
        vicmd)
            PROMPT="%{$B_BLUE%}%?:%#%{$DEFAULT%} "
            ;;
        vivis|vivli)
            PROMPT="%{${bg[yellow]}$B_RED%}%?:%#%{$DEFAULT%} "
            ;;
    esac

    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
zle -N edit-command-line


export EDITOR='vim'
export LANG=ja_JP.UTF-8
[ -d "$HOME/anaconda3/bin/" ] && export PATH="$HOME/anaconda3/bin:$PATH"
[ -d "$GOPATH/bin/" ] && export PATH="$GOPATH/bin:$PATH"
[ -d "/usr/local/go/bin" ] && export PATH="/usr/local/go/bin:$PATH"
export GOPATH
[ -d "/$HOME/anaconda3/bin" ] && export PATH="$HOME/anaconda3/bin:$PATH"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# 起動していなければtmuxを起動
[ "$TMUX" = "" ] && /usr/bin/tmux


#############################################

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias grep='grep --color=auto'
alias l='ls -CF'
alias ls='ls --color=auto'  
alias ll='ls -alF'
alias la='ls -la'
alias ptipython='ptipython --vi'
alias lstokyo='cat /media/sf_vdata/192.168.20.7.old.txt |nkf -Luw '
alias bitcoin='docker exec testnet /usr/local/bin/bitcoin-cli '
alias gtags='gtags --gtagslabel=pygments '
alias t='trans :ja '
#alias gtags='gtags --gtagslabel=pygments'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
export NVM_DIR="$HOME/.nvm"
