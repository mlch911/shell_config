#!/bin/bash
if [ ! -d ~/.config/nvim ]; then
    mkdir ~/.config/nvim
fi

cd ~/.config/config

if [ x$1 == "x--no-git-update" ]; then
    echo
else
    git pull
fi


ln -s -f ~/.config/config/.zshrc                    ~/.zshrc
ln -s -f ~/.config/config/.tmux.conf                ~/.tmux.conf
ln -s -f ~/.config/config/.p10k.zsh                 ~/.p10k.zsh
[ -f "$HOME/.config/config/.zshrc_machine_specific" ] && \
	ln -s -f ~/.config/config/.zshrc_machine_specific ~/.zshrc_machine_specific
# nvim
ln -s -f ~/.config/config/vim/init.vim              ~/.config/nvim/init.vim
ln -s -f ~/.config/config/vim/config                ~/.config/nvim/
# coc
ln -s -f ~/.config/config/vim/coc-settings.json     ~/.config/nvim/coc-settings.json
