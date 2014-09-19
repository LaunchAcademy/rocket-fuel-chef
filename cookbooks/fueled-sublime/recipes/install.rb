if platform_family?('mac_os_x')
  dmg_package 'Sublime Text' do
    volumes_dir 'Sublime Text'
    destination File.join(ENV['HOME'], 'Applications')
    source 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%203059.dmg'
    action :install
  end
elsif platform_family?('windows')
  windows_package 'Sublime' do
    source 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%203059%20Setup.exe'
  end
else
  sublime_archive_path = File.join(Chef::Config[:file_cache_path], 'sublime.tar.bz2')
  remote_file sublime_archive_path do
    source 'http://c758482.r82.cf2.rackcdn.com/sublime_text_3_build_3059_x32.tar.bz2'
    owner node['current_user']
  end

  execute "extract sublime text 3" do
    cwd Chef::Config[:file_cache_path]
    command "tar xjvf #{sublime_archive_path}"
  end

  require 'chef-sudo'
  sudo 'move sublime text 3' do
    user 'root'
    command "mv #{File.join(Chef::Config[:file_cache_path], 'sublime_text_3')} /opt/"
    only_if { !FileTest.exists?('/opt/sublime_text_3') }
  end

  template '/usr/share/applications/sublime.desktop' do
    source 'sublime_text.desktop.erb'
    action :create_if_missing
  end
end
