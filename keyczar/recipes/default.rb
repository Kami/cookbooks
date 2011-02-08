#
# Cookbook Name:: keyczar
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

remote_file "/tmp/#{node[:keyczar][:tarball_name]}" do
 source "#{node[:keyczar][:tarball_url]}"
 mode "0644"
end

execute "tar" do
 user "root"

 cwd "/tmp/"
 command "tar zxf #{node[:keyczar][:tarball_name]}"
 creates "/tmp/" + node[:keyczar][:dirname]
 action :run
end

bash "build keyczar" do
 user "vagrant"
 cwd "/tmp/#{node[:keyczar][:dirname]}"
 code <<-EOH
    cd src && sh ./tools/swtoolkit/hammer.sh --mode=opt-linux --compat
  EOH
 action :run
 not_if { FileTest.exists?("/usr/local/lib/libkeyczar.so") }
end

bash "install keyczar" do
 user "root"
 cwd "/tmp/#{node[:keyczar][:dirname]}"
 code <<-EOH
    cd src && sh ./tools/swtoolkit/hammer.sh --mode=opt-linux --compat install
  EOH
 action :run
 not_if { FileTest.exists?("/usr/local/lib/libkeyczar.so") }
end
