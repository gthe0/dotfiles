"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This is the entry point of my vim configuration
"	If unfamilliar with any of the settings, please read the comments below.
"	For further information, please refer to the documentation by typing
"			:h <option> 
"		
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Leader Key
let mapleader=" "
let maplocalleader=" "

"" Line enumeration 
set number

"" Search Options
set hlsearch " Highlight Search result
set incsearch " Real-Time effect of commands related to searching

"" Case Insensitive Searching
set ignorecase "Ignore Case while searching UNLESS /C or Capital later is added
set smartcase  "Prioritizes search results based of the capitalization
set infercase  "Infers the Case based of Search results

"" Windows Options
set splitbelow "Put new windows below current
set splitright "Put new windows right of current
set scrolloff =5 "Minimal number of screen lines to keep above and below the cursor.

"" Tab Options
set expandtab "Use spaces when pressing tab
set shiftwidth =4 "Makes the tab be 4 spaces long
set tabstop =4 

"" WildMenu
set wildmenu "Enables the wild menu
set wildignorecase "Case insensitive command search

"" Apearance
colorscheme darkblue
syntax on "Set syntax highlighting on

" Enable 24-bit true colors if your terminal supports it.
if (has("termguicolors"))

  " https://github.com/vim/vim/issues/993#issuecomment-255651605
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  set termguicolors
endif


"" Turn backup files off 
set nobackup
set nowb
set noswapfile

"" Performance options
"set lazyredraw "This option prevents redrawing when using macros, register e.t.c. (increases perf)

"" General Settings
set backspace =eol,start,indent "Makes backspace go to the upper line when you try to delete the nl character of the previous line
set hidden "Makes the buffers that are not displayed hidden
set encoding =utf-8 "Changes the encoding to UTF-8
set timeoutlen =300 "The time that vim waits for next command input
set mouse =a "Enable mouse for accessing other copy buffer

" Use a line cursor within insert mode and a block cursor everywhere else.
"
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
let &t_SI = "\e[6 q"
let &t_EI = "\e[1 q"

