"##############################################################################
"# File        : init.vim
"# Description : Files loaded when nvim starts.
"# Remarks     :
"##############################################################################

"##############################################################################
" Plugins
"##############################################################################
"
call plug#begin()
" Auto completes
"------------------------------------------------------------------------------
Plug 'mattn/vim-lsp-settings'               " LSP auto settings
"Plug 'mattn/efm-langserver'
Plug 'prabirshrestha/async.vim'             " Async task execution
Plug 'prabirshrestha/asyncomplete.vim'      " Async auto complete
Plug 'prabirshrestha/vim-lsp'               " Use language server protocol
Plug 'prabirshrestha/asyncomplete-lsp.vim'  " Async auto complete (for lsp)
Plug 'scrooloose/nerdcommenter'             " 
"------------------------------------------------------------------------------
"
" Filers
"------------------------------------------------------------------------------
Plug 'obaland/vfiler.vim'                       " Filer
Plug 'obaland/vfiler-column-devicons'           " vfiler related plugin
Plug 'junegunn/fzf', {'do': {-> fzf#install()}} " vfiler-fzf related plugin
Plug 'junegunn/fzf.vim'                         " vfiler-fzf related plugin
Plug 'obaland/vfiler-fzf'                       " vfiler related plugin
"------------------------------------------------------------------------------

"Views
"------------------------------------------------------------------------------
Plug 'w0rp/ale'                             " Check syntax
Plug 'machakann/vim-highlightedyank'        " Highlight the yanked string
"Plug 'majutsushi/tagbar'                   " Status display of which function you are in
"Plug 'vim-airline/vim-airline'             " Extended status bar 
Plug 'nvim-lualine/lualine.nvim'            " Extended status bar
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kamykn/spelunker.vim'                 " Spell check
Plug 'posva/vim-vue'                        " 
Plug 'phpactor/phpactor'                    " PHP

" Color schemas
Plug 'mhinz/vim-startify'                   " Show start screen when starting vim
"Plug 'w0ng/vim-hybrid'                     " Schema for vim    (hybrid)
"Plug 'arcticicestudio/nord-vim'            " Schema for vim    (nord)
"Plug 'glepnir/zephyr-nvim'                 " Schema for neovim (hybrid)
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'marko-cerovac/material.nvim'          " Schema for neovim (material)
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"------------------------------------------------------------------------------

" Input plugins
"------------------------------------------------------------------------------
Plug 'ConradIrwin/vim-bracketed-paste'      " Automatically change paste mode
Plug 'mattn/emmet-vim'                      " XML tag shortcuts
"------------------------------------------------------------------------------

" Git plugins
"------------------------------------------------------------------------------
Plug 'airblade/vim-gitgutter'               " Show git diffs
Plug 'tpope/vim-fugitive'                   " Operate git from vim
"------------------------------------------------------------------------------

" Search plugins
"------------------------------------------------------------------------------
"Plug 'easymotion/vim-easymotion'           " Cursor jump
"Plug 'hrsh7th/vim-searchx'                 " Extended search
Plug 'ctrlpvim/ctrlp.vim'                   " Search for files with [Ctrl + p]
Plug 'mattn/ctrlp-lsp'                      " Jump the source code definition with [Ctrl + p]
Plug 'skanehira/jumpcursor.vim'             " Cursor jump 
"------------------------------------------------------------------------------

" External application cooperation
"------------------------------------------------------------------------------
Plug 'scrooloose/vim-slumlord'              " Edit PlantUML
Plug 'skanehira/preview-markdown.vim'       " Preview markdown
"------------------------------------------------------------------------------
call plug#end()
"##############################################################################


"##############################################################################
" Plugin settings
"##############################################################################

" treesitter settings
"------------------------------------------------------------------------------
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,                 -- false will disable the whole extension
    disable = { "vue", "ruby" },   -- list of language that will be disabled
  },
}
EOF
"------------------------------------------------------------------------------

" lualine settings
"------------------------------------------------------------------------------
lua << EOF
require('lualine').setup {
  options = {
    theme = 'material'
  }
}
EOF
"------------------------------------------------------------------------------

" material settings
"------------------------------------------------------------------------------
lua << EOF
vim.g.material_style = 'palenight'
require('material').setup({
    contrast = {
        sidebars    = true,
        cursor_line = true,
    },
    italics = {
        comments  = false,
        functions = false,
    },
    contrast_filetypes = {
        "terminal",
        "packer",
        "qf",
    },
    disable = {
        borders   = true,
        eob_lines = true
    },
    lualine_style = 'stealth'
})

