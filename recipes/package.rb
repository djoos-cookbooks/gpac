#
# Cookbook Name:: chef-gpac
# Recipe:: package
#
# Copyright 2012, Escape Studios
#

gpac_packages.each do |pkg|
	package pkg do
		action :upgrade
	end
end