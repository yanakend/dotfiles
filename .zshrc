#!/bin/zsh
 
# emacs風のキーバインド
bindkey -e

# 補完
autoload -Uz compinit
compinit

# ビープ音を消す
setopt nolistbeep 
setopt no_beep
 
# ミスコマンドの訂正
setopt correct

# プロンプト
autoload -Uz colors
colors
setopt prompt_subst
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

setopt hist_ignore_dups   # 直前と同じコマンドは記憶しない
setopt share_history      # ヒストリを共有
setopt extended_history   # ヒストリに時刻を追加
setopt hist_reduce_blanks # 余分な空白は詰める
setopt hist_ignore_space  # 最初がスペースで始まる場合は記憶しない
 
# ヒストリの検索
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "^U" backward-kill-line
 
# cdの便利化
setopt auto_cd # ディレクトリ名だけでcdする
setopt auto_pushd # cdの履歴
setopt pushd_ignore_dups # 重複しないようにする
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# コマンドがスペースで始まる場合、コマンド履歴に追加しない
# 例： <Space>echo hello と入力
setopt hist_ignore_space

# <Tab> でパス名の補完候補を表示したあと、
# 続けて <Tab> を押すと候補からパス名を選択できるようになる
# 候補を選ぶには <Tab> か Ctrl-N,B,F,P
zstyle ':completion:*:default' menu select=1

# 単語の一部として扱われる文字のセットを指定する
# ここではデフォルトのセットから / を抜いたものとする
# こうすると、 Ctrl-W でカーソル前の1単語を削除したとき、 / までで削除が止まる
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# rm * を実行時に確認
setopt rmstar_wait
 
# lsのカラー設定
export LSCOLORS=ExFxCxDxBxEGEDABAGACAD
 
# エイリアス
alias vi="vim"
alias ls="ls -FG"
alias ll="ls -lhG"
alias la="ls -aGv"
alias cp="cp -i"
alias mv="mv -i"
alias emacs="emacs -nw"
alias LESS="less -IM -x 4"
alias where="command -v"
alias j="jobs -l"
alias cronedit="crontab -e"

# バイナリファイルにはマッチさせない。
# 可能なら色を付ける。
# 拡張子が.tmpのファイルは無視する。
export GREP_OPTIONS="--binary-files=without-match --color=auto --exclude=\*.tmp $GREP_OPTIONS"

export EDITOR=/usr/local/bin/vim

export ANDROID_SDK_ROOT="/Applications/adt-bundle-mac/sdk"
export NDK_ROOT="/Applications/android-ndk" 

export PATH=~/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH="$(brew --prefix josegonzalez/php/php55)/bin:$PATH"

function cd-gitroot() {
  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
	cd `pwd`/`git rev-parse --show-cdup`
  fi
}

# VCS(git|svn|hg)の情報を取得するzshの便利関数 vcs_infoを使う
autoload -Uz vcs_info
# 表示フォーマットの指定
# %b ブランチ情報
# %a アクション名(mergeなど)
zstyle ':vcs_info:*' formats '[%r:%b]'
zstyle ':vcs_info:*' actionformats '[%r:%b|%a]'
# バージョン管理されているディレクトリにいれば表示，そうでなければ非表示
RPROMPT="%1(v|%F{blue}%1v%f|)"

# tmux ssh 時に新規ウィンドウを作る
if which tmux > /dev/null 2>&1; then
	ssh_tmux() {
		ssh_cmd="ssh $@"
		tmux new-window -n "$*" "$ssh_cmd"
	}
	if [ $TERM = "screen" ] ; then
		tmux lsw
		if [ $? -eq 0 ] ; then
			alias tssh=ssh_tmux
		fi
	fi
fi

# .zshrcローカル設定ファイル読み込み
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# プロンプトを表示直前に呼び出される
precmd () {
	psvar=()
	LANG=en_US.UTF-8 vcs_info
	[[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
