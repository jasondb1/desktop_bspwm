"Environment
set background=dark
set scrolloff=3
set number
set cmdheight=1

"hi LineNr guifg=OliveDrab2 guibg=gray40 "set line number color

set cursorline
"hi cursorline guibg=\#333333 "highlight bg colo of current line
"hi CursorColumn guibg=\#333333 "highlight cursor

"highlight LineNr guibg=grey

"set textwidth=80
set colorcolumn=80

"Map Keys
:map <F2> <Esc>:w<CR>
:map! <F2> <Esc>:w<CR>
"map and make  
:map  <F6> <Esc>:w<CR>;:!make<CR>
:map! <F6> <Esc>:w<CR>;:!make<CR>
:map  <F7> :w<CR>;:!clear;!make<CR>;:!./%<<CR>
:map! <F7> :w<CR>;:!clear;!make<CR>;:!./%<<CR>

:map  <F3> <Esc>:w<CR>;:!clear;!gcc %<CR>;:!echo "***Running***"<CR>;:!./a.out<CR>
:map! <F3> <Esc>:w<CR>;:!clear;!gcc %<CR>;:!echo "***Running***"<CR>;:!./a.out<CR>

:map  <F4> <Esc>:w<CR>:!clear;:!m4 %>%<.s;:!gcc %<.s<CR>;:!echo "***Running***"<CR>;:!./a.out<CR>
:map! <F4> <Esc>:w<CR>:!clear;:!m4 %>%<.s;:!gcc %<.s<CR>;:!echo "***Running***"<CR>;:!./a.out<CR>


:map  <F5> <Esc>:w<CR>;:!clear;:!m4 %>%<.s;!gcc %<.s<CR>;:!echo "***Running***"<CR>;:!gdb a.out<CR>
:map! <F5> <Esc>:w<CR>;:!clear;:!m4 %>%<.s;!gcc %<.s<CR>;:!echo "***Running***"<CR>;:!gdb a.out<CR>
":map <F5> <Esc>:w<CR> :!clear; gcc -o %< %<CR> :!echo "***Running***"; echo; command time -v "./%<"<CR>
":map! <F5> <Esc>:w<CR> :!clear; gcc -o %< %<CR> :!echo "***Running***"; echo; command time -v "./%<"<CR>

inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

""Restore cursor to last position when file was closed
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" au BufEnter *.c compiler gcc

"General
set nocompatible
syntax on
set mouse=a
set autochdir
set noerrorbells
set backspace=indent,eol,start "backspace for dummys
set history=1000
set showcmd
"set foldmethod=syntax "or manual, or indent or marker

" Indent and Tabs
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab
set shiftround
set autoindent

"search options
set incsearch
set hlsearch
set ignorecase
set smartcase

"set foldenable

" Set up directories
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//
set viewdir=$HOME/.vim/views//
"" Create directories if they don't exist
silent execute '!mkdir -p $HOME/.vim/backup'
silent execute '!mkdir -p $HOME/.vim/swap'
silent execute '!mkdir -p $HOME/.vim/views'


""" Status Bar
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=Cyan ctermfg=6 guifg=Black ctermbg=0
  elseif a:mode == 'r'
    hi statusline guibg=Purple ctermfg=5 guifg=Black ctermbg=0
  else
    hi statusline guibg=DarkRed ctermfg=1 guifg=Black ctermbg=0
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15

" default the statusline to green when entering Vim
hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15

" Formats the statusline
set statusline=%f                           " file name
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%y      "filetype
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag

" Puts in the current git status
"    if count(g:pathogen_disabled, 'Fugitive') < 1   
"        set statusline+=%{fugitive#statusline()}
"    endif

" Puts in syntastic warnings
"    if count(g:pathogen_disabled, 'Syntastic') < 1  
"        set statusline+=%#warningmsg#
"        set statusline+=%{SyntasticStatuslineFlag()}
"
"        set statusline+=%*
"    endif

set statusline+=\ %=                        " align left
set statusline+=Line:%l/%L"[%p%%]            " line X of Y [percent of file]
set statusline+=\ Col:%c                    " current column
set statusline+=\ Buf:%n                    " Buffer number
set statusline+=\ [%b][0x%B]\               " ASCII and byte code under cursor

set laststatus=2


"Custom Functions --s section  --h for module header
let s:width = 78 

function! HaskellModuleSection(...)
  let name = 0 < a:0 ? a:1 : inputdialog("Section name: ")

  return  repeat('-', s:width) . "\n"
  \       . "--  " . name . "\n"
  \       . "\n"

endfunction
nmap <silent> --s "=HaskellModuleSection()<CR>gpshowcmd


function! HaskellModuleHeader(...)
  let name = 0 < a:0 ? a:1 : inputdialog("Module: ")
  let note = 1 < a:0 ? a:2 : inputdialog("Note: ")
  let description = 2 < a:0 ? a:3 : inputdialog("Describe this module: ")

  return  repeat('-', s:width) . "\n" 
  \       . "-- | \n" 
  \       . "-- Module      : " . name . "\n"
  \       . "-- Note        : " . note . "\n"
  \       . "-- \n"
  \       . "-- " . description . "\n"
  \       . "-- \n"
  \       . repeat('-', s:width) . "\n"
  \       . "\n"

endfunction
nmap <silent> --m "=HaskellModuleHeader()<CR>:0put =<CR>


function! FileHeader(...)
  let name = 0 < a:0 ? a:1 : inputdialog("Filename: ")
  let note = 1 < a:0 ? a:2 : inputdialog("Note: ")
  let description = 2 < a:0 ? a:3 : inputdialog("Describe this module: ")
  "let userdate = 3 < a:0 ? a:4 : inputdialog("Date: ")
  let userdate = strftime("%d %b %Y")

  return  "//" . repeat('-', s:width) . "\n" 
  \       . "// | \n" 
  \       . "// Filename    : " . name . "\n"
  \       . "//\n"
  \       . "// Author      :Jason De Boer\n"
  \       . "// ID          :30034428\n"
  \       . "// Date        :". userdate . "\n"
  \       . "//\n"
  \       . "//\n"
  \       . "// Note        : " . note . "\n"
  \       . "// \n"
  \       . "// " . description . "\n"
  \       . "// \n//"
  \       . repeat('-', s:width) . "\n"
  \       . "\n"

endfunction
nmap <silent> --h "=FileHeader()<CR>:0put =<CR>


""Change the file to correct template file

function! Class()
    let fn = new-file.txt
    " ~/vim/cpp/new-class.txt is the path to the template file
    r~/.vim/templates/fn
endfunction

nmap ^N :call Class()<CR>



"hi clear LineNr
"hi clear
colorscheme cobalt
hi ColorColumn guibg=#1d1d1d ctermbg=238

