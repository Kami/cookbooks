maintainer       "Tomaz Muraus"
maintainer_email "tomaz+cookbooks@tomaz.me"
license          "Apache 2.0"
description      "Installs/Configures keyczar"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

supports "ubuntu"

%w{ build-essential swig }.each do |cb|
  depends cb
end