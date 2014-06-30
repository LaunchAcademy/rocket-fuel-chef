user node['current_user'] do
  action :modify
  shell '/bin/zsh'
end
