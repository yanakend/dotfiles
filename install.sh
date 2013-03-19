#!/bin/bash

install_path=$HOME
installer_path=`pwd`
cd ${installer_path}
#git submodule init
#git submodule update

git clone git://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim

install_file()
{
	local _target=$1
	local _linkname=$2
	if [ ! -e "${_linkname}" ]; then
		ln -s "${_target}" "${_linkname}"
		echo "linking ${_linkname}"
	else
		echo "skipping ${_linkname}"
	fi
}

dotfiles=( .bashrc_profile .bashrc .zshrc .vim .vimrc .gvimrc )

for file in ${dotfiles[@]}
do
	install_file "${installer_path}/${file}" "${install_path}/${file}"
done

cp -r ~/.vim/bundle/vimdoc-ja/doc/* ~/.vim/doc
