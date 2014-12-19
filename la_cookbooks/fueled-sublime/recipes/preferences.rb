support_root = File.join(ENV['HOME'], '.config', 'sublime-text-3')
if platform_family?('mac_os_x')
  support_root = File.join(ENV['HOME'], '/Library/Application Support/Sublime Text 3/')
elsif platform_family?('windows')
  support_root = File.join(ENV['USERPROFILE'], '/AppData/Roaming/Sublime Text 3/')
end

#TODO: fix recursive directory
mkdir_p File.join(support_root, 'Packages/User') do
  owner ENV['SUDO_USER'] || node['current_user']
  action :create
end

template File.join(support_root, 'Packages/User/Preferences.sublime-settings') do
  source "Preferences.sublime-settings.erb"
  owner ENV['SUDO_USER'] || node['current_user']
  action :create_if_missing
end

execute 'ensure ownership of the sublime support root' do
  command 'chown -R ' + (ENV['SUDO_USER'] || node['current_user']) +':staff "' + support_root + '"'
  not_if { platform_family?('windows')}
end
