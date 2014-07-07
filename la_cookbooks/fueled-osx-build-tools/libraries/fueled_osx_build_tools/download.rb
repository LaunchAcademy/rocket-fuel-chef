require 'mechanize'
require 'logger'
require 'io/console'

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


    def initialize(email, password, destination = nil)
      @destination = destination
      if !@destination.nil?
        #append the file name if supplied path is a directory
        if File.directory?(@destination)
          @destination += FILE_NAME
        end
      else
        @destination ||= DEFAULT_DMG_PATH
      end
      @email = email
      @password = password
    end

    def sign_in
      sign_in_page = agent.get 'https://developer.apple.com/downloads/'
      form = sign_in_page.form_with :name => 'form2'
      form.appleId = @email
      form.accountPassword = @password
      download_page = form.click_button
      noko_doc = Nokogiri::HTML.parse(download_page.body)
      result = noko_doc.css('.dserror').size == 0
      if result
        @state = :authenticated
      else
        @state = :invalid_credentials
      end

      @state == :authenticated
    end

    def retrieve
      sign_in unless @state == :authenticated
      puts "Downloading to #{@destination}"
      agent.download(url, @destination)
      return true
    end

    def url
      URLS[FueledOsxBuildTools::OsCheck.new.os]
    end

    class << self
      def interactive(download_path)
        STDOUT.puts "====CLT DOWNLOAD===="
        STDOUT.print "What is your Apple ID? "
        apple_id = STDIN.gets.chomp
        STDOUT.print "What is your Apple ID password? "
        password = STDIN.noecho(&:gets).chomp
        puts ""
        STDOUT.puts "===CLT Downloading...==="
        new(apple_id, password, download_path).retrieve
      end
    end

    protected
    def agent
      @agent ||= Mechanize.new.tap do |a|
        a.user_agent_alias = 'Mac Safari'
        # a.log = Logger.new "mech.log"
      end
    end
  end
end
