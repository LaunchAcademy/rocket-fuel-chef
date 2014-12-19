#don't install rdoc or ri documentation
file ::File.join(ENV['HOME'], '.gemrc') do
  content "gem: --no-rdoc --no-ri"
  owner ENV['SUDO_USER'] || node['current_user']
  action :create_if_missing
end
