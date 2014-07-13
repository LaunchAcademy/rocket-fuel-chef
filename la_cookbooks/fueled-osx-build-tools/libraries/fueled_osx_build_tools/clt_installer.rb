module FueledOsxBuildTools
  class CltInstaller
    def initialize(dmg_path)
      @dmg_path = dmg_path
      @metadata = FueledOsxBuildTools::DmgMetadata.new(dmg_path)
    end

    def install
      puts "Mounting CLT volume..."
      `echo Y | PAGER=true hdiutil attach '#{@dmg_path}' -quiet `
      puts "Installing CLT..."
      `sudo installer -pkg '/Volumes/#{volumes_dir}/#{pkg_name}.pkg' -target /`
      puts "Detaching CLT volume..."
      `hdiutil detach '/Volumes/#{volumes_dir}' || hdiutil detach '/Volumes/#{volumes_dir}' -force`
    end

    protected
    def volumes_dir
      @metadata.volumes_dir
    end

    def pkg_name
      @metadata.pkg_name
    end
  end
end
