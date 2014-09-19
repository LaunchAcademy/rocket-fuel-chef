module FueledOsxBuildTools
  class DownloadRoutine
    PREF_NAMESPACE = File.expand_path("#{ENV['HOME']}/Library/Preferences/com.apple.Safari")

    def initialize
      @script_path = File.join(File.dirname(__FILE__), '../../scripts/install.applescript')
      @download = FueledOsxBuildTools::Download.new
    end

    def run
      whitelist_downloads
      run_applescript
      await_download_completion
    end

    protected
    def whitelist_downloads
      #only do this once. We don't want the active download to get in the queue, so
      #we memoize
      @downloads ||= Dir.glob(downloading_glob)
    end

    def downloading_glob
      File.join(download_path, "*.download")
    end


    def download_path
      unless @download_path
        @download_path = `defaults read #{PREF_NAMESPACE} DownloadsPath`.chomp
        if @download_path == '' || @download_path.nil?
          @download_path = File.join(ENV["HOME"], "/Downloads")
        end

        @download_path = File.expand_path(@download_path)
      end
      @download_path
    end

    def run_applescript
      `osascript #{@script_path} "#{@download.url}"`
    end

    def download_url
      @download.url
    end

    def await_download_completion
      puts "Waiting for CLT download to finish..."
      sleep(5)

      cared_for_downloads = Dir.glob(downloading_glob) - whitelist_downloads
      puts "Ignoring #{whitelist_downloads}"
      puts "Watching #{cared_for_downloads}"
      #wait until all downloads have completed
      while (Dir.glob(downloading_glob) - whitelist_downloads).length > 0 do
        sleep(5)
      end
      puts "Download complete"

      cared_for_downloads.each do |d|
        dmg_file = d.gsub(/.download\z/, '')
        if FileTest.exists?(dmg_file) && File.extname(dmg_file) == '.dmg'
          return dmg_file
        end
      end
    end
  end
end
