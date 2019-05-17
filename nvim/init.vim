" Plugins

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'qbbr/vim-twig'
Plug 'editorconfig/editorconfig-vim'

call plug#end()

" Configuration

" Set my vim clickable

set mouse=a

nnoremap <silent> <C-k><C-B> :NERDTreeToggle<CR>

let g:user_emmet_leader_key=','
