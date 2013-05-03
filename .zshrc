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
setopt no_beep
 
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

# 入力ミス確認用プロンプト
SPROMPT=$'correct: %R -&gt; %r ? [n,y,a,e]: '
 
# ^Dでログアウトしないようにする
setopt ignore_eof
 
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
alias LESS="less -IM -x 4"
alias where="command -v"
alias j="jobs -l"

## デフォルトオプションの設定
export GREP_OPTIONS
### バイナリファイルにはマッチさせない。
GREP_OPTIONS="--binary-files=without-match"
### grep対象としてディレクトリを指定したらディレクトリ内を再帰的にgrepする。
#GREP_OPTIONS="--directories=recurse $GREP_OPTIONS"
### 拡張子が.tmpのファイルは無視する。
GREP_OPTIONS="--exclude=\*.tmp $GREP_OPTIONS"
## 管理用ディレクトリを無視する。
GREP_OPTIONS="--exclude-dir=.svn $GREP_OPTIONS"
GREP_OPTIONS="--exclude-dir=.git $GREP_OPTIONS"

### 可能なら色を付ける。
GREP_OPTIONS="--color=auto $GREP_OPTIONS"

export EDITOR=/usr/bin/vi 
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

export MANPATH=/opt/local/man:$MANPATH

#=============================
# source auto-fu.zsh
#=============================
if [ -f ~/dotfiles/.zsh/auto-fu.zsh/auto-fu.zsh ]; then
    source ~/dotfiles/.zsh/auto-fu.zsh/auto-fu.zsh
    function zle-line-init () {
        auto-fu-init
    }
    zle -N zle-line-init
    zstyle ':completion:*' completer _oldlist _complete
fi

# .zshrcローカル設定ファイル読み込み
[ -f ~/.zshrc.local ] && source ~/.zshrc.local


# tmux ssh 時に新規ウィンドウを作る
ssh_tmux() {
    ssh_cmd="ssh $@"
    tmux new-window -n "$*" "$ssh_cmd"
}
if [ $TERM = "screen" ] ; then
    tmux lsw
    if [ $? -eq 0 ] ; then
        alias ssh=ssh_tmux
    fi
fi
