script "oh-my-zsh install from github" do
  interpreter "bash"
  url = https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh
  code <<-EOS
    curl -sLf #{url} -o - | sh
    chsh -s /bin/zsh
  EOS
  not_if { File.directory? "#{ENV['HOME']}/.oh-my-zsh" }
end
