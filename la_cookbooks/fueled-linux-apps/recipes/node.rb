nvm_path = File.join(File.join(ENV['HOME'], '.nvm'))

execute 'install nvm' do
  command 'curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash'
  not_if { Dir.exist?(nvm_path) }
end

execute 'source nvm' do
  command '. ~/.nvm/nvm.sh'
end

script 'install node via nvm' do
  interpreter 'bash'
  code <<-SCRIPT
  source #{File.join(nvm_path, 'nvm.sh')}
  nvm install v7
  SCRIPT
end

file ::File.join(ENV['HOME'], '.oh-my-zsh', 'custom', 'nvm.zsh') do
  content "source #{File.join(nvm_path, 'nvm.sh')}"
  owner ENV['SUDO_USER'] || node['current_user']
  action :create_if_missing
  only_if { FueledZsh.installed? }
end

execute 'install yarn' do
  command "source #{File.join(nvm_path, 'nvm.sh')} && npm install -g yarn"
end
