if [ ! -d ~/.config/nvim ]; then
    mkdir ~/.config/nvim
fi

cd ~/.config/config
git pull

ln -s -f ~/.config/config/.zshrc ~/.zshrc
ln -s -f ~/.config/config/.tmux.conf ~/.tmux.conf
ln -s -f ~/.config/config/.p10k.zsh ~/.p10k.zsh
# nvim
ln -s -f ~/.config/config/vim/init.vim ~/.config/nvim/init.vim
ln -s -f ~/.config/config/vim/config ~/.config/nvim/config
# coc
ln -s -f ~/.config/config/vim/coc-settings.json  ~/.config/nvim/coc-settings.json
