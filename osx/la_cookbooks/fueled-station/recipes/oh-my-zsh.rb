script "oh-my-zsh install from github" do
  interpreter "bash"
  url = "https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh"
  code <<-EOS
    curl -sLf #{url} -o - | sh
    chsh -s /bin/zsh
  EOS
  not_if { File.directory? "#{ENV['HOME']}/.oh-my-zsh" }
end

template ::File.join(ENV['HOME'], '.oh-my-zsh/custom/.oh-my-zsh.zsh') do
  source 'oh-my-zsh.zsh.erb'
  owner node['current_user']
  action :create_if_missing
  variables({ theme: node['rocket-fuel']['oh-my-zsh']['theme'] })
end

user node['current_user'] do
  action :modify
  shell '/bin/zsh'
end

