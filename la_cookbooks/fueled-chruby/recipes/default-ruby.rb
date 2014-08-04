#don't install rdoc or ri documentation
file ::File.join(ENV['HOME'], '.ruby-version') do
  content node['rocket-fuel']['chruby']['default-ruby']
  owner node['current_user']
  action :create_if_missing
end
