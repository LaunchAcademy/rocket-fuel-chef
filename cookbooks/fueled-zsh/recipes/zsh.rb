package 'zsh' do
  only_if { node['platform_family'] != 'mac_os_x' }
end