vim.cmd 'colorscheme material'
EOF
"------------------------------------------------------------------------------

" jumpcursor settings
"------------------------------------------------------------------------------
nmap [j <Plug>(jumpcursor-jump)
"------------------------------------------------------------------------------

" vfiler.vim settings
"------------------------------------------------------------------------------
" Execute explorer style.
function! s:start_explorer() abort
lua <<EOF

local configs = {
  options = {
    auto_cd     = true,
    auto_resize = true,
    keep        = true,
    name        = 'explorer',
    layout      = 'floating',
    width       = 120,
    columns     = 'indent,devicons,name,mode,size',
    -- columns     = 'indent,devicons,name,git,mode,size',
    -- git = {
    --   enabled   = true,
    --   untracked = true,
    --   ignored   = true,
    -- },
  },
}

local path = vim.fn.bufname(vim.fn.bufnr())
if vim.fn.isdirectory(path) ~= 1 then
  path = vim.fn.getcwd()
end
path = vim.fn.fnamemodify(path, ':p:h')

require'nvim-web-devicons'.get_icons()
require'vfiler'.start(path, configs)

EOF
endfunction

" Execute explorer style.
noremap <silent><C-e> :call <SID>start_explorer()<CR>
"------------------------------------------------------------------------------

" "tagbar settings
" "------------------------------------------------------------------------------
" let g:tagbar_width       = 30
" let g:tagbar_autoshowtag = 1  
" set statusline=%F%m%r%h%w\%=%{tagbar#currenttag('[%s]','')}\[Pos=%v,%l]\[Len=%L]
"------------------------------------------------------------------------------

"vim-lsp settings
"------------------------------------------------------------------------------
"let lsp_log_verbose                 =1
"let lsp_log_file                    = expand('~/lsp.log')
let g:asyncomplete_remove_duplicates = 1
let g:lsp_diagnostics_enabled        = 1
let g:lsp_text_edit_enabled          = 1
let g:asyncomplete_auto_completeopt  = 1
let g:asyncomplete_smart_completion  = 1
let g:asyncomplete_auto_popup        = 1
let g:lsp_diagnostics_echo_cursor    = 1
let g:asyncomplete_popup_delay       = 0

nmap <silent> <C-]> :LspDefinition<CR> " Jump definition
nmap <silent> gd    :LspDefinition<CR> " Jump definition
nmap <silent> gD    :LspReferences<CR> " View caller
"------------------------------------------------------------------------------

"phpactor settings
"------------------------------------------------------------------------------
nmap <silent> ww :call phpactor#Hover()<CR>
""------------------------------------------------------------------------------

"------------------------------------------------------------------------------

"##############################################################################

"##############################################################################
" Common settings
"##############################################################################

" Search settings
"------------------------------------------------------------------------------
set ignorecase     " Case insensitive
set wrapscan       " Wrap around when the search is finished
set incsearch      " Incremental search
set hlsearch       " Highlight search results
nnoremap <ESC> :nohlsearch<CR>
                   " Remove highlighting with [ESC] key
"------------------------------------------------------------------------------

" View settings
"------------------------------------------------------------------------------
set number                     " Show line number
set showcmd                    " Show the command your are typing
set list                       " Show control characters
set listchars=tab:??-,trail:-,eol:???,extends:??,precedes:??,nbsp:%
set cursorline                 " Highlight selected line
set expandtab                  " Replace tab with a half-width space
set noswapfile                 " Don't create swap file
"set nofoldenable              " Don't fold the source code
set autochdir                  " Change to the directory of open files
set softtabstop=4              " Number of spaces for tab
set shiftwidth=4               " Number of spaces for smart indent, command
set cmdheight=2                " Number of lines the message display field
set laststatus=2               " Always show status line
set display=lastline           " Don't omit the characters displayed on the status line
set showmatch matchtime=1      " Bracket highlighting
set termguicolors

"set tags=~/tags

"------------------------------------------------------------------------------
"
" Syntax settings by extension
"------------------------------------------------------------------------------
"autocmd BufNewFile,BufRead *.tpl set filetype=bash 
"------------------------------------------------------------------------------

" Other settings
"------------------------------------------------------------------------------
set noerrorbells               " Beep suppression at the time of error
set history=10000              " Number of saved vim command execution histories
"
"##############################################################################
