#!/bin/zsh
 
export GNUTERM=aqua
export DISPLAY=0.0
 
PATH="$PATH":/Users/$USER/.bin
PATH="$PATH":/usr/local/bin
 
# 補完
autoload -U compinit
compinit
# ビープ音を消す
setopt nolistbeep 
 
# ミスコマンドの訂正
setopt correct
 
# プロンプト
autoload colors
colors
setopt prompt_subst
#cd するたびに clear と ls をする
chpwd() { clear }
PROMPT="%/%% "
PROMPT2="%_%% "
SPROMPT="%r is correct? [n,y,a,e]: "

# 複数行入力時のプロンプト
# PROMPT2="%/%% "
# 入力ミス確認用プロンプト
SPROMPT=$'correct: %R -&gt; %r ? [n,y,a,e]: '
 
# ^Dでログアウトしないようにする
setopt ignore_eof
 
# ビープ音なし
setopt no_beep
 
# 補完の時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
 
# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups # 直前と同じコマンドは記憶しない
setopt share_history # ヒストリを共有
setopt extended_history # ヒストリに時刻を追加
setopt hist_reduce_blanks # 余分な空白は詰める
setopt hist_ignore_space # 最初がスペースで始まる場合は記憶しない
 
# ヒストリの検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
 
# emacs風のキーバインド
bindkey -e
 
# cdの便利化
setopt auto_cd # ディレクトリ名だけでcdする
setopt auto_pushd # cdの履歴
setopt pushd_ignore_dups # 重複しないようにする
 
# rm * を実行時に確認
setopt rmstar_wait
 
# lsのカラー設定
export LSCOLORS=ExFxCxDxBxEGEDABAGACAD
 
# エイリアス
alias ls="ls -FG"
alias ll="ls -lhaG"
alias la="ls -aGv"
alias rm="rm -rf"
alias cp="cp -i"
alias mv="mv -i"
alias emacs="emacs -nw"

export EDITOR=/usr/bin/vi 
