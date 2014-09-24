execute 'gem install rails' do
  only_if { platform_family?('windows') }
end
