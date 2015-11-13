#-------------------------------------------------------------------------------
# path
typeset -U path PATH cdpath fpath manpath sudo_path

# android
export ANDROID_HOME=~/Library/Android/sdk

path=(
  ~/bin(N-/)
  ~/dotfiles/bin(N-/)
  ~/.cabal/bin(N-/)
  ~/.rbenv/shims(N-/)
  /opt/chefdk/bin(N-/)
  /usr/local/opt/ruby/bin/refe(N-/)
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /usr/local/heroku/bin(N-/)
  $ANDROID_HOME/tools(N-/)
  $ANDROID_HOME/platform-tools(N-/)
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

# node
export NVM_DIR=~/.nvm
[ -f $(brew --prefix nvm)/nvm.sh ] && source $(brew --prefix nvm)/nvm.sh

source ~/.gvm/scripts/gvm
# golang
if [ -x "`which go`" ]; then
  export GOPATH=$HOME/repos/go
  path=(
    ${path}
    $GOPATH/bin(N-/)
  )
fi
# rbenv
if [ -x "`which rbenv`" ]; then
  eval "$(rbenv init -)"
fi

