"Render
nmap <F5> :!clear && pdflatex % <CR>
nmap <F6> :!clear && pdflatex % && evince $(echo % \| sed 's/tex$/pdf/')<CR>
"Consistent itemizing
nmap <F9> :%s/\(\\item.*[^};:.\t ]\)\s*\.*\s*$/\1./g <CR>
"Wrapping
nmap j gj
nmap k gk
nmap $ g$
nmap ^ g^
nmap 0 g0
vmap j gj
vmap k gk
vmap $ g$
vmap ^ g^
vmap 0 g0
set wrap
set linebreak
set showbreak=.\ \ \ 

"Spelling
set spell spelllang=en_gb

" Abbreviations
    " Syntax
    ab i.e. i.e.\
    ab e.g. e.g.\
    ab (i.e. (i.e.\
    ab (e.g. (e.g.\

    " Spelling
    "ab adn and
    "ab ot to
    "ab taht that
    "ab teh the
    "ab hte the
    "ab dentoed denoted
    "ab comonent component
    "ab antennas antennae

highlight ColorColumn ctermbg=darkgrey
set colorcolumn=101
set tw=100
highlight LineNr ctermfg=darkgrey

let g:vimtex_complete_enabled=1
