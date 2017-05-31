set encoding=utf-8

call plug#begin()
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'sbdchd/neoformat'
" Plug 'maralla/completor.vim', {'do': 'cd pythonx/completers/javascript && npm install'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'craigemery/vim-autotag'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()

set statusline+=%#warningmsg#
set statusline+=%{ALEGetStatusLine()}
set statusline+=%*
set number
set relativenumber
set omnifunc=syntaxcomplete#Complete
set splitbelow
set splitright
set backspace=indent,eol,start

" Remaps
" Disable Arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Remap CTRL+P to fzf :Files
nnoremap <C-S-P> :Files<cr>

" Add fzf :Find command with ripgrep and remap to CTR+F
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --fixed-strings --ignore-case --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0) 
nnoremap <C-S-F> :Find<cr>

highlight SignColumn ctermbg=none

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

" Ctrlp
" set runtimepath^=~/.vim/bundle/ctrlp.vim
" let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn|dist)|node_modules|bower_components|WEB-INF|build|dist)$',
    \ }

" use 4 spaces for tabs
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab

" remove whitespace
autocmd FileType javascript autocmd BufWritePre <buffer> %s/\s\+$//e

" Ale
set nocompatible
filetype off
let &runtimepath.=',~/.vim/bundle/ale'
filetype plugin indent on
let g:ale_lint_on_text_changed = 'always'
let g:ale_sign_column_always = 1
let g:ale_linters = {
\   'javascript': ['eslint', 'flow'],
\}

" Neoformat
let g:neoformat_javascript_prettier_custom = {
            \ 'exe': 'prettier',
            \ 'args': [
            \    '--stdin',
            \    '--parser flow',
            \    '--single-quote',
            \    '--trailing-comma all',
            \    '--tab-width 4'
            \ ],
            \ 'stdin': 1,
            \ }

let g:neoformat_enabled_javascript = ['prettier_custom']

" Airline/Powerline
let g:airline_theme='onedark'
set laststatus=2

" NerdTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Vimux
" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>
" Zoom the tmux runner pane
map <Leader>vz :VimuxZoomRunner<CR>

" set background=dark " for the dark version
" set background=light " for the light version
colorscheme onedark
hi Normal guibg=NONE ctermbg=NONE

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
