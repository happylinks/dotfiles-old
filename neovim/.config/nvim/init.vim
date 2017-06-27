set encoding=utf-8

call plug#begin()
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
Plug 'sbdchd/neoformat'
Plug 'maralla/completor.vim', {'do': 'cd pythonx/completers/javascript && npm install'}
Plug 'mxw/vim-jsx'
Plug 'Valloric/MatchTagAlways'
Plug 'alvan/vim-closetag'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
" Plug 'craigemery/vim-autotag'
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
set wildignore+=*/.git/*,*/tmp/*,*.swp,*.json

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
" Tmux Left doesn't work on osx
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

" FZF
" let g:fzf_layout = { 'window': 'enew' }

" Remap CTRL+P to fzf :Files
nnoremap <C-S-P> :Files<cr>
" Remap CTRL+B to fzf :Buffers
nnoremap <C-S-B> :Buffers<cr>
nnoremap <silent> <leader><leader> :Files<cr>
nnoremap <silent> <Leader>c :Colors<cr>
nnoremap <silent> <Leader>b :Buffers<cr>
nnoremap <silent> <Leader>h :Helptags<cr>

" Add fzf :Find command with ripgrep and remap to CTR+F
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --fixed-strings --ignore-case --follow --glob "!(.git/*|.json)" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0) 
nnoremap <C-S-F> :Find<cr>

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

" use 4 spaces for tabs
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab

" remove whitespace
autocmd FileType javascript autocmd BufWritePre <buffer> %s/\s\+$//e
autocmd FileType javascript.jsx autocmd BufWritePre <buffer> %s/\s\+$//e

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
            \ 'exe': '/Users/michielwesterbeek/.nvm/versions/node/v7.3.0/bin/prettier',
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

" NerdTree
" Open NERDTree automatically when vim starts if no files specified.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Focus on the buffer automatically if no files specified.
autocmd VimEnter * wincmd p
" Close vim when NERDTree is the last open buffer.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Show hidden files in NERDTree
let NERDTreeIgnore = ['\.tags$','^tags$']
let NERDTreeShowHidden=1

" NERDCommenter

" MatchTagAlways
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'javascript' : 1,
    \ 'javascript.jsx' : 1,
    \}

" vim-closetag
let g:closetag_filenames = "*.html,*.xhtml,*.jsx,*.js"
let g:closetag_emptyTags_caseSensitive = 1

" Theming

" set background=dark " for the dark version
" set background=light " for the light version
syntax on
colorscheme onedark
let g:onedark_terminal_italics = 1
" hi Normal guibg=NONE ctermbg=NONE
hi Visual term=reverse cterm=reverse guibg=NONE
highlight SignColumn ctermbg=none

" Airline/Powerline
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline_detect_crypt = 0
let g:airline_detect_spell = 0
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline_section_y = airline#section#create([]) " Hide fileencoding and fileformat.
let g:airline_section_z = airline#section#create([]) " Hide percentage, line number and column number.
let g:airline#extensions#wordcount#enabled = 0 " Hide wordcount.
let g:airline#extensions#tabline#buffer_nr_show = 1
" Just show the filename (no path) in the tab
let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline_skip_empty_sections = 1
set laststatus=2
set ttimeoutlen=50

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
