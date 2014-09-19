module FueledOsxBuildTools
  class OsCheck
    def os
      `sw_vers -productVersion`.chomp.match(/^\d+\.\d+/).to_s
    end
  end
end
