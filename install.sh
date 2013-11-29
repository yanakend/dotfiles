#!/bin/bash

install_path=$HOME$1
installer_path=`pwd`
cd ${installer_path}

install_file()
{
	local _target=$1
	local _linkname=$2
	if [ -e "${_linkname}" ]; then
		rm -r "${_linkname}"
	fi
	ln -s "${_target}" "${_linkname}"
	echo "linking ${_linkname}"
}

dotfiles=( .tmux.conf .bashrc .zshrc .vim .vimrc .gvimrc .gitconfig bin )

for file in ${dotfiles[@]}
do
	install_file "${installer_path}/${file}" "${install_path}/${file}"
done

mkdir -p ${installer_path}/.vim/swap
mkdir -p ${installer_path}/.vim/backup

if [ ! -d "${installer_path}/.vim/bundle/neobundle.vim" ]; then
	git clone git://github.com/Shougo/neobundle.vim.git ${installer_path}/.vim/bundle/neobundle.vim
fi
if [ ! -d "${installer_path}/.vim/bundle/vimdoc-ja" ]; then
	git clone git://github.com/vim-jp/vimdoc-ja.git ${installer_path}/.vim/bundle/vimdoc-ja
	cp -r ${installer_path}/.vim/bundle/vimdoc-ja/doc/* ${install_path}/.vim/doc
fi


vim -N -u NONE -i NONE -V1 -e -s --cmd "source ${installer_path}/.vimrc" --cmd NeoBundleInstall! --cmd qall!
