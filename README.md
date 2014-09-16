# Rocket Fuel for Mac OSX

Use this to get all of your applications installed and optimized for web development with Ruby on Rails.

From the command line:
`curl https://raw.githubusercontent.com/LaunchAcademy/rocket-fuel/master/scripts/mac_install.sh | bash`

Tested via http://grahamgilbert.com/blog/2013/08/23/creating-an-os-x-base-box-for-vagrant-with-packer/


### Default OSX Configuration Will Install:

* [chruby](https://github.com/postmodern/chruby)
* [ruby-install](https://github.com/postmodern/ruby-install)
* [oh-my-zsh](http://ohmyz.sh/)
* [Homebrew](http://brew.sh/)
* [Cask](http://caskroom.io/)
* [Sublime Text 3](http://www.sublimetext.com/3)
* [iTerm2](http://www.iterm2.com/#/section/home)
* [Heroku Toolbelt](https://toolbelt.heroku.com/)
* [Chrome](https://www.google.com/intl/en-US/chrome/browser/)
* [Dash](http://kapeli.com/dash)
* [Dropbox](https://www.dropbox.com/)
* [Firefox](http://www.mozilla.org/en-US/firefox/new/)
* [Github](https://mac.github.com/)
* [Alfred](http://www.alfredapp.com/)
* [Quicksilver](http://qsapp.com/)
* [Rowanj's Gitx](http://rowanj.github.io/gitx/)
* [Node](http://nodejs.org/)

### Rubies that are installed

* 2.1.2 (default)
* 2.0.0
* 1.9.3

### Other Configuration

* The default settings will create an SSH key for you if you haven't already generated one.
* The default ZSH theme is configured as `re5et`. This can easily be changed in `~/.zshrc` via the `ZSH_THEME` environment variable
* ZSH utility scripts are added to `~/.oh-my-zsh/custom`
* A ZSH utility script is created to make Sublime Text the default editor
* A ZSH utility script is created to make the `chruby` command functional
