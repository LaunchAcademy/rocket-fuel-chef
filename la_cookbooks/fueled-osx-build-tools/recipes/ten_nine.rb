dmg_package 'Command Line Developer Tools' do
  type 'pkg'
  dmg_name 'command-line-tools'
  volumes_dir 'Command Line Developer Tools'
  app 'Command Line Tools (OS X 10.9)'
  accept_eula true
  action :install
  only_if { FueledOsxBuildTools::OsCheck.new.os == '10.9' }
end
