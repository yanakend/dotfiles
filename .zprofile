#-------------------------------------------------------------------------------
# path
# 重複パスを登録しない
typeset -U path PATH cdpath fpath manpath sudo_path

# (N-/): 存在しないディレクトリは登録しない。
#    パス(...): ...という条件にマッチするパスのみ残す。
#            N: NULL_GLOBオプションを設定。
#               globがマッチしなかったり存在しないパスを無視する。
#            -: シンボリックリンク先のパスを評価。
#            /: ディレクトリのみ残す。
path=(
  /usr/local/heroku/bin(N-/)
  ~/bin(N-/)
  ~/dotfiles/bin(N-/)
  /usr/local/opt/ruby/bin/refe(N-/)
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /usr/local/heroku/bin(N-/)
  $(brew --prefix ruby)/bin(N-/)
  ${path}
)

# completion file for zsh
fpath=(
  $(brew --prefix)/share/zsh/site-functions(N-/) 
  $(brew --prefix)/share/zsh-completions(N-/) 
  ${fpath}
)

[ -f /Applications/adt-bundle-mac/sdk ] && export ANDROID_SDK_ROOT="/Applications/adt-bundle-mac/sdk"
[ -f /Applications/android-ndk ] && export NDK_ROOT="/Applications/android-ndk" 

# phpbrew
[ -f ~/.phpbrew/bashrc ] && source ~/.phpbrew/bashrc

# rbenv
if [ -x "`which rbenv`" ]; then
  eval "$(rbenv init -)"
fi

