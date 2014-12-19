#don't install rdoc or ri documentation
file ::File.join(ENV['HOME'], '.gemrc') do
  content "gem: --no-rdoc --no-ri"
  owner env['SUDO_USER'] || node['current_user']
  action :create_if_missing
end
