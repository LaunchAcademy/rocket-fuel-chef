dmg_package 'Command Line Developer Tools' do
  type 'pkg'
  dmg_name 'command-line-tools'
  volumes_dir 'Command Line Tools (Mountain Lion)'
  app 'Command Line Tools (Mountain Lion)'
  accept_eula true
  action :install
  if { FueledOsxBuildTools::OsCheck.new.os == '10.8' }
end
