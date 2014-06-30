#TODO: fix recursive directory
mkdir_p File.join(ENV['HOME'], 'Library/Application Support/Sublime Text 3/Packages/User') do
  owner node['current_user']
  action :create
end

template File.join(ENV['HOME'], 'Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings') do
  source "Preferences.sublime-settings.erb"
  owner node['current_user']
  action :create_if_missing
end
