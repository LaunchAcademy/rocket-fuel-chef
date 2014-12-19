config_dir = File.join(ENV['HOME'], '/.ssh')
mkdir_p config_dir do
  owner ENV['SUDO_USER'] || node['current_user']
end

execute 'ensure current user owns the ssh folder' do
  command "chown -R #{ENV['SUDO_USER'] || node['current_user']} #{config_dir}"
end
