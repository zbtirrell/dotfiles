export TERM=xterm-color
export EDITOR=vi
export SVN_EDITOR="vi --noplugin"
export PATH=$PATH:/usr/local/bin:/usr/local/sbin
export PATH=$PATH:/usr/local/php5/bin:/usr/local/share/npm/bin
export PATH=$HOME/local/bin:$HOME/bin:$HOME:$HOME/adt-bundle-mac/sdk/platform-tools:$HOME/pear/bin:$HOME/android-sdk-macosx/platform-tools:$HOME/code/tribe-product-utils:$PATH
# binaries from https://php-osx.liip.ch - Note: PHP 7 installed here despite directory name
export PATH=/usr/local/php5/bin:$PATH
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

export SELENIUM_SERVER_JAR=/usr/local/bin/selenium-server-standalone-2.34.0.jar
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
shopt -s histappend
shopt -s cmdhist

. ~/dotfiles/.git-completion.bash

. ~/dotfiles/.bash_prompt

umask 002

alias git=hub
alias weather='curl wttr.in/03264'
alias ls=exa


alias xon="export XDEBUG_CONFIG=\"profiler_enable=1\""
alias xoff="export XDEBUG_CONFIG=\"profiler_enable=0\""

export GITHUB_UPSTREAM=origin

function pr_for_sha {
  git log --merges --ancestry-path --oneline $1..master | grep 'pull request' | tail -n1 | awk '{print $5}' | cut -c2- | xargs -I % open https://github.com/$GITHUB_UPSTREAM/${PWD##*/}/pull/%
}

eval "$(thefuck --alias)"
