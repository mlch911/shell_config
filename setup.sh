#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
	os='mac'
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	os='Linux'
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
	os='win'
fi


if [ ! -d ~/.config/nvim ]; then
    mkdir ~/.config/nvim
fi

cd ~/.config/config

if [ x$1 == "x--no-git-update" ]; then
    echo
else
    git pull
fi


ln -s -f ~/.config/config/.zshrc					~/.zshrc
ln -s -f ~/.config/config/.tmux.conf				~/.tmux.conf
ln -s -f ~/.config/config/.p10k.zsh					~/.p10k.zsh
[ -f "$HOME/.config/config/.zshrc_machine_specific" ] && \
ln -s -f ~/.config/config/.zshrc_machine_specific	~/.zshrc_machine_specific
# nvim
ln -s -f ~/.config/config/vim/init.vim				~/.config/nvim/init.vim
ln -s -f ~/.config/config/vim/config				~/.config/nvim/
# coc
ln -s -f ~/.config/config/vim/coc-settings.json		~/.config/nvim/coc-settings.json
# byobu
if [ -x `command -v byobu` ]; then
	ln -sfF ~/.config/config/.byobu					~/
fi
# ranger
ln -sfF ~/.config/config/ranger					~/.config/

# Mac
if [ $os == "mac" ]; then
	ln -s -f ~/.config/config/mac/karabiner.edn		~/.config/karabiner.edn
	ln -sfF ~/.config/config/mac/.hammerspoon		~
	ln -sfF ~/.config/config/.byobu					~
fi
