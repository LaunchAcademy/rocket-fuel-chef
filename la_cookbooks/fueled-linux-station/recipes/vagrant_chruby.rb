file ::File.join('/vagrant/.ruby-version') do
  content node['rocket-fuel']['chruby']['default_ruby']
  owner ENV['SUDO_USER'] || node['current_user']
  action :create_if_missing
end
