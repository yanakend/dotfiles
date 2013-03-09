git clone git://github.com/Shougo/neobundle.vim.git %CD%\.vim\bundle\neobundle.vim

 
mklink %USERPROFILE%\.bashrc %CD%\.bashrc
mklink %USERPROFILE%\.bashrc_profile %CD%\.bashrc_profile
mklink %USERPROFILE%\.zshrc %CD%\.zshrc
mklink /d %USERPROFILE%\.vim %CD%\.vim
mklink %USERPROFILE%\.vimrc %CD%\.vimrc
mklink %USERPROFILE%\.gvimrc %CD%\.gvimrc


copy %CD%\.vim\bundle\vimdoc-ja\doc\ %USERPROFILE%\.vim\doc
