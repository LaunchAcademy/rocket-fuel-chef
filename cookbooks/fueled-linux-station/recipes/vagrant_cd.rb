cd_zsh_path = ::File.expand_path(::File.join(ENV['HOME'],
  '.oh-my-zsh/custom/cd_vagrant.zsh'))
file cd_zsh_path do
  content 'cd /vagrant'
  owner ENV['SUDO_USER'] || node['current_user']
  action :create_if_missing
  only_if { FueledZsh.installed? }
end
