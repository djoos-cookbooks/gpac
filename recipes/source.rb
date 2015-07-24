#
# Cookbook Name:: gpac
# Recipe:: source
#
# Copyright 2012-2015, Escape Studios
#

include_recipe 'build-essential'
include_recipe 'git'

gpac_packages.each do |pkg|
  package pkg do
    action :purge
    ignore_failure true
  end
end

creates = "#{node['gpac']['prefix']}/bin/MP4Box"

file creates do
  action :nothing
end

git "#{Chef::Config[:file_cache_path]}/gpac" do
  repository node['gpac']['git_repository']
  reference node['gpac']['git_revision']
  action :sync
  notifies :delete, "file[#{creates}]", :immediately
end

# write the flags used to compile to disk
template "#{Chef::Config[:file_cache_path]}/gpac-compiled_with_flags" do
  source 'compiled_with_flags.erb'
  owner 'root'
  group 'root'
  mode 0600
  variables(
    :compile_flags => node['gpac']['compile_flags']
  )
  notifies :delete, "file[#{creates}]", :immediately
end

bash 'compile_gpac' do
  cwd "#{Chef::Config[:file_cache_path]}/gpac"
  code <<-EOH
    ./configure --prefix=#{node['gpac']['prefix']} #{node['gpac']['compile_flags'].join(' ')}
    make clean && make && make install
  EOH
  creates creates
end
