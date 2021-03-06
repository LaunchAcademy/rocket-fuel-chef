homebrew_cask 'postgres'

#when you open postgres.app, it will ask to move to /Applications, so assume that
file File.join(ENV['HOME'], '.oh-my-zsh/custom/postgres.zsh') do
  owner ENV['SUDO_USER'] || node['current_user']
  content "export PATH=\"#{ENV['HOME']}/Applications/Postgres.app/Contents/Versions/9.4/bin\":$PATH"
  action :create_if_missing
  only_if { FueledZsh.installed? }
end
