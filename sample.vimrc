" Tutorials{{{
"
" VIM-PLUG GUIDELINES
" Please note that for everything to work hunky dorry you must install
" vim-plug.
" Follow this link to get the guideline https://github.com/junegunn/vim-plug
" Or if you are able to curl from the terminal paste these two lines in your terminal
" (please remove the '"' characters before you do this
"
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" FOLDS TUTORIAL
" zo opens a fold underneath the cursor.
" zO opens all folds underneath the cursor, recursively
" zc closes a fold underneath the cursor
" zC closes all folds underneath the cursor, recursively
" za toggles a fold under the cursor
" zM closes all folds in the buffer
" zR opens all folds in the buffer
" zm closes a level of fold in the buffer
" zr opens a level of fold in the buffer

" While there are a couple of ways of creating folds in vim,
" I prefer the following outlined procedure
" 1. Enter Visual Mode
" 2. Highlight the block to be folded
" 3. Press zf.}}}


" Basic configurations{{{
" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Uncomment this setting to
" Add numbers to each line on the left-hand side.
set number

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Uncomment the setting below to
" Highlight cursor line underneath the cursor vertically.
" set cursorcolumn

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" Do not save backup files.
set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
" set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Allows the lines to wrap if gets to end of screen
set wrap

" This is a setting to prettily display invisible characters in your file
" To use type set list in command mode.
" Note that I have also added a mapping for the following to <F5> see mappings
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:␣


" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif"}}}


" Windows Specific ---------------------------------------------------------------- {{{
" Windows behaves weirdly with the default settings off when using custom vimrc
" Or that ugly cursor line highlight uncomment the following lines to fix

"" This fixes the backspace not working issue
set backspace =indent,eol,start

"" This will remove the highlight on the cursorline
set nocursorline
" }}}


" PLUGINS ---------------------------------------------------------------- {{{

" Plugin code goes here.
" Please note that we are using the vim-plug as the plug-in
" manager
" To update the installed plug-ins we use 
" `:PlugUpdate` in the command mode.
" To update specific plug-ins we can use the following:
" `:PlugUpdate plugin0 plugin1

call plug#begin()

Plug 'rust-lang/rust.vim'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'dracula/vim'

call plug#end()

"" vim-airline
" Automatically displays all buffers when there's only one tab open using vim-airline plugin.
let g:airline#extensions#tabline#enabled = 1

" The following line sets the vim-airline theme to be used for a full site
" with screenshots go to https://github.com/vim-airline/vim-airline/wiki/Screenshots
let g:airline_theme='base16_nord'

"" rust.vim
syntax enable
filetype plugin indent on

" This will enable automatic running of :RustFmt when you save a buffer
let g:rustfmt_autosave = 1

" To set the color-scheme
colorscheme dracula

" }}}


" MAPPINGS --------------------------------------------------------------- {{{

" Mappings code goes here.

" The mappings visualizes whitespaces
noremap <F5> :set list!<CR>
inoremap <F5> <C-o>:set list!<CR>
cnoremap <F5> <C-c>:set list!<CR>

" The mapping below runs clang-format on the file in buffer
if has('python')
    map <leader>c :pyf /usr/share/clang/clang-format-14/clang-format.py<CR>
elseif has('python3')
    map <leader>c :py3f /usr/share/clang/clang-format-14/clang-format.py<CR>
endif

" The following mappings are in relation to nerdtree each will be  explained
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" The following mappings are useful when navigating wrapped lines
nnoremap k gk
nnoremap j gj

" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" Enable the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" If the current file type is HTML, set indentation to 2 spaces.
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

" You can split a window into sections by typing `:split` or `:vsplit`.
" Display cursorline and cursorcolumn ONLY in active window.
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline nocursorcolumn
    autocmd WinEnter * set cursorline cursorcolumn
augroup END

" If GUI version of Vim is running set these options.
if has('gui_running')

    " Set the background tone.
    set background=dark

    " Set the color scheme.
    colorscheme molokai

    " Set a custom font you have installed on your computer.
    " Syntax: set guifont=<font_name>\ <font_weight>\ <size>
    set guifont=Monospace\ Regular\ 12

    " Display more of the file by default.
    " Hide the toolbar.
    set guioptions-=T

    " Hide the the left-side scroll bar.
    set guioptions-=L

    " Hide the the right-side scroll bar.
    set guioptions-=r

    " Hide the the menu bar.
    set guioptions-=m

    " Hide the the bottom scroll bar.
    set guioptions-=b

    " Map the F4 key to toggle the menu, toolbar, and scroll bar.
    " <Bar> is the pipe character.
    " <CR> is the enter key.
    nnoremap <F4> :if &guioptions=~#'mTr'<Bar>
        \set guioptions-=mTr<Bar>
        \else<Bar>
        \set guioptions+=mTr<Bar>
        \endif<CR>

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

endif

"

" }}}


" Undofile ---------------------------------------------------------------- {{{
" To better get this small script refer to
" https://vi.stackexchange.com/questions/6/how-can-i-use-the-undofile
" Please don't forget to add the cronjob for the cleanup
" Let's save undo info!

if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif

set undodir=~/.vim/undo-dir
set undofile

" To add the cronjob execute the following
" $ crontab -e
"
" Then in the editor add the following line
" # m h  dom mon dow   command
" 43 00 *   *   3     find /path/to/.vim/undo-dir -type f -mtime +90 -delete
" }}}
