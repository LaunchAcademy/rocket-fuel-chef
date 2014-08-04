windows_package 'Firefox' do
  source 'https://download-installer.cdn.mozilla.net/pub/firefox/releases/31.0/win32/en-US/Firefox%20Setup%2031.0.exe'
  options '-ms'
  installer_type :custom
  action :install
end

