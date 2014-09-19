include_recipe 'fueled-sublime::install'
include_recipe 'fueled-sublime::cmd-line-shortcut'
include_recipe 'fueled-sublime::preferences'
include_recipe 'fueled-sublime::packages'

if node['rocket-fuel']['editor'] == 'sublime'
  include_recipe 'fueled-sublime::zsh'
end
