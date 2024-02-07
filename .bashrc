export TERM=xterm-color
export EDITOR=vi
export SVN_EDITOR="vi --noplugin"
export PATH=$PATH:/usr/local/bin:/usr/local/sbin
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
#export PATH=/usr/local/opt/php/bin:/usr/local/opt/php/sbin:$PATH
export PATH=/usr/local/php5/bin:$PATH
export PATH=$PATH:$HOME/.composer/vendor/bin
export PATH=~/code/tribe-product-utils:$PATH

export HISTCONTROL=ignoreboth
export HISTSIZE=10000
shopt -s histappend
shopt -s cmdhist

. ~/dotfiles/.bash_prompt

umask 002

alias git=hub
alias ls=exa

export XDEBUG_CONFIG="idekey=VSCODE"
