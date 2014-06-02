#!/bin/bash

# check install git
which git > /dev/null 2>&1 || { echo 'please install git.' 1>&2; exit 1; }

install_path=$HOME$1
installer_path=`pwd`
cd ${installer_path}

install_file()
{
	local _target=$1
	local _linkname=$2
	if [ -e "${_linkname}" ]; then
        echo "'${_linkname}' already exists."
        continue
	fi
	ln -s "${_target}" "${_linkname}"
	echo "linking ${_linkname}"
}

dotfiles=( .tmux.conf .bashrc .zshrc .vim .vimrc .gvimrc .gitconfig )
for file in ${dotfiles[@]}
do
	install_file "${installer_path}/${file}" "${install_path}/${file}"
done

mkdir -p ${installer_path}/.vim/swap
mkdir -p ${installer_path}/.vim/backup
if [ ! -e "${installer_path}/.vim/bundle/neobundle.vim" ]; then
    git clone git://github.com/Shougo/neobundle.vim.git ${installer_path}/.vim/bundle/neobundle.vim
fi
if [ ! -e "${installer_path}/.vim/bundle/vimdoc-ja" ]; then
    git clone git://github.com/vim-jp/vimdoc-ja.git ${installer_path}/.vim/bundle/vimdoc-ja
    cp -r ${installer_path}/.vim/bundle/vimdoc-ja/doc/* ${install_path}/.vim/doc
fi
vim -N -u NONE -i NONE -V1 -e -s --cmd "source ${installer_path}/.vimrc" +NeoBundleInstall! +qa

# link git tools
if which brew > /dev/null 2>&1; then
  if [ ! -e ${installer_path}/bin/diff-highlight ]; then
    mkdir -p ${installer_path}/bin
    ln -s "$(brew --prefix git)/share/git-core/contrib/diff-highlight/diff-highlight" ${installer_path}/bin
    [ $? -eq 0 ] && echo "create symbolic link diff-highlight."
  fi

#if [ ! -e ~/local/zsh/functions/_git ]; then
#  mkdir -p ~/local/zsh/functions
#  ln -s "$PWD/modules/git/contrib/completion/git-completion.zsh" ~/local/zsh/functions/_git
#  [ $? -eq 0 ] && echo "create symbolic link git-completion.zsh to _git"
#fi
fi

