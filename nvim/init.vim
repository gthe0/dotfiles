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
	Plug 'projekt0n/github-nvim-theme'

" Telescope Plugin
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim' 

" Tree-Sitter
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" LSP
	Plug 'williamboman/mason.nvim'
	Plug 'williamboman/mason-lspconfig.nvim'
	Plug 'neovim/nvim-lspconfig'

" Auto-Completion
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'

" Snippets
    Plug 'rafamadriz/friendly-snippets'
	Plug 'L3MON4D3/LuaSnip'
	Plug 'saadparwaiz1/cmp_luasnip'
	
" Diagnostics
	Plug 'nvim-tree/nvim-web-devicons'
	Plug 'folke/trouble.nvim'

" File Explorer
	Plug 'stevearc/oil.nvim'

call plug#end()


""" Loading Plugin's settings
lua require('plugins')
