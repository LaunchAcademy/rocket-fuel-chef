if platform_family?('mac_os_x')
  link "/usr/local/bin/subl" do
    to File.join(ENV['HOME'], "Applications/Sublime Text.app/Contents/SharedSupport/bin/subl")
  end
else
  require 'chef-sudo'
  sudo 'link sublime' do
    user 'root'
    command 'ln -sf /opt/sublime_text_3/sublime_text /usr/bin/sublime'
  end

  sudo 'link subl' do
    user 'root'
    command 'ln -sf /opt/sublime_text_3/sublime_text /usr/bin/subl'
  end
end
