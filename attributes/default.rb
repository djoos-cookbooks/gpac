#
# Cookbook Name:: chef-gpac
# Attributes:: default
#
# Copyright 2012, Escape Studios
#

default[:gpac][:install_method] = :source
default[:gpac][:prefix] = "/usr/local"
default[:gpac][:svn_repository] = "https://gpac.svn.sourceforge.net/svnroot/gpac/trunk/gpac"
default[:gpac][:svn_revision] = "HEAD"
default[:gpac][:compile_flags] = []