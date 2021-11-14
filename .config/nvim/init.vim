
" reset augroup
augroup LocalAutoCmd
	autocmd!
augroup END

" base options
set t_Co=256

set wildmenu
set showcmd
set shiftwidth=4
set autoindent
set smartindent
set smarttab
set tabstop=4
set expandtab
set nobackup
set autoread
set noswapfile
set nowrap
set backspace=indent,eol,start
set textwidth=0

filetype plugin indent on
syntax on

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

""" lightline
"Plug 'itchyny/lightline.vim'

""" fuzzy finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

""" syntax highliting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" color scheme
Plug 'christianchiarulli/nvcode-color-schemes.vim'

""" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'

" completion
Plug 'nvim-lua/completion-nvim'
""" text object plugins
Plug 'sgur/vim-textobj-parameter'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'nvim-treesitter/nvim-treesitter-textobjects' " https://github.com/nvim-treesitter/nvim-treesitter-textobjects

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

""" other config
Plug 'editorconfig/editorconfig-vim'

""" my settings
Plug 'hidetoshing/tabcommand'
Plug 'hidetoshing/setEncoding'
Plug 'hidetoshing/setSearch'
Plug 'hidetoshing/setLinenumber'

" Initialize plugin system
call plug#end()

""""""""""""""""""""
""" Plugin settings
set laststatus=2

set completeopt=menuone,noinsert,noselect " Set completeopt to have a better completion experience
set shortmess+=c " Avoid showing message extra message when using completion
let g:completion_enable_auto_popup = 1
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)

" treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF

" nvim-lspconfig

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- local servers = { 'pyright', 'rust_analyzer', 'tsserver' }
local servers = { 'pyright' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

" https://github.com/glepnir/lspsaga.nvim
"lua << EOF
"local saga = require'lspsaga'
"saga.init_lsp_saga()
"EOF

vnoremap R <Plug>(operator-replace)

colorscheme nvcode
if (has("termguicolors"))
    set termguicolors

    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " 文字色
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " 背景色icolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

""""
" Clipboard option
set clipboard+=unnamed

""""
" incremant option.
set nf=hex

" increment
nnoremap ++ <C-a>
nnoremap -- <C-x>

" set IME Offset iminsert=0
set imsearch=0
set imdisable

" disable matchparen
let g:loaded_matchparen = 1

" undo setting
if has('persistent_undo')
    set undodir=~/.cache/nvim/undo
    set undofile
endif

""" ----- misc
" Prefix-key
nnoremap [Prefix] <nop>
nmap , [Prefix]

" escape
inoremap <silent> <Esc> <Esc>
inoremap <silent> <C-[> <Esc>

nmap [Prefix]t [Tab]
nmap [Prefix]l [Line]

nmap [Prefix]ff :Files<Return>
nmap [Prefix]fg :GFiles<Return>
nmap [Prefix]fh :History<Return>
nmap [Prefix]fb :Buffers<Return>
nmap [Prefix]fw :Windows<Return>
nmap [Prefix]fm :Marks<Return>
nmap [Prefix]fl :Lines<Return>
nmap [Prefix]fr :Rg<Return>

" shift + move selection
imap <S-down> <ESC>v
imap <S-up> <ESC>v<up>
imap <S-left> <ESC>v
imap <S-right> <ESC><right>v
vnoremap <S-down> <down>
vnoremap <S-up> <up>
vnoremap <S-left> <left>
vnoremap <S-right> <right>

" move option
nnoremap <silent> g. `.
nnoremap <silent> g0 `.0
nnoremap <silent> gm ``

" auto paren (visual mode)
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap ( "zdi(<C-R>z)<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

" yank to line end
nmap Y y$<ESC>

" reload .vimrc
nnoremap [Prefix]vr  :<C-u>source $MYVIMRC<Return>
command! -nargs=0 ReloadSetting :<C-u>source $MYVIMRC<Return>
nnoremap [Prefix]vv  :<C-u>e $MYVIMRC<Return>

" temp extention file
command! -nargs=1 -complete=filetype Temp tabe ~/.scratch.<args>

""" EOF
