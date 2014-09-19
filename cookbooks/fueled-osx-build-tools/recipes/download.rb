dmg_destination = File.join(Chef::Config[:file_cache_path], FueledOsxBuildTools::Download::FILE_NAME)
pref_namespace = File.expand_path("#{ENV['HOME']}/Library/Preferences/com.apple.Safari")

execute 'download CLT' do
  script_path = File.join(File.dirname(__FILE__), '../scripts/install.applescript')
  download_url = FueledOsxBuildTools::Download.new.url
  download_path = `defaults read #{pref_namespace} DownloadsPath`.chomp
  if download_path == '' || download_path.nil?
    download_path = File.join(ENV["HOME"], "/Downloads")
  end
  downloads = Dir.glob(File.join(download_path, "*.download"))
  node.set['fueled-osx-build-tools']['download-file-whitelist'] = Dir.glob(downloads)
  command "osascript #{script_path} \"#{download_url}\""
end

ruby_block "download CLT" do
  block do
    puts "Waiting for CLT download to finish..."
    sleep(2)

    download_path = `defaults read #{pref_namespace} DownloadsPath`.chomp
    if download_path == '' || download_path.nil?
      download_path = File.join(ENV["HOME"], "/Downloads")
    end
    downloading_glob = File.join(download_path, "*.download")
    downloads = Dir.glob(downloading_glob)
    whitelist = node['fueled-osx-build-tools']['download-file-whitelist']

    #wait until all downloads have completed
    while (Dir.glob(downloading_glob) - whitelist).length > 0 do
      sleep(5)
    end
    puts "Download complete"

    downloads.each do |d|
      dmg_file = d.gsub(/.download\z/, '')
      if FileTest.exists?(dmg_file)
        `mv #{dmg_file} #{dmg_destination}`
      end
    end
  end
end

file dmg_destination do
  owner node['current_user']
  action :touch
end
