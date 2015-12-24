apt_repository 'precise-pgdg' do
 uri        'http://apt.postgresql.org/pub/repos/apt/'
 components ['main']
end

package 'postgresql-9.4'
package 'postgresql-contrib-9.4'

 # create new postgres user
execute "create new postgres user" do
  user "postgres"
  command "psql -c \"create user vagrant WITH SUPERUSER;\""
  not_if { `sudo -u postgres psql -tAc \"SELECT * FROM pg_roles WHERE rolname='vagrant'\" | wc -l`.chomp == "1" }
end
