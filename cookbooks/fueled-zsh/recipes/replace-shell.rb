user node['current_user'] do
  action :modify
  shell '/bin/zsh'
end

zshrc_path = File.join(ENV['HOME'], '.zshrc')
execute 'ensure .zshrc has correct owner' do
  command "chown " + ENV['SUDO_USER'] || node['current_user'] + " #{zshrc_path}"
  only_if { FileTest.exists?(zshrc_path) }
end
