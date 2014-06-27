include_recipe 'homebrew'

homebrew_tap 'caskroom/cask'

package "brew-cask" do
  action :install
end

require "chef-sudo"
sudo 'fix cask regression' do
  command 'chown -R $USER:staff /opt/homebrew-cask'
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
