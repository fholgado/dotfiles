"PATHOGEN YO
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
"
" Sets how many lines of history VIM has to remember
set history=300
set ttyfast
set hidden

" Turn off Vi compatibility
set nocompatible

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

" Set Fonts
set gfn=Inconsolata:h14
set shell=/bin/bash

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
  set background=dark
  set t_Co=256
  set background=dark
  colorscheme molokai2

  set nu
else
  colorscheme zellner
  set background=dark
  
  set nonu
endif

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

" Tab configuration
map <leader>tn :tabnew %<cr>
map <leader>te :tabedit 
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

" Custom maps to set working directories quickly
" At Work
map <leader>p1 :cd /Applications/XAMPP/htdocs/ptonline/trunk/system/application/<cr>
map <leader>p2 :cd /Applications/XAMPP/htdocs/pt20/trunk/<cr>
" At Home
map <leader>p3 :cd ~/Sites/ptonline/system/application/<cr>
map <leader>p4 :cd ~/Sites/pt20/<cr>


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

" Format the statusline
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

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

" Minibuffer plugin
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerMoreThanOne = 2
let g:miniBufExplModSelTarget = 0
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplVSplit = 0
let g:miniBufExplSplitBelow=0

let g:bufExplorerSortBy = "name"

autocmd BufRead,BufNew :call UMiniBufExplorer

autocmd FileType less set omnifunc=csscomplete#CompleteCSS

"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

au FileType javascript setl nocindent
au FileType javascript imap <c-a> alert();<esc>hi

"Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>

" Load autoclose HTML Tags
:au Filetype php,html,xml,xsl source ~/.vim/bundle/html-autoclosetag/ftplugin/html_autoclosetag.vim

" Set to full screen on load
" if has("gui_running")
"   set fuoptions=maxvert,maxhorz
"   au GUIEnter * set fullscreen
" endif

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

let php_htmlInStrings = 1  "for HTML syntax highlighting inside strings

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
