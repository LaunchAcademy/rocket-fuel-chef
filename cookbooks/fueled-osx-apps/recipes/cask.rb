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

app_dir = "#{ENV['HOME']}/Applications"

mkdir_p app_dir do
  owner ENV['SUDO_USER'] || node['current_user']
  action :create
end

execute 'fix caskroom regression' do
  command 'chown -R ' + ENV['SUDO_USER'] || node['current_user'] +
    ' /opt/homebrew-cask/CaskRoom'
end

execute 'fix ~/Applications perms' do
  command 'chown -R ' + ENV['SUDO_USER'] || node['current_user'] + ' ' + app_dir
end
