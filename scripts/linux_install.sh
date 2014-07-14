download_rocket_fuel(){
  cd /tmp
  rm -rf /tmp/rocket-fuel-master
  curl -LOk https://github.com/LaunchAcademy/rocket-fuel/archive/master.zip
  unzip master.zip -d /tmp/
  cd /tmp/rocket-fuel-master
}

sudo apt-get install curl

# download_rocket_fuel

#Chef omnibus
curl -L https://www.opscode.com/chef/install.sh | sudo bash

knife cookbook site download build-essential
tar zxf build-essential*.tar.gz -C la_cookbooks

knife cookbook site download apt
tar zxf apt*.tar.gz -C la_cookbooks

sudo chef-solo -c la_cookbooks/fueled-linux-station/config.rb -j la_cookbooks/fueled-linux-station/roles/default.json

librarian-chef install
