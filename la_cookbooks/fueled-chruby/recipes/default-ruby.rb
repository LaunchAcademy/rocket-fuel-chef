file ::File.join(ENV['HOME'], '.ruby-version') do
  content node['rocket-fuel']['chruby']['default-ruby']
  owner env['SUDO_USER'] || node['current_user']
  action :create_if_missing
end
