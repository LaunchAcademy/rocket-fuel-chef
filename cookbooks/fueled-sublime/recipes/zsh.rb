file File.join(ENV['HOME'], '.oh-my-zsh/custom/sublime.zsh') do
  owner node['current_user']
  content 'export EDITOR="subl -w"'
  owner node['current_user']
  action :create_if_missing
  only_if { FueledZsh.installed? }
end
