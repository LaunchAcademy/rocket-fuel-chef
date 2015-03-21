include_recipe 'fueled-osx-apps::homebrew'

homebrew_tap 'caskroom/cask'

package "brew-cask" do
  action :install
end

#fix permissions regression
mkdir_p '/opt/homebrew-cask/CaskRoom' do
  owner ENV['SUDO_USER'] || node['current_user']
  action :create
end

app_dir = "/Applications"

mkdir_p app_dir do
  owner ENV['SUDO_USER'] || node['current_user']
  action :create
end

cask_opts = "--appdir=/Applications"

execute 'set cask opts' do
  command "export HOMEBREW_CASK_OPTS=\"#{cask_opts}\""
end

file ::File.join(ENV['HOME'], '.oh-my-zsh/custom/cask.zsh') do
  content 'export HOMEBREW_CASK_OPTS="--appdir=/Applications"'
  owner ENV['SUDO_USER'] || node['current_user']
  action :create_if_missing
  only_if { FueledZsh.installed? }
end

execute 'fix caskroom regression' do
  command 'chown -R ' + (ENV['SUDO_USER'] || node['current_user']) +
    ' /opt/homebrew-cask/CaskRoom'
end

