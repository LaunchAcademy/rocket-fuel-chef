execute 'gem install rails' do
  only_if { FueledZsh.installed? || platform_family?('windows') }
end
