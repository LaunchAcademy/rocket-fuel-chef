class Chef::Recipe
  def mkdir_p(directory, &block)
    directories = directory.split("/")
    directories.each_with_index do |dir, index|
      path = File.join(directories[0..index])
      if dir != '' && !FileTest.exists?(path)
        directory(path, &block)
      end
    end
  end
end
