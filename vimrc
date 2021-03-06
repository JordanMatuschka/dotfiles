"Z, add 'source ~/dotfiles/vimrc' to your .vimrc
" be sure to create the directories ~/.vim/backup and ~/.vim/tmp if they don't exist

syntax enable
set incsearch
set ts=4
set shiftwidth=4
set softtabstop=4
set tabstop=4
set hlsearch
set expandtab
set autoindent
set paste

" Allow manual folding
setlocal foldmethod=manual
" Automatically save/load views (and therefore folds)
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview 

" Nice line wrapping
if v:version >= 704
	set breakindent
	set showbreak=>>>>
endif

" Make backspace work properly
set backspace=2

" Keep all temporary and backup files in one spot:
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" define an easier <Leader> key
let mapleader=","

" Remap to save your shifting pinkies
nore ; :

" Stupid aliases for my bad shifting practices
:command WQ wq
:command Wq wq
:command W w
:command Q q

" bash like auto-completion
set wildmenu
set wildmode=list:longest

" my capslock to esc doesn't work too well
inoremap ii <Esc>

" Let's use the mouse!
" if you need to copy/paste from the console, you can use :set mouse-=a to disable automatic visual mode
set mouse=a

map <C-m> :NERDTreeToggle<CR>


" Baddass status bar 
" src http://www.reddit.com/r/vim/comments/gexi6/a_smarter_statusline_code_in_comments/
hi StatColor guibg=#95e454 guifg=black ctermbg=lightgreen ctermfg=black
hi Modified guibg=orange guifg=black ctermbg=lightred ctermfg=black

function! MyStatusLine(mode)
    let statusline=""
    if a:mode == 'Enter'
        let statusline.="%#StatColor#"
    endif
    let statusline.="\(%n\)\ %f\ "
    if a:mode == 'Enter'
        let statusline.="%*"
    endif
    let statusline.="%#Modified#%m"
    if a:mode == 'Leave'
        let statusline.="%*%r"
    elseif a:mode == 'Enter'
        let statusline.="%r%*"
    endif
    let statusline .= "\ (%l/%L,\ %c)\ %P%=%h%w\ %y\ [%{&encoding}:%{&fileformat}]\ \ "
    return statusline
endfunction

autocmd WinEnter * setlocal statusline=%!MyStatusLine('Enter')
autocmd WinLeave * setlocal statusline=%!MyStatusLine('Leave')
set statusline=%!MyStatusLine('Enter')

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi StatColor guibg=orange ctermbg=lightred
  elseif a:mode == 'r'
    hi StatColor guibg=#e454ba ctermbg=magenta
  elseif a:mode == 'v'
    hi StatColor guibg=#e454ba ctermbg=magenta
  else
    hi StatColor guibg=red ctermbg=red
  endif
endfunction 

autocmd InsertEnter * call InsertStatuslineColor(v:insertmode)
autocmd InsertLeave * hi StatColor guibg=#95e454 guifg=black ctermbg=lightgreen ctermfg=black

" Always show status line
set laststatus=2
