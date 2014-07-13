require File.expand_path(File.join(File.dirname(__FILE__),
  '/../la_cookbooks/fueled-osx-build-tools/libraries/fueled_osx_build_tools'))

dmg_path = FueledOsxBuildTools::DownloadRoutine.new.run
FueledOsxBuildTools::CltInstaller.new(dmg_path).install
