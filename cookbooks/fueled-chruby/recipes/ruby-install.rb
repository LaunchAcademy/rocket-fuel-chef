if platform_family?('mac_os_x')
  package 'openssl'
  package 'ruby-install'
else
  install_path = "#{Chef::Config[:file_cache_path]}/ruby-install.tar.gz"
  version = '0.4.3'
  remote_file install_path do
    source "https://github.com/postmodern/ruby-install/archive/v#{version}.tar.gz"
    action :create_if_missing
  end

  execute 'extract ruby-install' do
    command "tar -xzvf #{install_path}"
    cwd Chef::Config[:file_cache_path]
  end

  execute 'install ruby-install' do
    cwd File.join(Chef::Config[:file_cache_path], "ruby-install-#{version}")
    command "make install"
  end
end
