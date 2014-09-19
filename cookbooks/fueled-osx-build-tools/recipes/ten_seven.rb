dmg_package 'Command Line Developer Tools' do
  type 'pkg'
  dmg_name 'command-line-tools'
  volumes_dir 'Command Line Tools (Lion)'
  app 'Command Line Tools (Lion)'
  accept_eula true
  action :install
  only_if { FueledOsxBuildTools::OsCheck.new.os == '10.7' }
end
