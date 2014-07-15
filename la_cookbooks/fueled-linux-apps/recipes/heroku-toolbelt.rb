execute 'install heroku toolbelt' do
  command '\curl -sSL https://toolbelt.heroku.com/install.sh | bash -s stable'
end

template File.join(ENV['HOME'], 'oh-my-zsh/custom/heroku-toolbelt.zsh') do
  source 'heroku-toolbelt.zsh.erb'
  owner node['current_user']
  action :create_if_missing
  only_if { FueledZsh.installed? }
end
