class Chef::Recipe
  def mkdir_p(directory, &block)
    directories = directory.split("/")
    directories.each_with_index do |dir, index|
      directory(File.join(directories[0..index], &block))
    end
  end
end
