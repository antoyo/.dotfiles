" Plugins.
call plug#begin()

" Interesting plugins:
" https://github.com/j-hui/fidget.nvim
" https://github.com/weilbith/nvim-code-action-menu
"
" https://github.com/vxpm/ferris.nvim
" https://github.com/luckasRanarison/clear-action.nvim
" https://github.com/Zeioth/garbage-day.nvim
"
" TODO: remove ~/.config/nvim/lsp.json

Plug 'antoyo/vim-bepo'
Plug 'antoyo/vim-licenses'
Plug 'antoyo/vim-sessions'
Plug 'cespare/vim-toml'
Plug 'dahu/vimple'
Plug 'dahu/Asif'
Plug 'dahu/vim-asciidoc'
" To show errors from the build done by the LSP.
Plug 'folke/trouble.nvim'
" To have FZF for LSP features.
Plug 'gfanto/fzf-lsp.nvim'
Plug 'j-hui/fidget.nvim'
Plug 'jamessan/vim-gnupg'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'mrcjkb/rustaceanvim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
" To see the function signature when typing a function call.
Plug 'ray-x/lsp_signature.nvim'
Plug 'roxma/nvim-yarp'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'sjl/gundo.vim'
Plug 'smjonas/inc-rename.nvim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/a.vim'
Plug 'Vimjas/vim-python-pep8-indent'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'

call plug#end()

" Basic configuration.
set confirm
set hidden " Avoid unloading a buffer when editing another file.
set sessionoptions=buffers,curdir " Only save the buffers and the current directory in the session.
set spelllang=fr
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
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
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
set tabstop=8 " Tabs will be shown on 4 characters.

if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

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
    autocmd FileType asciidoc setlocal shiftwidth=4 | setlocal textwidth=0
    autocmd BufRead *.tig set filetype=javascript
    autocmd BufRead *.nx set filetype=rust
    autocmd BufRead *.patch set nospell
augroup END

" Disable backup for gopass files.
autocmd BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile

" Check if a file was modified externally when entering the buffer/window.
autocmd BufEnter,FocusGained,BufEnter,FocusLost,WinLeave * checktime

" Disable F1, ex mode and Ctrl-Z shortcuts.
map <F1> <nop>
imap <F1> <nop>
nnoremap Q <nop>
nnoremap <Space><Space> <nop>
nnoremap <C-Z> <nop>
nnoremap q: <nop>
nnoremap q/ <nop>

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

command! -bang -nargs=* Grep
  \ :grep <q-args> | :copen

command! -bang -nargs=* GrepW
  \ :grep '\b<args>\b' | :copen

" TODO: add shorcuts to switch or delete buffers.
nnoremap <silent> <Leader>/ :nohlsearch<CR>
" Open new lines without going to insert mode.
nnoremap <Leader>A O<Esc>
nnoremap <expr> <Leader>a &modifiable?"o<Esc>":"<CR>"
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>d <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>e :set spelllang=en<CR>:set spell<CR>
nnoremap <Leader>f <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <Leader>g :Rg 
nnoremap <Leader>h :hide<CR>
nnoremap <Leader>H <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <Leader>jn <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <Leader>jp <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <Leader>l "*p
nnoremap <Leader>L "*P
nnoremap <Leader>m <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <Leader>n :only<CR>
nnoremap <Leader>o :Files<CR>
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
nnoremap <Leader>* :Rgw <C-R><C-W><CR>
nnoremap <Leader>q :update<CR>:q<CR>
nnoremap <Leader>r <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <Leader>s /\<\><Left><Left>
nnoremap <Leader>t :Trouble diagnostics toggle filter.buf=0<CR>
nnoremap <Leader>u :GundoToggle<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y

command! GpushNew :Gpush origin -u HEAD

" To disambiguate with OutgoingCalls.
cnoreabbrev O OpenSession

command! CB call CloseBuffersForNonexistentFiles()

" Close all buffers pointing to files that don't exist.
function! CloseBuffersForNonexistentFiles()
    for buf in nvim_list_bufs()
        if !filereadable(expand('#' . buf))
            call nvim_buf_delete(buf, {})
        endif
    endfor
endfunction

" Plugin configuration.
" Licenses
let g:licenses_copyright_holders_name = "Boucher, Antoni <bouanto@zoho.com>"

" Airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" GUndo
let g:gundo_map_move_older = "t"
let g:gundo_map_move_newer = "s"

" Vimple fix.
let vimple_init_vn = 0

" Ncm
set completeopt=noinsert,menuone,noselect
" Enter newline instead of just closing the completion popup on enter.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Fzf
let g:fzf_layout = { 'down': '40%' }

" Indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :highlight IndentGuidesOdd ctermfg=234 ctermbg=237
autocmd VimEnter,Colorscheme * :highlight IndentGuidesEven ctermfg=234 ctermbg=237

" Lsp

" TODO: put in an external file.

lua << EOF
local cmp = require'cmp'

cmp.setup({
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  preselect = cmp.PreselectMode.None,
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require'lspconfig'

vim.g.rustaceanvim = {
    server = {
        default_settings = {
            ["rust-analyzer"] = {
                ["cargo"] = {
                    ["features"] = "all",
                },
                rustc = {
                    source = "discover",
                },
            },
        },
    },
}

lspconfig.clangd.setup{
    capabilities = capabilities,
}
lspconfig.pylsp.setup{
    capabilities = capabilities,
    settings = {
        ['pylsp'] = {
            ['plugins'] = {
                ['flake8'] = {
                    ['enabled'] = true
                },
                ['pycodestyle'] = {
                    ['enabled'] = false
                },
                ['pyflakes'] = {
                    ['enabled'] = false
                }
            },
        },
    },
}

require("inc_rename").setup({
    cmd_name = "Rename",
})
vim.keymap.set("n", "<leader>j", ":IncRename ")

require "lsp_signature".setup()

require("fidget").setup {
}

require 'trouble'.setup {
    icons = {},
    keys = {
        t = "next",
        s = "prev",
        -- Toggles the severity.
        v = {
            action = function(view)
                local f = view:get_filter("severity")
                local severity = ((f and f.filter.severity or 0) + 1) % 5
                view:filter({ severity = severity }, {
                    id = "severity",
                    template = "{hl:Title}Filter:{hl} {severity}",
                    del = severity == 0,
                })
            end,
            desc = "Toggle Severity Filter",
        },
    },
}

local signs = {
    Error = "",
    Warn = "",
    Hint = "",
    Info = "",
}

-- To have pretty diagnostic icons.
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    -- TODO: could this be in vimscript?
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Disable inline diagnostics.
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false
    }
)

require'fzf_lsp'.setup()

EOF
