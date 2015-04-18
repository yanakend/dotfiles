[ "$INCLUDED_ZPROFILE" -eq "1" ] && return
export INCLUDED_ZPROFILE=1

#-------------------------------------------------------------------------------
# path
typeset -U path PATH cdpath fpath manpath sudo_path

path=(
  ~/bin(N-/)
  ~/dotfiles/bin(N-/)
  ~/.cabal/bin(N-/)
  /usr/local/opt/ruby/bin/refe(N-/)
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /usr/local/heroku/bin(N-/)
  ${path}
)

path=(
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

