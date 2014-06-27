include_recipe 'homebrew'
include_recipe 'fueled-station::oh-my-zsh'

package 'chruby'
package 'ruby-install'
package 'openssl'

#install desired ruby versions
node['rocket-fuel']['chruby']['rubies'].each do |vm, versions|
  versions.each do |version|
    execute "install ruby #{vm}: #{version}" do
      command "ruby-install #{vm} #{version}"
      not_if { Dir.exist?(File.join(ENV['HOME']), [vm, version].join('-')) }
    end
  end
end

#set default ruby version
file ::File.join(ENV['HOME'], '.ruby-version') do
  content node['rocket-fuel']['chruby']['default_ruby']
  user node['current_user']
  action :create_if_missing
end

#don't install rdoc or ri documentation
file ::File.join(ENV['HOME'], '.gemrc') do
  content "gem: --no-rdoc --no-ri"
  user node['current_user']
  action :create_if_missing
end

template ::File.join(ENV['HOME'], 'oh-my-zsh/custom/chruby.zsh') do
  source 'chruby.zsh.erb'
  owner node['current_user']
  action :create_if_missing
end
