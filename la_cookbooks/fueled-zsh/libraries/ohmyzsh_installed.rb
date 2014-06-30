class Chef::Recipe
  def ohmyzsh_installed?
    FileTest.exists?(File.join(ENV['HOME'], '.oh-my-zsh'))
  end
end
