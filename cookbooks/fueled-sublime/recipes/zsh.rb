file File.join(ENV['HOME'], '.oh-my-zsh/custom/sublime.zsh') do
  content 'export EDITOR="subl -w"'
  owner ENV['SUDO_USER'] || node['current_user']
  action :create_if_missing
  only_if { FueledZsh.installed? }
end
