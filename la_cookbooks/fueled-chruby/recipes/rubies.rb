#install desired ruby versions
node['rocket-fuel']['chruby']['rubies'].each do |vm, versions|
  versions.each do |version|
    ruby_path = "/opt/rubies/#{[vm, version].join('-')}"
    execute "install ruby #{vm}: #{version}" do
      command "ruby-install #{vm} #{version} -i #{ruby_path}"
      not_if { Dir.exist?(ruby_path) }
    end
  end
end
