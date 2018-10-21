#
# Cookbook:: lcd_basic
# Recipe:: default
#
# Copyright:: 2017, Student Name, All Rights Reserved.

include_recipe 'php::default'

package 'net-tools'
package 'apache2' if node['platform']=="ubuntu"
service 'httpd' do
  only_if { node['platform']=="centos" }
  action :start
end
service 'apache2' do
  only_if { node['platform']=="ubuntu" }
  action :start
end


group 'developers'

user 'webadmin' do
 group 'developers'
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
end
