    " -----------------------------------------------------------------------------
" PERFORMANCE OPTIMIZATIONS - Load these first to prevent delays
" -----------------------------------------------------------------------------
set belloff=all          " Disable all bells - fixes 2s warning delay
set novisualbell        " No visual bell
set t_vb=              " No terminal bell
set noerrorbells       " No error bells
set vb t_vb=          " Disable all bells completely

" Terminal colors configuration
if has('termguicolors')
    set termguicolors
else
    set t_Co=256
endif

" -----------------------------------------------------------------------------
" Plugin Management with vim-plug
" -----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" File Navigation & Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Lightweight status line (10x faster than airline)
Plug 'itchyny/lightline.vim'

" Development Tools
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'

" Code Completion & Snippets
Plug 'hrsh7th/vim-vsnip'
Plug 'lifepillar/vim-mucomplete'

" Language Support
Plug 'mattn/emmet-vim'
Plug 'ekalinin/dockerfile.vim'
Plug 'leafgarland/typescript-vim'

" TSIN - Tag-based Synthetic Information Nodes
Plug 'joaopelegrino/tsin'

call plug#end()

" -----------------------------------------------------------------------------
" PLUGIN CONFIGURATIONS
" -----------------------------------------------------------------------------

" TSIN - Sistema de Expansão de Parágrafos Sintéticos
" Habilitar auto-validação ao salvar (mostra aviso se tags sem expansões)
let g:tsin_auto_validate = 1

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

" Lightline Configuration (Fast and minimal)
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead'
    \ },
    \ }

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

" Fugitive (Git) shortcuts
nnoremap <leader>gs :Git status<CR>
nnoremap <leader>ga :Git add .<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gl :Git log --oneline<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>

" Vsnip Configuration
let g:vsnip_snippet_dir = expand('/home/notebook/config/vim/vsnip')

" -----------------------------------------------------------------------------
" MUCOMPLETE CONFIGURATION (Simplified - no conflicts)
" -----------------------------------------------------------------------------
" Enable MuComplete at startup (DISABLED - use Ctrl+Space for manual completion)
let g:mucomplete#enable_auto_at_startup = 0

" Minimum characters before triggering completion (increased to reduce false triggers)
let g:mucomplete#minimum_prefix_length = 3

" Delay before triggering auto-completion (milliseconds) - increased for smoother typing
let g:mucomplete#completion_delay = 300

" Completion chains per filetype - defines order and methods
" Note: 'uspl' (spell) removed to prevent unwanted capitalization suggestions
let g:mucomplete#chains = {
    \ 'default': ['omni', 'c-n', 'dict'],
    \ 'vim': ['cmd', 'c-n'],
    \ 'html': ['omni', 'c-n'],
    \ 'css': ['omni', 'c-n'],
    \ 'javascript': ['omni', 'c-n', 'dict'],
    \ 'typescript': ['omni', 'c-n', 'dict'],
    \ 'python': ['omni', 'c-n', 'dict'],
    \ 'c': ['omni', 'c-n'],
    \ 'cpp': ['omni', 'c-n'],
    \ 'markdown': ['c-n', 'dict'],
    \ 'text': ['c-n', 'dict'],
    \ 'dockerfile': ['c-n', 'dict']
    \ }

" MuComplete spell check integration
let g:mucomplete#spel#good_words = 1

" Disable MuComplete's default mappings to avoid conflicts
let g:mucomplete#no_mappings = 1

" vsnip key mappings - must come before MuComplete
imap <expr> <C-j> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'
smap <expr> <C-j> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'

" vsnip navigation in snippets (using different keys to avoid conflicts)
imap <expr> <C-l> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-l>'
smap <expr> <C-l> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-l>'
imap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
smap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'

" Simplified Tab handling for MuComplete (after vsnip)
imap <expr> <Tab> vsnip#expandable() ? '<Plug>(vsnip-expand)' : (pumvisible() ? '<C-n>' : '<Plug>(MUcompleteFwd)')
imap <expr> <S-Tab> pumvisible() ? '<C-p>' : '<Plug>(MUcompleteBwd)'

" MuComplete control mappings
" Space key: close popup without inserting suggestion
inoremap <expr> <space> pumvisible() ? '<C-e><space>' : '<space>'
" Ctrl+Space: manually trigger completion when auto-completion is disabled
inoremap <silent> <C-Space> <C-r>=mucomplete#tab_complete(1)<CR>
" Toggle auto-completion on/off
nnoremap <leader>mc :MUcompleteToggle<CR>:echo "MuComplete toggled!"<CR>

" -----------------------------------------------------------------------------
" CORE VIM SETTINGS
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

" Folding configuration - open all folds by default
set foldlevelstart=99           " Start with all folds open
set foldlevel=99               " Keep all folds open by default
set foldenable                 " Enable folding

