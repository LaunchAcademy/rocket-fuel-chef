# install nvm
include_recipe 'nvm'

# install node.js v0.10.5
nvm_install 'v5.7.0'  do
  from_source true
  alias_as_default true
  action :create
end
