#
# Cookbook Name:: libmemcached
# Recipe:: default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "build-essential"

remote_file "/tmp/#{node[:libmemcached][:tarball_name]}" do
 source "#{node[:libmemcached][:tarball_url]}"
 mode "0644"
end

execute "tar" do
 user "root"

 cwd "/tmp/"
 command "tar zxf #{node[:libmemcached][:tarball_name]}"
 creates "/tmp/" + node[:libmemcached][:dirname]
 action :run
end


bash "install_libmemcached" do
  user "root"

  cwd "/tmp/" + node[:libmemcached][:dirname]
  code <<-EOH
    ./configure
    make install
  EOH
  not_if { FileTest.exists?("/usr/local/lib/libmemcached.so") }
end
