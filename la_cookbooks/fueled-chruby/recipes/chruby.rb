if platform_family?('mac_os_x')
  include_recipe 'homebrew'
  package 'chruby'
else
  chruby_path = "#{Chef::Config[:file_cache_path]}/chruby.tar.gz"
  remote_file chruby_path do
    source "https://github.com/postmodern/chruby/archive/v0.3.8.tar.gz"
    action :create_if_missing
  end

  execute 'extract chruby' do
    command "tar -xzvf #{chruby_path}"
  end

  require 'chef-sudo'
  sudo 'install chruby' do
    user root
    command "cd #{Chef::Config[:file_cache_path]}/chruby* && make install"
  end
end
