file File.join(ENV['HOME'], '.oh-my-zsh/custom/atom.zsh') do
  owner node['current_user']
  content 'export EDITOR="atom"'
  owner node['current_user']
  action :create_if_missing
  only_if { FueledZsh.installed? }
end
