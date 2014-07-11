require 'logger'

module FueledOsxBuildTools
  class Download
    URLS = {
      '10.9' => '/downloads/download.action?path=Developer_Tools/command_line_tools_os_x_mavericks_for_xcode__april_2014/command_line_tools_for_osx_mavericks_april_2014.dmg',
      '10.8' => '/downloads/download.action?path=Developer_Tools/command_line_tools_os_x_mountain_lion_for_xcode__april_2014/command_line_tools_for_osx_mountain_lion_april_2014.dmg',
      '10.7' => '/downloads/download.action?path=Developer_Tools/command_line_tools_os_x_lion_for_xcode__april_2013/xcode462_cltools_10_76938260a.dmg'
    }

    FILE_NAME = 'command-line-tools.dmg'
    DEFAULT_DMG_PATH = File.join(File.dirname(__FILE__),
      "./../tmp/#{FILE_NAME}")


    def initialize(destination = nil, drop_dir = nil)
      @destination = destination
      if !@destination.nil?
        #append the file name if supplied path is a directory
        if File.directory?(@destination)
          @destination += FILE_NAME
        end
      else
        @destination ||= DEFAULT_DMG_PATH
      end
    end

    def url
      base_host + URLS[FueledOsxBuildTools::OsCheck.new.os]
    end

    def basename
      URLS[FueledOsxBuildTools::OsCheck.new.os].match(/([^\/]*)\z/)[0]
    end

    protected
    def base_host
      'https://developer.apple.com'
    end
  end
end
