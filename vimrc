" Sets how many lines of history VIM has to remember
set history=300
set ttyfast
set hidden

" Turn off Vi compatibility
set nocompatible

"Vundle Config
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" My Bundles here:
Bundle 'tpope/vim-fugitive'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'tpope/vim-endwise'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'groenewege/vim-less'
Bundle 'tsaleh/vim-matchit'
Bundle 'scrooloose/nerdtree'
Bundle 'msanders/snipmate.vim'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/syntastic'
Bundle 'vim-scripts/tComment'
Bundle 'tpope/vim-unimpaired'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-rails'
Bundle 'Lokaltog/vim-powerline'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'fholgado/Molokai2'
Bundle 'vim-scripts/ZoomWin'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'Raimondi/delimitMate'

" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>
cmap w!! w !sudo tee % >/dev/null

" Fast editing of the .vimrc
" map <leader>e :e! ~/.vim_runtime/vimrc<cr>
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vim/vimrc
autocmd! bufwritepost .vimrc source ~/.vim/vimrc

" Set 7 lines to the curors - when moving vertical..
set so=7

set wildmenu "Turn on WiLd menu

set ruler "Always show current position

set cmdheight=1 "The commandbar height

set hid "Change buffer - without saving

"Browser Refresh
let g:RefreshRunningBrowserDefault = 'chrome'
map <silent><leader>r :RRB<CR>

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching

set hlsearch "Highlight search things

set incsearch "Make search act like search in modern browsers

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set visualbell t_vb=

syntax enable "Enable syntax hl

set shell=/bin/bash

" Set fancy stuff for statusline
let g:Powerline_symbols = 'fancy'

autocmd bufwritepost .vimrc call Pl#Load()

" Highlight current line
:set cursorline

if has("gui_running")
  set guioptions-=T
  set guioptions-=m
  set guioptions-=R  "remove right-hand scroll Bar
  set guioptions-=r  "remove right-hand scroll Bar
  set guioptions-=l  "remove right-hand scroll Bar
  set guioptions-=L  "remove right-hand scroll bar
  set showtabline=0
  set t_Co=256
  set background=light
  colorscheme molokai2

else
  set t_Co=256
  colorscheme molokai2
  set background=dark
endif
set number

set encoding=utf8
try
    lang en_US
catch
endtry

set ffs=unix,dos,mac "Default file types

" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

set smarttab
set tabstop=2
set shiftwidth=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" for CSS, also have things in braces indented:
autocmd FileType css,less set smartindent
" for HTML, generally format text, but if a long line has been created
" leave it alone when editing:
autocmd FileType html set formatoptions+=tl
" for both CSS and HTML, use genuine tab characters for 
" indentation, to make files a few bytes smaller:
autocmd FileType html,css set noexpandtab tabstop=2

set lbr

set autoindent "Auto indent
set wrap linebreak nolist
" set formatoptions=qrn1

" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Map space to / (search) and c-space to ? (backgwards search)
map <space> /
map <c-space> ?

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Switch buffers with L and H easily
map L :bn<cr>
map H :bp<cr>

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

" Custom maps to set working directories quickly
" At Work
map <leader>p1 :cd /Applications/XAMPP/htdocs/<cr>

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Always hide the statusline
set laststatus=2

"Remap VIM 0
map 0 ^

" Bubble single lines
nmap K [e
nmap J ]e
" Bubble multiple lines
vmap K [egv
vmap J ]egv

" Visually select the text that was last edited/pasted
nmap gV `[v`]

" MiniBufExplorer plugin
" let g:miniBufExplorerMoreThanOne = 0
" let g:miniBufExplUseSingleClick = 1
" let g:miniBufExplVSplit = 0
" let g:miniBufExplSplitBelow=0
" let g:miniBufExplorerDebugMode = 1
" let g:miniBufExplorerDebugLevel = 1
" let g:miniBufExplMapWindowNavVim = 0
" let g:miniBufExplCloseOnSelect = 1
" let g:miniBufExplCheckDupeBufs = 0
" map <Leader>m :TMiniBufExplorer<cr>

autocmd FileType less set omnifunc=csscomplete#CompleteCSS

"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>

" sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

