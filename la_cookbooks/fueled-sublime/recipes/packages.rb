require 'uri'

package_control_name = "Package Control.sublime-package"
support_root = File.join(ENV['HOME'], '/Library/Application Support/Sublime Text 3/')
package_root = File.join(support_root, "Packages")

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

[
  'https://github.com/jisaacks/GitGutter.git',
  'https://github.com/titoBouzout/SideBarGit.git',
  'https://github.com/SublimeLinter/SublimeLinter.git'
].each do |pkg|
  git ::File.expand_path(File.basename(pkg, '.git'), package_root) do
    repository pkg
    user node['current_user']
    action :sync
  end
end
