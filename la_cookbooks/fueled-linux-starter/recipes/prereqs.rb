include_recipe 'apt'
include_recipe 'build-essential'

apt_package 'openssl'
apt_package 'curl'

# figure out how to not be exceptional about these packages
# [
#   'ruby',
#   'libruby1.8',
#   'ruby1.8',
#   'ruby1.8-dev',
#   'rubygems1.8'
# ].each do |pkg_to_remove|
#   apt_package pkg_to_remove do
#     action :remove
#   end
# end

[
  'ruby',
  'ruby-dev',
  'libruby'
].each do |r|
  apt_package r
end
