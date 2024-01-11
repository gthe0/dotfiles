""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This is the entry point of my nvim configuration
"	If unfamilliar with any of the settings, please read the comments below.
"	For further information, please refer to the documentation by typing
"			:h <option> 
"
"	or by visiting Neovim's official website:	https://neovim.io/	
"		
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Loading default config
lua require('config')

""" Plugins to be installed
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'

call plug#begin()
" Theme
	Plug 'ayu-theme/ayu-vim'

" Telescope Plugin
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim' 

" LSP
	Plug 'williamboman/mason.nvim'
	Plug 'williamboman/mason-lspconfig.nvim'
	Plug 'neovim/nvim-lspconfig'

call plug#end()


""" Loading Plugin's settings
lua require('plugins')
