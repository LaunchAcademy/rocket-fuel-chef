#!/usr/bin/env bash

detect_osx_version() {
  OSX_VERSION=`sw_vers -productVersion`
}

find_clt() {
  if [[ $OSX_VERSION =~ "10.9" ]]; then
    RECEIPT_FILE=/var/db/receipts/com.apple.pkg.CLTools_Executables.bom
  else
    RECEIPT_FILE=/var/db/receipts/com.apple.pkg.DeveloperToolsCLI.bom
  fi

  echo $RECEIPT_FILE
  if [ -f "$RECEIPT_FILE" ]; then
    echo "Command Line Tools found"
    CLT_INSTALLED=true
  else
    echo "Command Line Tools NOT found"
    CLT_INSTALLED=false
  fi
}

download_rocket_fuel(){
  cd /tmp
  rm -rf /tmp/rocket-fuel-master
  curl -LOk https://github.com/LaunchAcademy/rocket-fuel-chef/archive/master.zip
  unzip master.zip -d /tmp/
  cd /tmp/rocket-fuel-chef-master
}

prep_chef(){
  cd /tmp/rocket-fuel-chef-master
  curl -L https://www.getchef.com/chef/install.sh | sudo bash
}

linux_install(){
  sudo apt-get install curl unzip -y

  download_rocket_fuel

  #Chef omnibus
  curl -L https://www.opscode.com/chef/install.sh | sudo bash

  knife cookbook site download build-essential
  tar zxf build-essential*.tar.gz -C la_cookbooks

  knife cookbook site download apt
  tar zxf apt*.tar.gz -C la_cookbooks

  sudo mkdir -p /var/chef
  sudo chown -R $USER /var/chef

  sudo chef-solo -c la_cookbooks/fueled-linux-starter/config.rb -j la_cookbooks/fueled-linux-starter/roles/default.json

  sudo gem install bundler
  bundle install

  soloist run_recipe fueled-linux-station
}

mac_install(){
  detect_osx_version
  find_clt
  download_rocket_fuel

  if [ $CLT_INSTALLED != true ]; then
    ruby /tmp/rocket-fuel-chef-master/scripts/command_line_tools.rb
  fi

  prep_chef

  echo "Installing fueled-osx-station..."
  chef-solo -c cookbooks/fueled-osx-station/config.rb -j cookbooks/fueled-osx-station/roles/default.json
}

detect_platform(){
  platform='unknown'
  unamestr=`uname`
  if [[ "$unamestr" == 'Darwin' ]]; then
    platform='mac'
  else
    platform='linux'
  fi
}

detect_platform
if [[ $platform == 'mac' ]]; then
  mac_install
else
  linux_install
fi
