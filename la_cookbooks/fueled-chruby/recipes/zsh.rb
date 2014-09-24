chruby_zsh_path = ::File.expand_path(::File.join(ENV['HOME'],
  '.oh-my-zsh/custom/chruby.zsh'))
template chruby_zsh_path do
  source 'chruby.zsh.erb'
  owner node['current_user']
  action :create_if_missing
  only_if { FueledZsh.installed? }
end
