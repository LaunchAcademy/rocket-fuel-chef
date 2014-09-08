homebrew_cask 'postgres'

#when you open postgres.app, it will ask to move to /Applications, so assume that
file File.join(ENV['HOME'], '.oh-my-zsh/custom/postgres.zsh') do
  owner node['current_user']
  content 'export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/9.3/bin"'
  owner node['current_user']
  action :create_if_missing
  only_if { FueledZsh.installed? }
end
