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
  nvm install v5
  SCRIPT
end
