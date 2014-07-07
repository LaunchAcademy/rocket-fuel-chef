module FueledZsh
  def self.installed?
    FileTest.exists?(File.join(ENV['HOME'], '.oh-my-zsh'))
  end
end
