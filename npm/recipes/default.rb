#
# Cookbook Name:: npm
# Recipe:: default
#
# Copyright 2011, Tomaz Muraus
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nodejs"

git "/tmp/npm-checkout" do
  repository "https://github.com/isaacs/npm.git"
  reference "#{node[:npm][:revision]}"
  action :checkout
  not_if { FileTest.exists?("/usr/local/bin/npm") }
end

bash "install_npm" do
  user "root"

  cwd "/tmp/npm-checkout"
  code <<-EOH
    make install
  EOH
  not_if { FileTest.exists?("/usr/local/bin/npm") }
end

bash "cleanup" do
  user "root"

  cwd "/tmp/"
  code <<-EOH
    rm -rf /tmp/npm-checkout
  EOH
  not_if { !FileTest.exists?("/tmp/npm-checkout") }
end
