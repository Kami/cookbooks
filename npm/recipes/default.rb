#
# Cookbook Name:: npm
# Recipe:: default
#
# Copyright 2011, Tomaz Muraus
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nodejs"

bash "install_npm" do
  user "root"

  cwd "/tmp/"
  code <<-EOH
    curl http://npmjs.org/install.sh | sh
  EOH
  not_if { FileTest.exists?("/usr/local/bin/npm") }
end