"don't move the cursor after pasting (by jumping to back start of previously changed text)
noremap p p`[
noremap P P`[

" Insert an empty line above or below the cursor
nnoremap <D-j> o<Esc>
nnoremap <D-k> O<Esc>

" Turn search highlighting off quickly
nnoremap <leader><space> :noh<cr>

" Make selecting inside an HTML tag less dumb
nnoremap Vit vitVkoj
nnoremap Vat vatV

" Set LESS filetype automatically!
au BufNewFile,BufRead *.less set filetype=less

" Show Yankring contents
nnoremap <silent> <leader>y :YRShow<cr>

" Adding a Next verb to Vim commands 
" SOURCE: http://forrst.com/posts/Adding_a_Next_Adjective_to_Vim_Version_2-C4P
" Shortcut for square brackets "
onoremap id i[
onoremap ad a[

" Next () "
onoremap <silent> inb :<C-U>normal! f(vib<cr>
onoremap <silent> anb :<C-U>normal! f(vab<cr>
onoremap <silent> in( :<C-U>normal! f(vi(<cr>
onoremap <silent> an( :<C-U>normal! f(va(<cr>

" Next {} "
onoremap <silent> inB :<C-U>normal! f{viB<cr>
onoremap <silent> anB :<C-U>normal! f{vaB<cr>
onoremap <silent> in{ :<C-U>normal! f{vi{<cr>
onoremap <silent> an{ :<C-U>normal! f{va{<cr>

" Next [] "
onoremap <silent> ind :<C-U>normal! f[vi[<cr>
onoremap <silent> and :<C-U>normal! f[va[<cr>
onoremap <silent> in[ :<C-U>normal! f[vi[<cr>
onoremap <silent> an[ :<C-U>normal! f[va[<cr>

" Next <> "
onoremap <silent> in< :<C-U>normal! f<vi<<cr>
onoremap <silent> an< :<C-U>normal! f<va<<cr>

" Next '' "
onoremap <silent> in' :<C-U>normal! f'vi'<cr>
onoremap <silent> an' :<C-U>normal! f'va'<cr>

" Next "" "
onoremap <silent> in" :<C-U>normal! f"vi"<cr>
onoremap <silent> an" :<C-U>normal! f"va"<cr>

" Rainbows!
nmap <leader>R :RainbowParenthesesToggle<CR>

" NERDTree configuration
let NERDTreeIgnore=['\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces "
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction
set foldtext=MyFoldText()

" Syntastic Options
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

" Markdown to HTML
nmap <leader>md :%!/usr/local/bin/Markdown.pl --html4tags <cr>

" Git Push commands
map <leader>ph :Git push heroku master <cr>
map <leader>pg :Git push github master <cr>
map <leader>gw :Gwrite <cr>
map <leader>gc :Gcommit <cr>
map <leader>gs :Gstatus <cr>

" Statline stuff
let g:statline_fugitive = 1

" CtrlP plugin
let g:ctrlp_mruf_exclude = '/tmp/.*\|/temp/.*|.DS_Store' " MacOSX/Linux
let g:ctrlp_map = '<C-u>'
let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|DS_Store'

" ZoomWin configuration
map <Leader><Leader> :ZoomWin<CR>

" Trailing Whitespaces as .
set list listchars=tab:\ \ ,trail:·

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Remap jk to ESC
inoremap jk <ESC>

" Send visual selection to gist.github.com
" Requires gist (brew install gist)
vnoremap <leader>G :w !gist -p -t %:e \| pbcopy<cr>

" Project Tree
" autocmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))

" If the parameter is a directory, cd into it
function s:CdIfDirectory(directory)
  let explicitDirectory = isdirectory(a:directory)
  let directory = explicitDirectory || empty(a:directory)

  if explicitDirectory
    exe "cd " . a:directory
  endif

  if directory
    " NERDTree
    wincmd p
    bd
  endif
endfunction

" NERDTree utility function
function s:UpdateNERDTree(...)
  let stay = 0

  if(exists("a:1"))
    let stay = a:1
  end

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      if !stay
        wincmd p
      end
    endif
  endif

  if exists("CommandTFlush")
    CommandTFlush
  endif
endfunction

" Utility functions to create file commands
function s:CommandCabbr(abbreviation, expansion)
  execute 'cabbrev ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction

function s:FileCommand(name, ...)
  if exists("a:1")
    let funcname = a:1
  else
    let funcname = a:name
  endif

  execute 'command -nargs=1 -complete=file ' . a:name . ' :call ' . funcname . '(<f-args>)'
endfunction

function s:DefineCommand(name, destination)
  call s:FileCommand(a:destination)
  call s:CommandCabbr(a:name, a:destination)
endfunction

" Public NERDTree-aware versions of builtin functions
function ChangeDirectory(dir, ...)
  execute "cd " . a:dir
  let stay = exists("a:1") ? a:1 : 1

  " NERDTree

  if !stay
    wincmd p
  endif
endfunction

function Touch(file)
  execute "!touch " . a:file
  call s:UpdateNERDTree()
endfunction

function Remove(file)
  let current_path = expand("%")
  let removed_path = fnamemodify(a:file, ":p")

  if (current_path == removed_path) && (getbufvar("%", "&modified"))
    echo "You are trying to remove the file you are editing. Please close the buffer first."
  else
    execute "!rm " . a:file
  endif

  call s:UpdateNERDTree()
endfunction

function Edit(file)
  if exists("b:NERDTreeRoot")
    wincmd p
  endif

  execute "e " . a:file

ruby << RUBY
  destination = File.expand_path(VIM.evaluate(%{system("dirname " . a:file)}))
  pwd         = File.expand_path(Dir.pwd)
  home        = pwd == File.expand_path("~")

  if home || Regexp.new("^" + Regexp.escape(pwd)) !~ destination
    VIM.command(%{call ChangeDirectory(system("dirname " . a:file), 0)})
  end
RUBY
endfunction

" Define the NERDTree-aware aliases
call s:DefineCommand("cd", "ChangeDirectory")
call s:DefineCommand("touch", "Touch")
call s:DefineCommand("rm", "Remove")
call s:DefineCommand("e", "Edit")

" Set Fonts
set gfn=Menlo\ for\ Powerline

" Slow Vim
set notimeout
set ttimeout
set timeoutlen=50

:let g:session_autoload = 'no'

" Make life simpler
:command! WQ wq
:command! Wq wq
:command! Qa qa
:command! W w
:command! Q q
