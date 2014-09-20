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
  curl -LOk https://github.com/LaunchAcademy/rocket-fuel/archive/master.zip
  unzip master.zip -d /tmp/
  cd /tmp/rocket-fuel-master
}

prep_chef(){
  cd /tmp/rocket-fuel-master
  curl -L https://www.getchef.com/chef/install.sh | sudo bash
}

detect_osx_version
find_clt
download_rocket_fuel

if [ $CLT_INSTALLED != true ]; then
  ruby /tmp/rocket-fuel-master/scripts/command_line_tools.rb
fi

prep_chef

echo "Installing fueled-osx-station..."
chef-solo -c cookbooks/fueled-osx-station/config.rb -j cookbooks/fueled-osx-station/roles/default.json
