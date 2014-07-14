if platform_family?('mac_os_x')
  package 'openssl'
  package 'ruby-install'
else
  install_path = "#{Chef::Config[:file_cache_path]}/ruby-install.tar.gz"
  remote_file chruby_path do
    source "https://github.com/postmodern/ruby-install/archive/v0.4.3.tar.gz"
    action :create_if_missing
  end

  execute 'extract ruby install' do
    command "tar -xzvf #{install_path}"
  end

  require 'chef-sudo'
  sudo 'install chruby' do
    user root
    command "cd #{Chef::Config[:file_cache_path]}/ruby-install* && make install"
  end
end
