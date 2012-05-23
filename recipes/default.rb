#
# Cookbook Name:: chef-gpac
# Recipe:: default
#
# Copyright 2012, Escape Studios
#

#install dependencies
node[:gpac][:dependencies].each do |pkg|
	package pkg do
		action :upgrade
	end
end

case node[:gpac][:install_method]
	when :source
		include_recipe "chef-gpac::source"
	when :package
		include_recipe "chef-gpac::package"
end