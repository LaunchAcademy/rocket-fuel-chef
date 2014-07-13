config_dir = File.join(ENV['HOME'], '/.ssh/config')
mkdir_p config_dir do
  owner node['current_user']
end

execute 'ensure current user owns the ssh folder' do
  command "chown -R #{node['current_user']} #{config_dir}"
end
