set nocompatible                " desactiva compatibilidad con vi
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#infect()          " activa pathogen
call pathogen#helptags()

set modelines=0

set undofile                    " guarda los cambios en un fichero, de modo que
                                " podemos hacer undo aun despues de cerrar el
                                " fichero
"nnoremap / /\v                  " para usar expresiones regulares de perl
"vnoremap / /\v

"set hidden                      " permite abrir un nuevo fichero con :e sin
                                "cerrar el primero

set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set copyindent                  " copy the previous indentation on autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch                   " set show matching parenthesis
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
                                "    case-sensitive otherwise
set smarttab                    " insert tabs on the start of a line according to
                                "    shiftwidth, not tabstop
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set expandtab                   " introduce espacios al pulsar tab
"set textwidth=80                " rompe las líneas al superar los 80 caracteres
set wrap                        " cortar las lineas
set textwidth=79                " en el caracter 80
set formatoptions=qrn1          
set colorcolumn=85              " pone una linea de color en linea 85
set tabstop=4                   " usa 4 espacios al presionar tab
set softtabstop=4
set shiftwidth=4                " numero de espacios a usar para autoindentacion
set autoindent                  " Respetar automát. el sangrado de la línea ant
" set background=light            " esquema de color
set backspace=indent,eol,start
set ruler                       " muestra el numero de línea y columna
set showcmd                     " mostrar comandos parciales en la linea de comandos
set foldmethod=indent           " indentacion compatible con python 
set foldlevel=99

" set number                      " mostrar numeros de linea
" set filetype=htmldjango         " coloreado de sintaxis en las templates de django
set title                       " change the terminal's title
set visualbell                  " don't beep
set noerrorbells                " don't beep
set nobackup
set noswapfile
set mouse=a                     " permitir el uso del raton
cmap w!! w !sudo tee % >/dev/null
                                " permite hacer w! para escribir un fichero para
                                " el que no tenías permisos (en lugar de salir,
                                " sudo...)

syntax on                       " resaltado de sintaxis
filetype on                     " detección de tipo de fichero
filetype plugin on              " para escribir en cualquier lenguaje
filetype plugin indent on       " indentación basada en tipo de fichero

set history=1000                " remember more commands and search history
set undolevels=1000             " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set pastetoggle=<F2>            " pasar a paste-mode para pegar mucho texto

if has('autocmd')
    autocmd filetype python set expandtab
endif

if &t_Co >= 256 || has("gui_running")
    colorscheme mustang
endif

if &t_Co > 2 || has("gui_running")
    syntax on            " switch syntax highlighting on, when the terminal has colors
endif

" Completado de sintaxis
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
set ofu=syntaxcomplete#Complete
set completeopt=menuone,longest,preview

" para activar minibufexp
let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1 

" para que la tecla tab sirva para insertar un tabulador si no hay nada que
" completar. Si lo hay, usa una omnifunction, si no, una completación por
" diccionario y si no completa simplemente una palabra conocida
function! SuperCleverTab()
    if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
        return "\<Tab>"
    else
        if &omnifunc != ''
            return "\<C-X>\<C-O>"
        elseif &dictionary != ''
            return "\<C-K>"
        else
            return "\<C-N>"
        endif
    endif
endfunction

inoremap <Tab> <C-R>=SuperCleverTab()<cr>
