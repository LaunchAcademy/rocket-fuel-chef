include_recipe 'fueled-osx-applications::homebrew'

homebrew_tap 'caskroom/cask'

package "brew-cask" do
  action :install
end

#fix permissions regression
mkdir_p '/opt/homebrew-cask' do
  owner node['current_user']
  action :create
end

require "chef-sudo"
sudo 'fix cask regression' do
  user 'root'
  group 'wheel'
  command 'chown -R ' + node['current_user'] +':staff /opt/homebrew-cask'
end
