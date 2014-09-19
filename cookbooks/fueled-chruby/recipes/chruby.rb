if platform_family?('mac_os_x')
  include_recipe 'homebrew'
  package 'chruby'
else
  chruby_path = "#{Chef::Config[:file_cache_path]}/chruby.tar.gz"
  version = '0.3.8'
  remote_file chruby_path do
    source "https://github.com/postmodern/chruby/archive/v#{version}.tar.gz"
    action :create_if_missing
  end

  execute 'extract chruby' do
    cwd Chef::Config[:file_cache_path]
    command "tar -xzvf #{chruby_path}"
  end

  execute 'install chruby' do
    user 'root'
    cwd File.join(Chef::Config[:file_cache_path], "chruby-#{version}")
    command "make install"
  end
end
