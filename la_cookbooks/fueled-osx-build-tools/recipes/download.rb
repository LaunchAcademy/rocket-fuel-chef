ruby_block "download CLT" do
  block do
    file_name = FueledOsxBuildTools::Download::FILE_NAME
    path = File.join(Chef::Config[:file_cache_path], file_name)
    if !File.exists?(path)
      FueledOsxBuildTools::Download.interactive(path)
    end
  end
end

file File.join(Chef::Config[:file_cache_path], FueledOsxBuildTools::Download::FILE_NAME) do
  owner node['current_user']
  action :touch
end
