#
# Cookbook Name:: chef-gpac
# Recipe:: source
#
# Copyright 2012, Escape Studios
#

include_recipe "build-essential"
include_recipe "subversion"

gpac_packages.each do |pkg|
	package pkg do
		action :purge
	end
end

zlib_package = value_for_platform(
	[ "ubuntu" ] => {
		"default" => "zlib1g-dev"
	},
	"default" => "zlib1g-dev"
)

package zlib_package do
	action :upgrade
end

subversion "gpac" do
	repository node[:gpac][:svn_repository]
	revision node[:gpac][:svn_revision]
	destination "#{node[:gpac][:svn_destination]}/gpac"
	action :sync
	notifies :run, "bash[compile_gpac]"
end

#Write the flags used to compile the application to disk. If the flags
#do not match those that are in the compiled_flags attribute - we recompile
template "#{node[:gpac][:svn_destination]}/gpac-compiled_with_flags" do
	source "compiled_with_flags.erb"
	owner "root"
	group "root"
	mode 0600
	variables(
		:compile_flags => node[:gpac][:compile_flags]
	)
	notifies :run, "bash[compile_gpac]"
end

bash "compile_gpac" do
	cwd "#{node[:gpac][:svn_destination]}/gpac"
	code <<-EOH
		./configure --prefix=#{node[:gpac][:prefix]} #{node[:gpac][:compile_flags].join(' ')}
		make clean && make && make install
	EOH
	creates "#{node[:gpac][:prefix]}/bin/gpac"
end