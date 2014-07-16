support_root = File.join(ENV['HOME'], '.config', 'sublime-text-3')
if platform_family?('mac_os_x')
  support_root = File.join(ENV['HOME'], '/Library/Application Support/Sublime Text 3/')
end

#TODO: fix recursive directory
mkdir_p File.join(support_root, 'Packages/User') do
  owner node['current_user']
  action :create
end

template File.join(support_root, 'Packages/User/Preferences.sublime-settings') do
  source "Preferences.sublime-settings.erb"
  owner node['current_user']
  action :create_if_missing
end

require "chef-sudo"
sudo 'ensure ownership of the sublime support root' do
  user 'root'
  command 'chown -R ' + node['current_user'] +':staff "' + support_root + '"'
end
