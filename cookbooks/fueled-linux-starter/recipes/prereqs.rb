include_recipe 'apt'
include_recipe 'build-essential'

apt_package 'openssl'

[
  'ruby',
  'libruby1.8',
  'ruby1.8',
  'ruby1.8-dev',
  'rubygems1.8'
].each do |pkg_to_remove|
  apt_package pkg_to_remove do
    action :remove
  end
end

[
  'ruby1.9.3',
  'rubygems1.9.1'
].each do |r|
  apt_package r
end
