if platform_family?('ubuntu') || platform_family?('debian')
  chrome_installed = `which google-chrome`
  package 'curl'
  if chrome_installed.empty?
    execute 'add chrome install source key' do
      command 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -'
    end

    execute 'add chrome install source' do
      google_deb_source_file = '/etc/apt/sources.list.d/google.list'
      command "echo \"deb http://dl.google.com/linux/chrome/deb/ stable main\" >> #{google_deb_source_file}"
      not_if { FileTest.exists?( google_deb_source_file) }
    end

    execute 'apt-get update' do
      command 'apt-get update'
    end

    package 'google-chrome-stable'
  end
end
