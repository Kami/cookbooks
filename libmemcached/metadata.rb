maintainer       "Tomaz Muraus"
maintainer_email "tomaz+cookbooks@tomaz.me"
license          "Apache 2.0"
description      "Install/Configure libmemcached"
version          "0.0.1"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))

supports "ubuntu"

%w{ build-essential }.each do |cb|
  depends cb
end

attribute "libmemcached/tarball_name",
  :display_name => "Tarball name",
  :description => "libmemcached tarball name",
  :default => "libmemcached-0.44.tar.gz"

attribute "libmemcached/tarball_url",
  :display_name => "Tarball URL",
  :description => "URL to the libmemcached tarball",
  :default => "http://launchpad.net/libmemcached/1.0/0.44/+download/libmemcached-0.44.tar.gz"

attribute "libmemcached/dirname",
  :display_name => "Directory name",
  :description => "Directory where the tarball gets extracted to",
  :default => "libmemcached-0.44"
