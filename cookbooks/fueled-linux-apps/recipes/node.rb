commands = [
  'curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash',
  'source ~/.nvm/nvm.sh',
  'nvm install v5'
]
nvm_path = File.join(File.join(ENV['HOME'], '.nvm'))
execute "install node" do
  command commands.join(" && ")
  not_if { Dir.exist?(nvm_path) }
end
