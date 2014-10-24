class Chef::Recipe
  def choco(package)
    execute "c:\\ProgramData\\chocolatey\\bin\\choco install #{package}"
  end
end
