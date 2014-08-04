windows_package 'GitHub' do
  source 'https://github-windows.s3.amazonaws.com/GitHubSetup.exe'
  installer_type :custom
  action :install
end
