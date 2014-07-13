#!/bin/bash

detect_osx_version() {
  osx_version = `sw_vers -productVersion`
}

find_clt() {
  if [[ $result =~ "10.9" ]]; then
    RECEIPT_FILE=/var/db/receipts/com.apple.pkg.CLTools_Executables.bom
  else
    RECEIPT_FILE=/var/db/receipts/com.apple.pkg.DeveloperToolsCLI.bom
  fi

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
  sudo gem install bundler
  bundle
}

find_clt
download_rocket_fuel

if [ "$CLT_INSTALLED"=false ]; then
  ruby /tmp/rocket-fuel-master/scripts/command_line_tools.rb
fi

prep_chef

echo "Installing fueled-osx-station..."
bundle exec soloist run_recipe fueled-osx-station

