" General
    nmap <F5> :GoRun <CR>
    nmap <F6> :GoTest <CR>
    nmap <F3> :GoDoc <CR>
    nmap <F12> :GoDef <CR>

"vim-go settings

    " Highlighting
    let g:go_highlight_functions = 1  
    let g:go_highlight_methods = 1  
    let g:go_highlight_structs = 1  
    let g:go_highlight_operators = 1  
    let g:go_highlight_build_constraints = 1 

    " Misc
    let g:molokai_original = 1
    let g:go_disable_autoinstall = 0
    let g:go_fmt_command = "goimports"

    " Syntastic
