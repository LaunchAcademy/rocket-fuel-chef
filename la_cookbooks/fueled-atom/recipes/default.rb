include_recipe 'fueled-atom::install'
include_recipe 'fueled-atom::fix_perms'

include_recipe 'fueled-atom::rails'
include_recipe 'fueled-atom::colorpicker'
include_recipe 'fueled-atom::rails-rspec'

# include_recipe 'fueled-atom::linter'
include_recipe 'fueled-atom::linter-ruby'
include_recipe 'fueled-atom::linter-jshint'

if node['rocket-fuel']['editor'] == 'atom'
  include_recipe 'fueled-atom::zsh'
end
