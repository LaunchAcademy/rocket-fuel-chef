include_recipe 'homebrew'

homebrew_tap 'caskroom/cask'

package "brew-cask" do
  action :install
end

#fix permissions regression
require "chef-sudo"
sudo 'fix cask regression' do
  user 'root'
  group 'wheel'
  command 'chown -R ' + node['current_user'] +':staff /opt/homebrew-cask'
end

dmg_package "Google Chrome Canary" do
  dmg_name "GoogleChromeCanary"
  source "https://storage.googleapis.com/chrome-canary/GoogleChromeCanary.dmg"
  action :install
  owner node['current_user']
end

homebrew_cask 'google-chrome'
homebrew_cask 'iterm2'
homebrew_cask 'dropbox'
homebrew_cask 'github'
homebrew_cask 'quicksilver'
homebrew_cask 'alfred'
homebrew_cask 'flowdock'
homebrew_cask 'flux'
homebrew_cask 'dash'
homebrew_cask 'gitx-rowanj'
homebrew_cask 'firefox'

package 'heroku-toolbelt'

package 'the_silver_searcher'
