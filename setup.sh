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

# setup mysql to autostart
cp com.mysql.mysql.plist /Library/LaunchDaemons/com.mysql.mysql.plist
sudo chown root:wheel /Library/LaunchDaemons/com.mysql.mysql.plist
sudo chmod 644 /Library/LaunchDaemons/com.mysql.mysql.plist
sudo launchctl load -w /Library/LaunchDaemons/com.mysql.mysql.plist

# stop some annoying Safari behavior
defaults write com.apple.Safari WebKitOmitPDFSupport -bool YES
defaults write com.apple.Safari AutoOpenSafeDownloads -bool NO

defaults write com.apple.Safari NSAppSleepDisabled -bool YES
