module FueledOsxBuildTools
  class DmgMetadata
    def initialize(dmg_path)
      @dmg_path = dmg_path
      @os = FueledOsxBuildTools::OsCheck.new.os
    end

    def volumes_dir
      if map[@os]
        map[@os]['volumes_dir']
      end
    end

    def pkg_name
      if map[@os]
        map[@os]['pkg_name']
      end
    end

    protected
    def map
      @map ||= {
        '10.9' => {
          'volumes_dir' => 'Command Line Developer Tools',
          'pkg_name' => 'Command Line Tools (OS X 10.9)'
        },
        '10.8' => {
          'volumes_dir' => 'Command Line Tools (Mountain Lion)',
          'pkg_name' => 'Command Line Tools (Mountain Lion)'
        },
        '10.7' => {
          'volumes_dir' => 'Command Line Tools (Lion)',
          'pkg_name' => 'Command Line Tools (Lion)'
        }
      }
    end
  end
end
