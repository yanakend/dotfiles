#!/bin/zsh
 
#-------------------------------------------------------------------------------
bindkey -e
autoload -Uz compinit
compinit

#-------------------------------------------------------------------------------
# prompt 
autoload -Uz colors
colors
PROMPT="%/%% "
PROMPT2="%_%% "
SPROMPT=$'correct: %R -&gt; %r ? [n,y,a,e]: '
 
# <Tab> でパス名の補完候補を表示したあと、
# 続けて <Tab> を押すと候補からパス名を選択できるようになる
# 候補を選ぶには <Tab> か Ctrl-N,B,F,P
zstyle ':completion:*:default' menu select=1
# 補完の時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
 
# 単語の一部として扱われる文字のセットを指定する
# ここではデフォルトのセットから / を抜いたものとする
# こうすると、 Ctrl-W でカーソル前の1単語を削除したとき、 / までで削除が止まる
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# history settings
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt nolistbeep no_beep # silent mode
setopt correct            # correct miss command
setopt ignore_eof         # permission logout press ^D
setopt hist_ignore_dups   # 直前と同じコマンドは記憶しない
setopt share_history      # ヒストリを共有
setopt extended_history   # ヒストリに時刻を追加
setopt hist_reduce_blanks # 余分な空白は詰める
setopt hist_ignore_space  # 最初がスペースで始まる場合は記憶しない
setopt inc_append_history # 履歴をインクリメンタルに追加
setopt hist_ignore_space  # コマンドがスペースで始まる場合、コマンド履歴に追加しない
setopt rmstar_wait        # rm * を実行時に確認
 
#-------------------------------------------------------------------------------
# search histories
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

#-------------------------------------------------------------------------------
# alias
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias vi="vim"
alias ls="ls -FG"
alias la="ls -aFG"
alias ll="ls -lhFG"
alias lla="ls -alhFG"
alias cp="cp -i"
alias mv="mv -i"
alias sd=sudo
alias cronedit="crontab -e"
alias eu='iconv -f euc-jp -t utf-8'
alias neu='nkf -uEw8m0'
alias nes='nkf -uEsm0'
alias ag='ag -S --stats --pager "less -F"'
alias agh='ag --hidden'

# バイナリファイルにはマッチさせない。
# 可能なら色を付ける。
# 拡張子が.tmpのファイルは無視する。
export GREP_OPTIONS
GREP_OPTIONS="--binary-files=without-match --color=auto --exclude=\*.tmp"

# editor setting
export EDITOR=vim
# if not exist vim, execute vim instead of vi.
if ! type vim > /dev/null 2>&1; then
  alias vim=vi
fi

# git
if which git > /dev/null 2>&1 ; then
    function cd-gitroot() {
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
      cd `pwd`/`git rev-parse --show-cdup`
    fi
  }
fi

# tmux
if which tmux > /dev/null 2>&1; then
	ssh_tmux() {
		ssh_cmd="\ssh $@"
		tmux new-window -n "$*" "$ssh_cmd"
	}
	if [ $TERM = "screen" ] ; then
		tmux lsw
		if [ $? -eq 0 ] ; then
			alias tssh=ssh_tmux
		fi
	fi
  # ログイン時にtmux 起動
  if [ $SHLVL = 1 ]; then
    tmux attach || tmux
  fi
fi

# z.git
if [ -f $(brew --prefix z)/etc/profile.d/z.sh ] ; then
  _Z_CMD=j
  source $(brew --prefix z)/etc/profile.d/z.sh
fi

# hook function
precmd () {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
  _z --add "$(pwd -P)"
}

# vis
function vis() {
  args=()
  for i in "$@"; do
    if [ -e "$i" ]; then
      args[$(( $#args + 1))]="sudo:$i"
    else
      args[$(( $#args + 1))]="$i"
    fi
  done
  command vim $args
}

#-------------------------------------------------------------------------------
# VCS(git|svn|hg)の情報を取得するzshの便利関数
setopt prompt_subst
autoload -Uz vcs_info
# 表示フォーマットの指定
# %r レポジトリ
# %b ブランチ情報
# %a アクション名(mergeなど)
zstyle ':vcs_info:*' formats '[%r:%b]'
zstyle ':vcs_info:*' actionformats '[%r:%b|%a]'
# バージョン管理されているディレクトリにいれば表示，そうでなければ非表示
RPROMPT="%1(v|%F{blue}%1v%f|)"

#-------------------------------------------------------------------------------
# phpbrew
[ -f ~/.phpbrew/bashrc ] && source ~/.phpbrew/bashrc
