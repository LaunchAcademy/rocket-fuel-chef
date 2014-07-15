if platform_family?('ubuntu') || platform_family?('debian')
  file_url = ''
  if node['languages']['ruby']['target_cpu'] =~ /64/
    file_url = 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
  else
    file_url = 'https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb'
  end

  remote_file File.join(Chef::Config[:cache_path], 'chrome.deb')
    source file_url
  end

  require 'chef-sudo'
  sudo 'install chrome' do
    user 'root'
    command 'dpkg -i chrome.deb && apt-get -f install'
  end
end
