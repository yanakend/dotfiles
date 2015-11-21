setlocal noexpandtab omnifunc=gocomplete#Complete
nmap <buffer> K :GoDoc<CR>
autocmd BufEnter *.go SetGomEnv
autocmd FileType go :hi goErr guifg=Yellow
autocmd FileType go :match goErr /\<err\>/
