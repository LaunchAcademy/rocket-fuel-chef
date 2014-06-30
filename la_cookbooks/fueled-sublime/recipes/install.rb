dmg_package 'Sublime Text' do
  volumes_dir 'Sublime Text'
  destination File.join(ENV['HOME'], 'Applications')
  source 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%203059.dmg'
  action :install
end
