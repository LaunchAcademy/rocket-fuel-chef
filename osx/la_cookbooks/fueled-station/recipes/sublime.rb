include_package 'rocket-fuel::oh-my-zsh'

dmg_package 'Sublime Text' do
  volumes_dir 'Sublime Text'
  source 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%203059.dmg'
  action :install
end

link "/usr/local/bin/subl" do
  to "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"
end

template File.join(ENV['HOME'], 'Library/Application Support Sublime Text 3/Packages/User/Preferences.sublime-settings') do
  source "Preferences.sublime-settings.erb"
  owner node['current_user']
  action :create_if_missing
end

file File.join(ENV['HOME'], template ::File.join(ENV['HOME'], 'oh-my-zsh/custom/sublime.zsh') do
  contents 'export EDITOR="subl -w"'
  owner node['current_user']
  action :create_if_missing
end
