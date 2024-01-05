dotfiles
========
## Install [Homebrew](http://mxcl.github.com/homebrew/)
````
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
````

### Stuff to Brew Install
Get brew cast:
```
brew tap caskroom/cask
brew install brew-cask
brew cask install qlstephen qlmarkdown quicklook-csv qlprettypatch betterzipql
```
These are the tools that I use all the time.
```
brew install fmdiff git subversion wget the_silver_searcher hub
```

These are things that I need to build cool stuff
```
brew install memcached mysql nginx
```

Accept the xCode license:
```
xcodebuild -license
```

Install the latest PHP
```
http://php-osx.liip.ch
```


Command line sublime text is more FTW
```
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/bin/subl
```

Applications
- Chrome
- Command Line Tools for XCode
- Dropbox
- ImageOptim
- iTerm 2
- Sequel Pro (http://www.sequelpro.com)
- VS Code
- TinyGrab
- Transmission
- MS Office
- Soulver
- UTM
- Zoom
- App Store
  - Pages
  - Numbers
  - Slack
  - 1Password
  - XCode


## Install Windows Developer VM
````
curl -s https://raw.githubusercontent.com/xdissent/ievms/master/ievms.sh | env IEVMS_VERSIONS="10" bash
````


Deprecated tools:
Command line coda (https://github.com/egonSchiele/Command-Line-Coda)
````
sudo gem install coda
````
