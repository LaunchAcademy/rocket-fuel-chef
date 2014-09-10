def download(from, to, filename = from.split("/").last)
  require 'net/http'
  require 'uri'
  uri = URI.parse(from)
  path = File.join(to, filename)
  if !FileTest.exists?
    Net::HTTP.start(uri.host) do |http|
      resp = http.get(uri.path)
      open(path, "wb") do |file|
        file.write(resp.body)
      end
    end
  end
end

vendor_path = File.join(File.dirname(__FILE__),
  'la_cookbooks/fueled-windows-station/resources/vendor')

namespace :win do
  desc "fetch windows prerequisites for building the installer"
  task :fetch_prereqs do
    download "https://opscode-omnibus-packages.s3.amazonaws.com/windows/2008r2/" +
      "x86_64/chef-windows-11.16.0-1.windows.msi", vendor_path
  end
end
