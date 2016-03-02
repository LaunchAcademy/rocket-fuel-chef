# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "hashicorp/precise32"
  config.omnibus.chef_version = :latest

  config.vm.provision "chef_solo" do |chef|
    chef.log_level = :debug
    chef.add_recipe "fueled-linux-starter"
    chef.add_recipe "fueled-linux-starter::prereqs"

    # chef.arguments = '-u vagrant'
    chef.json = {
      "authorization" => {
        'sudo' => {
          'agent_forwarding' => true,
          'groups' => ["admin", "wheel", "sysadmin"],
          'users' => ["vagrant"],
          'passwordless' => true
        }
      }
    }
  end

  # config.vm.provision :shell, :inline => "sudo gem install rocket_fuel && sudo -u vagrant rocket_fuel install"
  #forward default rails port
  config.vm.network :forwarded_port, guest: 3000, host: 3000

  # config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.synced_folder File.join(ENV['HOME'], 'rocket_fuel'), '/rocket_fuel', create: true


end
