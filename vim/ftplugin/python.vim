nmap <F5> :!clear && python3 -i %  <CR>
nmap <F6> :!clear && python -i %  <CR>
set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4
set tabstop=4
inoremap # X#

let g:syntastic_python_python_exec = '/usr/local/bin/python'
let g:syntastic_python_checkers = ['flake8']

highlight ColorColumn ctermbg=darkgrey
set colorcolumn=101
set tw=100
highlight LineNr ctermfg=darkgrey
