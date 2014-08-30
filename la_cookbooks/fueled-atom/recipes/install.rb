if platform_family?('mac_os_x')
  include_recipe 'fueled-osx-applications::cask'
  homebrew_cask 'atom'  
end
