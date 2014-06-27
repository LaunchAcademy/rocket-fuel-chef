dmg_package 'Google Chrome' do
  dmg_name 'googlechrome'
  source   'https://dl-ssl.google.com/chrome/mac/stable/GGRM/googlechrome.dmg'
  action   :install
end

dmg_package "Google Chrome Canary" do
  dmg_name "GoogleChromeCanary"
  source "https://storage.googleapis.com/chrome-canary/GoogleChromeCanary.dmg"
  action :install
  owner node['current_user']
end

dmg_package 'Dropbox' do
  volumes_dir 'Dropbox Installer'
  source      'http://www.dropbox.com/download?plat=mac'
  checksum    'b4ea620ca22b0517b75753283ceb82326aca8bc3c86212fbf725de6446a96a13'
  action      :install
end

#GitHub for Mac
#https://central.github.com/mac/latest
github_path = Chef::Config[:file_cache_path] + "/github.zip"
remote_file github_path do
  source "https://central.github.com/mac/latest"
  mode "0644"
end

execute "install github client" do
  cwd Chef::Config[:file_cache_path]
  command "unzip " + github_path
  command "mv GitHub.app /Applications"
end

#iTerm2
#http://www.iterm2.com/downloads/stable/iTerm2_v1_0_0.zip
i_term_path = Chef::Config[:file_cache_path] + "/iterm2.zip"

remote_file i_term_path do
  source "http://www.iterm2.com/downloads/stable/iTerm2_v1_0_0.zip"
  mode "0644"
end

execute "install iterm" do
  cwd Chef::Config[:file_cache_path]
  command "unzip " + i_term_path
  command "mv iTerm.app /Applications"
require "chef-sudo"
sudo 'fix cask regression' do
  command 'chown -R $USER:staff /opt/homebrew-cask'
end

#quicksilver
dmg_package 'Quicksilver' do
  volumes_dir 'Quicksilver'
  source 'http://cdn.qsapp.com/plugins/files/com.blacktree.Quicksilver__16391.dmg'
  action :install
end

homebrew_cask 'flowdock'
