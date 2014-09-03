if platform_family?('mac_os_x')
  include_recipe 'fueled-osx-applications::cask'
  homebrew_cask 'atom'
else
  include_recipe 'apt'
  include_recipe 'build-essential'

  include_recipe 'fueled-linux-apps::node'
  include_recipe 'fueled-linux-apps::git'

  package 'libgnome-keyring-dev'
  package 'unzip'

  atom_archive_path = File.join(Chef::Config[:file_cache_path], 'atom.zip')
  remote_file atom_archive_path do
    #TODO: fetch latest tag (use the GitHub release API)
    source 'https://github.com/atom/atom/archive/master.tar.gz'
    owner node['current_user']
  end

  execute "extract atom" do
    cwd Chef::Config[:file_cache_path]
    command "tar xvfz #{atom_archive_path}"
  end

  atom_dir = File.join(Chef::Config[:file_cache_path], 'atom-master')

  execute "install atom" do
    cwd atom_dir
    command './script/build'
  end

  require 'chef-sudo'
  sudo 'install atom binaries/scripts' do
    user 'root'
    cwd atom_dir
    command "./script/grunt install"
  end
end
