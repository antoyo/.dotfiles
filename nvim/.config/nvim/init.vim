" Plugins.
call plug#begin()

Plug 'antoyo/vim-bepo'
Plug 'antoyo/vim-licenses'
Plug 'antoyo/vim-sessions'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'benekastah/neomake'
Plug 'cespare/vim-toml'
Plug 'dahu/vimple'
Plug 'dahu/Asif'
Plug 'dahu/vim-asciidoc'
Plug 'jamessan/vim-gnupg'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-racer'
Plug 'neomutt/neomutt.vim'
Plug 'roxma/nvim-yarp'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/a.vim'

call plug#end()

" Basic configuration.
set confirm
set hidden " Avoid unloading a buffer when editing another file.
set sessionoptions=buffers,curdir " Only save the buffers and the current directory in the session.
set spelllang=fr
set tags=./.tags
set matchpairs+=<:> " Enable % to jump from < to >.
set notimeout " Disable the timeout.
set nottimeout
set timeoutlen=0
set ttimeoutlen=0

" Disable the timeout in every mode except insert.
augroup NoTimeout
    autocmd!
    autocmd InsertEnter * set timeout | set ttimeout
    autocmd InsertLeave * set notimeout | set nottimeout
augroup END

let mapleader = "\<Space>"

" UI configuration.
set background=dark
set cursorline " Highlight the active line.
set diffopt+=vertical " Make diff split vertical by default.
set inccommand=split " Incremental visual feedback for the substitute command.
set list listchars=tab:▸\ ,nbsp:¬,trail:· " Display a character on tabs, nbsp and trailing whitespace.
set mouse= " Disable the mouse.
set nofoldenable " Open all folds.
set noshowmode " Hide the mode since the airline already shows it.
set number
set relativenumber
set scrolloff=3 " Set to 3 the number of lines to keep above and below the cursor.
set shortmess+=cI " Hide completion (c) and intro (I) message.
set showcmd
set title

" Completion configuration.
set completeopt -=preview " Disable the preview window for the completions.
set suffixes +=,, " Ignore files without extension (probably binary files) in file name completion.
set wildmenu " Show completions in commands.
set wildmode =longest,list,full
"set wildignore+=Cargo.lock " Ignore these files in file completion.

" Search configuration.
set gdefault " Enable global substitute (all matches in a line are substituted).
set hlsearch " Highlight search matches.
set incsearch " Enable incremental search.

" Indentation configuration.
set expandtab " Convert inserted tabs to spaces.
set formatoptions=ro " Insert comment leader when hitting Enter or o/O.
set shiftwidth=4 " Auto-indent this number of space.
set tabstop=4 " Tabs will be shown on 4 characters.

" Abbreviation.
iabbrev èèè ```<CR><CR>```

" Syntax configuration.
syntax on
" Color the special keys (tabs, trailing spaces, nbsp) in red.
highlight Whitespace ctermbg=red
" Disable this special keys highlighting in normal mode.
autocmd InsertEnter * highlight clear Whitespace
autocmd InsertLeave * highlight Whitespace ctermbg=red
" Highlight the current line instead of underlining it.
highlight CursorLine cterm=NONE ctermbg=234

" Show the columns from 121 in another color.
let &colorcolumn=join(range(121,999), ",")
highlight ColorColumn ctermbg=237

" File type configuration.
filetype plugin indent on

" Autocommands.
augroup filegroup
    autocmd FileType c,cpp setlocal cindent
    autocmd FileType python setlocal autoindent
    autocmd FileType asciidoc set nospell
    autocmd VimLeave * CurrentSessionSave
    autocmd FileType asciidoc setlocal shiftwidth=4
    autocmd BufRead *.tig set filetype=javascript
augroup END

" Disable backup for gopass files.
autocmd BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile

" Disable F1, ex mode and Ctrl-Z shortcuts.
map <F1> <nop>
imap <F1> <nop>
nnoremap Q <nop>
nnoremap <Space><Space> <nop>
nnoremap <C-Z> <nop>
nnoremap q: <nop>

" Disable Ctrl-C.
cmap <C-c> <nop>
imap <C-c> <nop>
vmap <C-c> <nop>

" Disable Tab.
inoremap <Tab> <nop>
vnoremap <Tab> <nop>

" Disable nbsp
inoremap   <nop>

" Shorcuts.
" Go to alternate buffer.
map ga <C-^>
" Navigate link.
map gt <C-]>
" Select the last inserted text.
nnoremap gV `[v`]
" Copy the whole buffer to the system clipboard.
map <C-S> magg"+yG'azz
map <C-T> :call system("xclip -sel clip", system("include_replace src/main.rs"))<CR>
noremap ; $

" Commands.
" TODO: refactor these commands into a single one.
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=* Rgw
  \ call fzf#vim#grep(
  \   'rg --word-regexp --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" TODO: add shorcuts to switch or delete buffers.
nnoremap <silent> <Leader>/ :nohlsearch<CR>
" Open new lines without going to insert mode.
nnoremap <Leader>A O<Esc>
nnoremap <expr> <Leader>a &modifiable?"o<Esc>":"<CR>"
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>e :set spelllang=en<CR>:set spell<CR>
nnoremap <Leader>g :Rg 
nnoremap <Leader>h :hide<CR>
nnoremap <Leader>l "*p
nnoremap <Leader>L "*P
nnoremap <Leader>n :only<CR>
nnoremap <Leader>o :Files<CR>
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
nnoremap <Leader>* :Rgw <C-R><C-W><CR>
nnoremap <Leader>q :update<CR>:q<CR>
nnoremap <Leader>s /\<\><Left><Left>
nnoremap <Leader>u :GundoToggle<CR>
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
nnoremap <Leader>w :w<CR>

command! GpushNew :Gpush origin -u HEAD

" Plugin configuration.
" Licenses
let g:licenses_copyright_holders_name = "Boucher, Antoni <bouanto@zoho.com>"

" Neomake
let g:neomake_logfile = '/tmp/neomake.log'
let g:neomake_open_list = 2
let g:neomake_asciidoc_enabled_makers = []
"call neomake#configure#automake('w')

" Airline
set laststatus=2
let g:airline_theme="powerlineish"
"let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" LanguageClient
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }
let g:LanguageClient_useVirtualText = 0

" GUndo
let g:gundo_map_move_older = "t"
let g:gundo_map_move_newer = "s"

" Vimple fix.
let vimple_init_vn = 0

" Ncm
autocmd BufEnter * call ncm2#enable_for_buffer() " Enable ncm2 for all buffers.
set completeopt=noinsert,menuone,noselect
" Enter newline instead of just closing the completion popup on enter.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :highlight IndentGuidesOdd ctermbg=8
autocmd VimEnter,Colorscheme * :highlight IndentGuidesEven ctermbg=8
