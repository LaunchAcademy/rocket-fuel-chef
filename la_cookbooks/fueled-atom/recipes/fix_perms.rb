require "chef-sudo"
atom_root = support_root = File.join(ENV['HOME'], '.atom')

mkdir_p atom_root do
  owner node['current_user']
  action :create
end

sudo 'ensure ownership of the atom root for preferences' do
  user 'root'
  command 'chown -R ' + node['current_user'] +':staff "' + atom_root + '"'
end
