apt_repository 'nodejs' do
  uri          'https://deb.nodesource.com/node'
  components   ['main']
  key          'https://deb.nodesource.com/gpgkey/nodesource.gpg.key'
end

package 'nodejs'
