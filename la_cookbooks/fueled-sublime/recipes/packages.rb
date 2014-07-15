require 'uri'

package_control_name = "Package Control.sublime-package"
support_root = File.join(ENV['HOME'], '.config', 'sublime-text-3')
if platform_family?('mac_os_x')
  support_root = File.join(ENV['HOME'], '/Library/Application Support/Sublime Text 3/')
end
package_root = File.join(support_root, "Installed Packages")
user_package_prefs = File.join(support_root, 'Packages/User/')

mkdir_p support_root do
  owner node['current_user']
  action :create
end

mkdir_p package_root do
  owner node['current_user']
  action :create
end

require "chef-sudo"
sudo 'ensure ownership of the sublime support root' do
  user 'root'
  group 'wheel'
  command 'chown -R ' + node['current_user'] +':staff "' + support_root + '"'
end

remote_file File.join(package_root, package_control_name) do
  source "http://sublime.wbond.net/#{URI.encode(package_control_name)}"
  owner node['current_user']
  action :create_if_missing
end

mkdir_p user_package_prefs do
  owner node['current_user']
  action :create
end

template File.join(user_package_prefs, 'Package Control.sublime-settings') do
  source 'Package Control.sublime-settings.erb'
  owner node['current_user']
  action :create_if_missing
end
