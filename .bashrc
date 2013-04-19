export EDITOR=vi
export SVN_EDITOR="vi --noplugin"
export PATH=$HOME/local/bin:$HOME/bin/:$HOME/:/usr/local/bin:/usr/local/share/npm/bin:/Users/zbtirrell/adt-bundle-mac/sdk/platform-tools:$PATH
export CODAPATH="/Applications/Coda 2.app"

export HISTCONTROL=ignoreboth
export HISTSIZE=10000
shopt -s histappend
shopt -s cmdhist

. ~/dotfiles/.git-completion.bash

. ~/dotfiles/.bash_prompt

umask 002

 . `brew --prefix`/etc/profile.d/z.sh
