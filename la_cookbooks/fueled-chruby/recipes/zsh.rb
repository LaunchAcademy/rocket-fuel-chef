chruby_zsh_path = ::File.expand_path(::File.join(ENV['HOME'],
  '.oh-my-zsh/custom/chruby.zsh'))
template chruby_zsh_path do
  source 'chruby.zsh.erb'
  owner node['current_user']
  action :create_if_missing
  only_if { FueledZsh.installed? }
end

#also source chruby.zsh so chef can make use of it in subsequent recipes
execute 'source chruby.zsh' do
  command "source #{chruby_zsh_path}"
  only_if { FueledZsh.installed? }
end

execute "chruby #{node['rocket-fuel']['chruby']['default-ruby']}" do
  only_if { FueledZsh.installed? }
end
