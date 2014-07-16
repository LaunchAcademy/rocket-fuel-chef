user node['current_user'] do
  action :modify
  shell '/bin/zsh'
end

require 'chef-sudo'
zshrc_path = File.join(ENV['HOME'], '.zshrc')
sudo 'ensure .zshrc has correct owner' do
  command 'chown $USER #{zshrc_path}'
  only_if { FileTest.exists?(zshrc_path) }
end
