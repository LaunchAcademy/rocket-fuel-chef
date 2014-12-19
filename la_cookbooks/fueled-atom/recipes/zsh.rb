file File.join(ENV['HOME'], '.oh-my-zsh/custom/atom.zsh') do
  owner ENV['SUDO_USER'] || node['current_user']
  content 'export EDITOR="atom"'
  action :create_if_missing
  only_if { FueledZsh.installed? }
end
