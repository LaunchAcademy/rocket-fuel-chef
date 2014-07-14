pub_to_check = File.join(ENV['HOME'], ".ssh/id_rsa")

execute 'create passwordless key' do
  command "ssh-keygen -b 2048 -t rsa -f #{pub_to_check} -q -N ''"
  only_if { !FileTest.exists?(pub_to_check)}
end
