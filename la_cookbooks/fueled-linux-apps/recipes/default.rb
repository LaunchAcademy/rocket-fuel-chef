include_recipe 'apt'

include_recipe 'fueled-linux-apps::vim'

include_recipe 'fueled-linux-apps::chrome'

#dropbox install hangs - leave out for now
#include_recipe 'fueled-linux-apps::dropbox'

include_recipe 'fueled-linux-apps::firefox'
include_recipe 'fueled-linux-apps::heroku-toolbelt'
include_recipe 'fueled-linux-apps::node'
include_recipe 'fueled-linux-apps::git'
