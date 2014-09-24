cd %1
PATH=C:\opscode\chef\bin;C:\opscode\chef\embedded\bin;%PATH%
c:\opscode\chef\bin\tar.exe zxf cookbooks.tar.gz
c:\opscode\chef\bin\chef-solo.bat -c cookbooks\fueled-windows-station\config.rb -j cookbooks\fueled-windows-station\roles\default.json
