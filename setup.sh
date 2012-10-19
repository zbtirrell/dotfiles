#!/bin/bash

# based on work by Matthew Batchelder

link_shizzle() {
	# if the file is a symlink, just toss it
	if [ -h "$2" ]
	then
		rm $2
	fi

	# if the file exists, rename it
	if [ -e "$2" ]
	then
		mv $2 $2.backup
	fi

	# symlink the desired file
	ln -s $1 $2
}

if [ ! -d ~/bin ]
then
	mkdir ~/bin
fi

link_shizzle  ~/dotfiles/.bashrc            ~/.bashrc
link_shizzle  ~/dotfiles/.vimrc             ~/.vimrc
link_shizzle  ~/dotfiles/.vim               ~/.vim
link_shizzle  ~/dotfiles/.gitconfig         ~/.gitconfig
link_shizzle  ~/dotfiles/subversion/config  ~/.subversion/config

source ~/.bashrc
