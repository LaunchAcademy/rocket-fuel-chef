atom_root = File.join(ENV['HOME'], '.atom')

mkdir_p atom_root do
  owner ENV['SUDO_USER'] || node['current_user']
  action :create
end

execute 'ensure ownership of the atom root for preferences' do
  command 'chown -R ' + ENV['SUDO_USER'] || node['current_user'] +':staff "' + atom_root + '"'
  not_if { platform_family?('windows') }
end
