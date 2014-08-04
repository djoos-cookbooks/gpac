#
# Cookbook Name:: gpac
# Recipe:: package
#
# Copyright 2012-2014, Escape Studios
#

gpac_packages.each do |pkg|
  package pkg do
    action :upgrade
  end
end
