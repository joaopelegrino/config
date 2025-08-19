" -----------------------------------------------------------------------------
if has('termguicolors')
    set termguicolors
else
    set t_Co=256
endif
" -----------------------------------------------------------------------------
" Plugin Management with vim-plug
call plug#begin('~/.vim/plugged')

" File Navigation & Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Interface & Visual
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

" Development Tools
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'

" Code Completion & Snippets
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'

" Language Support
Plug 'mattn/emmet-vim'
Plug 'ekalinin/dockerfile.vim'
Plug 'leafgarland/typescript-vim'

call plug#end()

" -----------------------------------------------------------------------------
" PLUGIN CONFIGURATIONS
" -----------------------------------------------------------------------------

" FZF Configuration
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-f> :Rg<Space>
nnoremap <leader>h :History<CR>
nnoremap <leader>: :History:<CR>
nnoremap <leader>/ :History/<CR>

" FZF Layout and colors
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment']
  \ }

" Airline Configuration (will replace manual statusline)
let g:airline_theme = 'base16'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 1

" DevIcons Configuration
let g:webdevicons_enable = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1

" LSP Configuration
let g:lsp_diagnostics_enabled = 1
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_highlights_enabled = 1
let g:lsp_textprop_enabled = 1

" LSP Key mappings
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" LSP Auto-install language servers
let g:lsp_settings = {
\   'clangd': {'cmd': ['clangd']},
\   'pylsp': {'cmd': ['pylsp']},
\   'typescript-language-server': {'cmd': ['typescript-language-server', '--stdio']},
\}

" Emmet Configuration
let g:user_emmet_leader_key='<C-e>'
let g:user_emmet_install_global = 0
autocmd FileType html,css,javascript,jsx,vue EmmetInstall

" NERDCommenter Configuration
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" Vim-surround additional mappings
" No additional config needed, works out of the box

" Fugitive (Git) shortcuts
nnoremap <leader>gs :Git status<CR>
nnoremap <leader>ga :Git add .<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gl :Git log --oneline<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>

" Vsnip Configuration
let g:vsnip_snippet_dir = expand('~/.vim/vsnip')
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" -----------------------------------------------------------------------------
filetype plugin indent on
syntax on
set title
set encoding=utf-8
set backspace=indent,eol,start
set noerrorbells
set confirm
set hidden
set splitbelow
set splitright
set fillchars=vert:│,fold:-,eob:~,lastline:@
" -----------------------------------------------------------------------------
set path=.,**
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
" -----------------------------------------------------------------------------
set nowrap
set linebreak
set nolist
set listchars=tab:›-,space:·,trail:◀,eol:↲
" -----------------------------------------------------------------------------
set number 
set relativenumber
set scrolloff=2
set cursorline
" -----------------------------------------------------------------------------
let &t_SI="\e[6 q"
let &t_EI="\e[2 q"
" -----------------------------------------------------------------------------
set autoindent
set smartindent
" -----------------------------------------------------------------------------
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
" -----------------------------------------------------------------------------
set ignorecase
set smartcase
set incsearch
set hls
let @/ = ""
" -----------------------------------------------------------------------------
set complete+=kspell
set completeopt=menuone,longest
set shortmess+=c

set spelllang=pt_br,en
set nospell

" Insert completion...

" -- Select with arrows up and down --
inoremap <expr> <up> pumvisible() ? '<c-p>' : '<up>'
inoremap <expr> <down> pumvisible() ? '<c-n>' : '<down>'

" -- Accept with right arrow or enter --
inoremap <expr> <right> pumvisible() ? '<c-y>' : '<right>'
inoremap <expr> <cr> pumvisible() ? '<c-y>' : '<cr>'

" -- Cancel completion with left arrow --
inoremap <expr> <left> pumvisible() ? '<c-e>' : '<left>'

function! Hashbangs()
    let hb = ['#!/bin/bash', '#!/usr/bin/env bash', '#!/bin/sh', '#!/usr/bin/awk -f']
    call complete(col('.'), hb)
    return ''
endfunction