" File handling and path configuration
set path=.,**,;                         " Search current, subdirs, and parent dirs recursively
set suffixesadd+=.py,.js,.jsx,.ts,.tsx,.vue,.html,.css,.scss,.md,.vim
set includeexpr=substitute(v:fname,'\\.','/','g')
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" Tab behavior - open files in new tabs by default
set switchbuf=newtab              " Open files in new tabs for quickfix, help, etc.
set showtabline=2                 " Always show tab line
set tabpagemax=50                 " Maximum number of tabs

" Display settings
set nowrap
set linebreak
set nolist
set listchars=tab:›-,space:·,trail:◀,eol:↲

" Line numbers
set number 
set relativenumber
set scrolloff=2
set cursorline

" Cursor shape
let &t_SI="\e[6 q"
let &t_EI="\e[2 q"

" Indentation
set autoindent
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Search
set ignorecase
set smartcase
set incsearch
set hls
let @/ = ""

" Completion - Always show popup menu
set completeopt=menuone,longest,noselect
set shortmess+=c

" Spell check - Portuguese BR priority with English fallback
set spelllang=pt_br,en
set nospell

" Insert completion navigation
inoremap <expr> <up> pumvisible() ? '<c-p>' : '<up>'
inoremap <expr> <down> pumvisible() ? '<c-n>' : '<down>'
" Safe Right arrow - closes popup and moves cursor (no auto-accept)
inoremap <expr> <right> pumvisible() ? '<c-e><right>' : '<right>'
" Safe Enter - closes popup without accepting, requires explicit Ctrl+Y to accept
inoremap <expr> <cr> pumvisible() ? '<c-e><cr>' : '<cr>'
inoremap <expr> <left> pumvisible() ? '<c-e>' : '<left>'

" -----------------------------------------------------------------------------
" COMPLETION MAPPINGS
" -----------------------------------------------------------------------------
" Native Vim completion commands (no custom mappings needed):
" <C-x><C-f> - File path completion
" <C-x><C-l> - Line completion
" <C-x><C-s> - Spell completion
" <C-x><C-o> - Omni completion
" <C-x><C-v> - Vim command completion
" <C-x><C-k> - Dictionary completion
" <C-x><C-t> - Thesaurus completion
" <C-x><C-i> - Include file completion
" <C-x><C-]> - Tag completion

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

" Toggle spell check (changed from <leader>s to avoid conflict with synthetic-para plugin)
nnoremap <leader>sp :set spell!<CR>

" Toggle spell check specifically for markdown files (quick access)
nnoremap <leader>sm :set spell!<CR>

" -----------------------------------------------------------------------------
" OPTIMIZED CLIPBOARD FOR WSL2
" -----------------------------------------------------------------------------
if has('wsl')
    " Use win32yank for better performance
    let g:clipboard = {
        \ 'name': 'WslClipboard',
        \ 'copy': {
        \    '+': 'win32yank.exe -i --crlf',
        \    '*': 'win32yank.exe -i --crlf',
        \  },
        \ 'paste': {
        \    '+': 'win32yank.exe -o --lf',
        \    '*': 'win32yank.exe -o --lf',
        \ },
        \ 'cache_enabled': 0,
        \ }
endif

" Copy to Windows clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y

" Paste from Windows clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p

" Copy whole file to Windows clipboard
nnoremap <leader>ya :%+y<CR>:echo "Arquivo copiado para Windows clipboard!"<CR>

" Copy current line to Windows clipboard with feedback
nnoremap <leader>yy "+yy:echo "Line copied to Windows clipboard"<CR>

" Fast copy word under cursor
nnoremap <leader>yw viw"+y:echo "Word copied to Windows clipboard"<CR>

" Visual mode - copy selection and show feedback
vnoremap <leader>c "+y:echo "Selection copied to Windows clipboard"<CR>

" Paste and format (useful for code)
nnoremap <leader>pf "+p=`]

" Quick clipboard status check
nnoremap <leader>cb :echo "Clipboard: " . @+<CR>

" Reload vimrc
nnoremap <leader>rv :source ~/.vimrc<CR>:echo "vimrc reloaded!"<CR>

" Edit vimrc in new tab
command! Vimrc tabnew ~/.vimrc
nnoremap <leader>ev :Vimrc<CR>

" LLM template commands
command! LLMMain tabnew | 0r /home/notebook/workspace/blog/.claude/commands/LLM-main.md
command! -nargs=1 LLMNew tabnew <args> | 0r /home/notebook/workspace/blog/.claude/commands/LLM-main.md

" File opening commands - always use tabs
command! -nargs=1 -complete=file E tabedit <args>
command! -nargs=1 -complete=file Edit tabedit <args>
cabbrev e tabedit
cabbrev edit tabedit

" Path abbreviations for frequent directories (with namespace)
iabbrev bdocs /home/notebook/workspace/blog/docs
iabbrev bclaude /home/notebook/workspace/blog/.claude

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

" Window and Split Management (Creation, Resizing, Movement)
" Create vertical/horizontal splits
nnoremap <leader>vs :vsplit<CR>
nnoremap <leader>sp :split<CR>

" Resize splits using leader + arrow keys
nnoremap <leader><up> :res +2<CR>
nnoremap <leader><down> :res -2<CR>
nnoremap <leader><left> :vertical resize-2<CR>
nnoremap <leader><right> :vertical resize+2<CR>

