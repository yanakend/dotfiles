#!/bin/bash

install_path=$HOME
installer_path=`pwd`
cd ${installer_path}
#git submodule init
#git submodule update

install_file()
{
	local _target=$1
	local _linkname=$2
	if [ -e "${_linkname}" ]; then
		mv -f "${_linkname}" "${_linkname}.org"
	fi
	ln -s "${_target}" "${_linkname}"
	echo "linking ${_linkname}"
}

dotfiles=( .bash_profile .bashrc .zshrc .vim .vimrc .gvimrc )

for file in ${dotfiles[@]}
do
	install_file "${installer_path}/${file}" "${install_path}/${file}"
done

git clone git://github.com/Shougo/neobundle.vim.git ${installer_path}/.vim/bundle/neobundle.vim
git clone git://github.com/vim-jp/vimdoc-ja.git ${installer_path}/.vim/bundle/vimdoc-ja

cp -r ~/.vim/bundle/vimdoc-ja/doc/* ~/.vim/doc

vim -N -u NONE -i NONE -V1 -e -s --cmd "source ${installer_path}/.vimrc" --cmd NeoBundleInstall! --cmd qall!