imap <c-x>h <c-r>=Hashbangs()<cr>
" -----------------------------------------------------------------------------
" LEADER KEY AND GENERAL MAPPINGS
" -----------------------------------------------------------------------------
" Set leader key
let mapleader = ","
let maplocalleader = "\\"

" Quick save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :wq<CR>

" Clear search highlighting
nnoremap <leader><space> :noh<CR>

" Toggle spell check
nnoremap <leader>s :set spell!<CR>

" Toggle line numbers
nnoremap <leader>n :set number!<CR>
nnoremap <leader>rn :set relativenumber!<CR>

" Toggle list characters
nnoremap <leader>l :set list!<CR>

" Toggle wrap
nnoremap <leader>wr :set wrap!<CR>

" Split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Tab navigation
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>tm :tabmove<Space>
nnoremap <leader>t<leader> :tabnext<CR>

" Buffer navigation
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bd :bdelete<CR>

" -----------------------------------------------------------------------------
set wildmenu
set wildmode=longest,full
set wildoptions=pum

" Improve wildmenu ignoring
set wildignore+=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/Library/**,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.doc,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android
" -----------------------------------------------------------------------------
" https://github.com/sainnhe/edge.git 
" set background=dark
" colorscheme edge
" -----------------------------------------------------------------------------
colorscheme habamax
" -----------------------------------------------------------------------------
set noshowmode
set laststatus=2

hi statusline   cterm=NONE ctermfg=0 ctermbg=7   guibg=#C1C2D0 guifg=#000000
hi statuslinenc cterm=NONE ctermfg=0 ctermbg=240 guibg=#616270 guifg=#000000

" Initialize mode dictionary before use
let g:currentmode={
    \ 'n'      : 'Normal',
    \ 'no'     : 'Normal-Operator Pending',
    \ 'v'      : 'Visual',
    \ 'V'      : 'V-Line',
    \ '\<C-V>' : 'V-Block',
    \ 's'      : 'Select',
    \ 'S'      : 'S-Line',
    \ '\<C-S>' : 'S-Block',
    \ 'i'      : 'Insert',
    \ 'R'      : 'Replace',
    \ 'Rv'     : 'V-Replace',
    \ 'c'      : 'Command',
    \ 'cv'     : 'Vim Ex',
    \ 'ce'     : 'Ex',
    \ 'r'      : 'Prompt',
    \ 'rm'     : 'More',
    \ 'r?'     : 'Confirm',
    \ '!'      : 'Shell',
    \ 't'      : 'Terminal'
    \}

augroup ModeEvents
    autocmd!
    au InsertEnter * hi statusline cterm=NONE ctermfg=0 ctermbg=10 guibg=#7BC86F
    au InsertLeave * hi statusline cterm=NONE ctermfg=0 ctermbg=7 guibg=#C1C2D0
    au ModeChanged *:[vV\x16]* hi statusline cterm=NONE ctermfg=0 ctermbg=13 guibg=#C990DC
    au Modechanged [vV\x16]*:* hi statusline cterm=NONE ctermfg=0 ctermbg=7 guibg=#C1C2D0
augroup end

function! LoadStatusLine()
    let g:left_sep='│'
    let g:right_sep='│'

    " Add error handling for mode lookup
    function! GetMode()
        let l:mode = mode()
        return get(g:currentmode, l:mode, l:mode)
    endfunction

    set statusline=\ %{toupper(GetMode())}
    set statusline+=\ %{g:left_sep}
    set statusline+=\ %n
    set statusline+=\ %{g:left_sep}
    set statusline+=\ %f%m\ %y
    set statusline+=\ %{g:left_sep}
    set statusline+=\ %{&ff}\ %{&fenc!=''?&fenc:&enc}
    set statusline+=\ %{g:left_sep}
    set statusline+=\ %=
    set statusline+=\ %{g:right_sep}
    set statusline+=\ %l/%L,%v
    set statusline+=\ %{g:right_sep}
    set statusline+=\ %P\ 
endfunction

call LoadStatusLine()

" -----------------------------------------------------------------------------
hi Normal guibg=NONE ctermbg=NONE

hi CursorLine guibg=#202130

hi Comment cterm=italic gui=italic

hi VertSplit ctermbg=NONE guibg=NONE ctermfg=7 guifg=#c1c2d0

hi TabLine      guifg=#9192a0 guibg=#303140 gui=none
hi TabLineSel   guifg=#a1a2b0 guibg=#101120 gui=bold
hi TabLineFill  guifg=#9192a0 guibg=#303140 gui=none

hi Visual guifg=NONE guibg=#303140

" -----------------------------------------------------------------------------
" FILE TYPE SPECIFIC CONFIGURATIONS
" -----------------------------------------------------------------------------

" Create directories for snippets if they don't exist
if !isdirectory(expand('~/.vim/vsnip'))
    call mkdir(expand('~/.vim/vsnip'), 'p')
endif

" C/C++ Settings
autocmd FileType c,cpp setlocal cindent
autocmd FileType c,cpp setlocal commentstring=//%s
autocmd FileType c,cpp setlocal foldmethod=syntax
autocmd FileType c,cpp setlocal tabstop=4 shiftwidth=4 softtabstop=4

" Python Settings
autocmd FileType python setlocal expandtab
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType python setlocal foldmethod=indent
autocmd FileType python setlocal textwidth=79
autocmd FileType python setlocal colorcolumn=80

" Web Development (HTML, CSS, JavaScript)
autocmd FileType html,css,javascript,jsx,vue setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType html,css,javascript,jsx,vue setlocal expandtab
autocmd FileType html,css setlocal foldmethod=indent
autocmd FileType javascript,jsx setlocal foldmethod=syntax

" Markdown Settings
autocmd FileType markdown setlocal wrap
autocmd FileType markdown setlocal linebreak
autocmd FileType markdown setlocal spell
autocmd FileType markdown setlocal textwidth=80
autocmd FileType markdown setlocal conceallevel=2

" YAML Settings
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType yaml setlocal expandtab
autocmd FileType yaml setlocal foldmethod=indent

" Shell Script Settings
autocmd FileType sh,bash,zsh setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType sh,bash,zsh setlocal expandtab
autocmd FileType sh,bash,zsh setlocal foldmethod=syntax

" Docker Settings
autocmd FileType dockerfile setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType dockerfile setlocal expandtab

" JSON Settings
autocmd FileType json setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType json setlocal expandtab
autocmd FileType json setlocal foldmethod=syntax
autocmd FileType json setlocal conceallevel=0

" TypeScript Settings
autocmd FileType typescript setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType typescript setlocal expandtab
autocmd FileType typescript setlocal foldmethod=syntax

" -----------------------------------------------------------------------------
" PERFORMANCE OPTIMIZATIONS
" -----------------------------------------------------------------------------

" Faster redrawing
set ttyfast
set lazyredraw

" Don't update display while executing macros
set lazyredraw

" Faster scrolling
set scrolljump=5

" Better completion
set complete=.,w,b,u,t,i,kspell

" Timeout for key sequences
set timeoutlen=500
set ttimeoutlen=10

" Update time for CursorHold events (used by some plugins)
set updatetime=100

" Don't give completion messages
set shortmess+=c

" -----------------------------------------------------------------------------
" SECURITY
" -----------------------------------------------------------------------------

" Disable modelines for security
set modelines=0
set nomodeline

" Secure options
set secure

" -----------------------------------------------------------------------------
" BETTER DEFAULTS
" -----------------------------------------------------------------------------

" Show matching brackets
set showmatch
set matchtime=2

" Mouse support in all modes
set mouse=a

" Enable clipboard integration
if has('clipboard')
    if has('unnamedplus')
        set clipboard=unnamedplus
    else
        set clipboard=unnamed
    endif
endif

" Better formatting
set formatoptions+=j " Delete comment character when joining commented lines
set formatoptions+=n " Recognize numbered lists
set formatoptions+=1 " Break before 1-letter words

" History
set history=1000
set viminfo='100,<50,s10,h

" -----------------------------------------------------------------------------
" STARTUP OPTIMIZATIONS
" -----------------------------------------------------------------------------

" Only load plugins when needed
let g:loaded_gzip = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:loaded_rrhelper = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

" Disable built-in matchit (we might use better alternatives)
let g:loaded_matchit = 1