" Equalize split sizes
nnoremap <leader>= <C-w>=

" Close all other splits
nnoremap <leader>o :only<CR>

" Move splits
nnoremap <leader>K <C-w>K
nnoremap <leader>J <C-w>J
nnoremap <leader>H <C-w>H
nnoremap <leader>L <C-w>L

" Tab navigation
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>tm :tabmove<Space>
nnoremap <leader>t<leader> :tabnext<CR>

" Terminal navigation and management
nnoremap <leader>t :only<CR>:terminal ++curwin<CR>

" Terminal mode mappings
tnoremap <Esc><Esc> <C-\><C-n>
tnoremap <leader>q <C-\><C-n>:q<CR>

" Terminal navigation using leader (avoids conflicts with split navigation)
tnoremap <leader>h <C-\><C-n><C-w>h
tnoremap <leader>j <C-\><C-n><C-w>j
tnoremap <leader>k <C-\><C-n><C-w>k
tnoremap <leader>l <C-\><C-n><C-w>l

" Buffer navigation
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bd :bdelete<CR>

" Quickfix navigation and optimization
nnoremap <leader>qo :copen<CR>
nnoremap <leader>qc :cclose<CR>
nnoremap <leader>qn :cnext<CR>
nnoremap <leader>qp :cprev<CR>
nnoremap <leader>qf :cfirst<CR>
nnoremap <leader>ql :clast<CR>

" C-specific build and lint shortcuts
nnoremap <leader>cb :make<CR>
nnoremap <leader>cr :!./%<<CR>
nnoremap <leader>cl :make! %<CR>:copen<CR>

" -----------------------------------------------------------------------------
" WILDMENU CONFIGURATION
" -----------------------------------------------------------------------------
set wildmenu
set wildmode=longest,full
set wildoptions=pum
set wildcharm=<C-Z>                     " Programmatic wildmenu trigger
set wildignorecase                      " Case insensitive filename completion

" Wildmenu ignoring
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
" COLOR SCHEME
" -----------------------------------------------------------------------------
colorscheme habamax

" Status line
set noshowmode
set laststatus=2

" Transparency and visual tweaks
hi Normal guibg=NONE ctermbg=NONE
hi CursorLine guibg=#202130
hi Comment cterm=italic gui=italic
hi VertSplit ctermbg=NONE guibg=NONE ctermfg=7 guifg=#c1c2d0
hi TabLine guifg=#9192a0 guibg=#303140 gui=none
hi TabLineSel guifg=#a1a2b0 guibg=#101120 gui=bold
hi TabLineFill guifg=#9192a0 guibg=#303140 gui=none
hi Visual guifg=NONE guibg=#303140

" -----------------------------------------------------------------------------
" FILE TYPE SPECIFIC CONFIGURATIONS
" -----------------------------------------------------------------------------

" Create directories for snippets if they don't exist
if !isdirectory(expand('~/.vim/vsnip'))
    call mkdir(expand('~/.vim/vsnip'), 'p')
endif

" C/C++ Settings - Optimized Configuration
autocmd FileType c,cpp setlocal cindent
autocmd FileType c,cpp setlocal commentstring=//%s
autocmd FileType c,cpp setlocal foldmethod=syntax
autocmd FileType c,cpp setlocal tabstop=4 shiftwidth=4 softtabstop=4

" C/C++ Enhanced Completion Setup
autocmd FileType c,cpp setlocal omnifunc=ccomplete#Complete
autocmd FileType c,cpp setlocal completefunc=ccomplete#Complete
autocmd FileType c,cpp setlocal path+=.,/usr/include,/usr/local/include

" C/C++ Enhanced Syntax and Include Path
autocmd FileType c,cpp setlocal include=^\\s*#\\s*include
autocmd FileType c,cpp setlocal define=^\\s*#\\s*define
autocmd FileType c,cpp setlocal suffixesadd+=.h,.c,.cpp,.hpp,.cxx

" C/C++ Compiler and Lint Configuration
autocmd FileType c,cpp compiler gcc
autocmd FileType c,cpp setlocal makeprg=gcc\ -Wall\ -Wextra\ -std=c99\ -fsyntax-only\ %
autocmd FileType c,cpp setlocal errorformat=%f:%l:%c:\ %t%*[^:]:\ %m

" C/C++ Advanced Features
autocmd FileType c,cpp setlocal textwidth=80
autocmd FileType c,cpp setlocal colorcolumn=81

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
autocmd FileType markdown setlocal nospell
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
set shellcmdflag=-ic
set shell=zsh

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

" Faster scrolling
set scrolljump=5

" Better completion - Sources: current buffer, other windows, other loaded buffers, 
" unloaded buffers, tags, included files
set complete=.,w,b,u,t,i

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

" Mouse disabled to prevent interference with terminal applications
set mouse=

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

" Only load plugins when needed - keep only essentials
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

" Disable built-in matchit
let g:loaded_matchit = 1
