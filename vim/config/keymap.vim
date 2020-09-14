let mapleader=" "

" 方向键
noremap j h
noremap J H
noremap k j
noremap K 5j
noremap i k
noremap I 5k
noremap h i
noremap H I

" 搜索
exec "nohlsearch"
noremap = nzz
noremap - Nzz
noremap <LEADER><CR> :nohlsearch<CR>

" Vim操作
map R :source $MYVIMRC<CR>
map S :w<CR>
map s <nop>
map Q :q<CR>

" Open the vimrc file anytime
noremap <LEADER>rc :tabe ~/.config/nvim/init.vim<CR>

" 分Tab
map te :tabe<CR>
map tl :tabnext<CR>
map tj :-tabnext<CR>

" 分屏
map sl :set splitright<CR>:vsplit<CR>
map sj :set nosplitright<CR>:vsplit<CR>
map si :set nosplitbelow<CR>:split<CR>
map sk :set splitbelow<CR>:split<CR>
:tnoremap <Esc> <C-\><C-n>

map <LEADER>l <C-w>l
map <LEADER>j <C-w>h
map <LEADER>k <C-w>j
map <LEADER>i <C-w>k

map <LEADER><up> :res +5<CR>
map <LEADER><down> :res -5<CR>
map <LEADER><left> :vertical resize-5<CR>
map <LEADER><right> :vertical resize+5<CR>

imap <C-c> <Esc>
