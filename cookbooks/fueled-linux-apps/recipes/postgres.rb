apt_repository 'precise-pgdg' do
 uri        'http://apt.postgresql.org/pub/repos/apt/'
 distribution 'precise-pgdg'
 trusted true
 components ['main']
end

package 'postgresql-9.4'
package 'postgresql-contrib-9.4'

 # create new postgres user
execute "create new postgres user" do
  user "postgres"
  command "psql -c \"create user #{ENV['SUDO_USER'] || node['current_user']} WITH SUPERUSER;\""
  not_if { `sudo -u postgres psql -tAc \"SELECT * FROM pg_roles WHERE rolname='#{ENV['SUDO_USER'] || node['current_user']}';\" | wc -l`.chomp == "1" }
end

execute "create new postgres database" do
  user "postgres"
  command "psql -c \"CREATE DATABASE vagrant WITH owner #{ENV['SUDO_USER'] || node['current_user']};\""
  not_if { `sudo -u postgres psql -tAc \"SELECT 1 FROM pg_database WHERE datname='#{ENV['SUDO_USER'] || node['current_user']}';\" | wc -l`.chomp == "1"}
end
