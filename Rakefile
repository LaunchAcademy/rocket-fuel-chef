def download(from, to, filename = from.split("/").last)
  require 'net/http'
  require 'uri'
  uri = URI.parse(from)
  path = File.join(to, filename)
  FileUtils.mkdir_p(to)
  if !FileTest.exists?(path)
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
  # task :prepare => [:fetch_prereqs, :vendorize_cookbooks, :extract_cookbooks]
  desc "prepare the windows installer"
  task :prepare => [:fetch_prereqs, :vendorize_cookbooks]

  desc "fetch windows prerequisites for building the installer"
  task :fetch_prereqs do
    download "https://opscode-omnibus-packages.s3.amazonaws.com/windows/2008r2/" +
      "x86_64/chef-windows-11.16.0-1.windows.msi", vendor_path
  end

  def tar_path
    File.join(tar_dir, 'cookbooks.tar.gz')
  end

  def tar_dir
    File.join(File.dirname(__FILE__), 'la_cookbooks/fueled-windows-station/resources/vendor/')
  end

  desc "vendor cookbooks into the vendor directory for the installer"
  task :vendorize_cookbooks do
    `bundle exec librarian-chef install`

    `tar -pczf #{tar_path} cookbooks`
  end

  desc "extract cookbooks"
  task :extract_cookbooks do
    `cd #{tar_dir} && tar -xvf #{tar_path}`
  end

  desc "vendor cookbooks into the vendor directory for the installer"
  task :vendorize_cookbooks do
    `bundle exec librarian-chef install`
    tar_path = File.join(File.dirname(__FILE__), 'la_cookbooks/fueled-windows-station/resources/vendor/cookbooks.tar.gz')
    `rm -rf #{tar_path}`
    `rm -rf #{tar_path.gsub("tar.gz", "")}`
    `tar -pczf #{tar_path} cookbooks`
  end
end
