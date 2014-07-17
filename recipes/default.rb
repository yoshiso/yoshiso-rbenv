#
# Cookbook Name:: yoshiso-rbenv
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install python dependent libraries
Array(node['rbenv']['install_pkgs']).each do |pkg|
  package pkg do
    action :install
  end
end

# Install Setting
template '/etc/profile.d/rbenv.sh' do
  source  'rbenv.sh'
  owner   'root'
  mode    0755
  not_if { ::File.exists?("/etc/profile.d/rbenv.sh") }
end

# Install rbenv
home = File.expand_path("~#{node['rbenv']['user']}")
bin  = "#{home}/.rbenv/bin"
git "#{home}/.rbenv" do
  repository node['rbenv']['git_url']
  user node['rbenv']['user']
  group node['rbenv']['user']
  action :sync
end

bash "rbenv plugin"   do
  code "mkdir -p #{home}/.rbenv/plugins"
  user node['rbenv']['user']
  action :run
  not_if { ::File.exists?("#{home}/.rbenv/plugins") }
end


git "#{home}/.rbenv/plugins/ruby-build" do
  repository node['rbenv']['rubybuild_git_url']
  user node['rbenv']['user']
  group node['rbenv']['user']
  action :sync
end

# Install rubies
Array(node['rbenv']['versions']).each do |v|

  bash "Install ruby -v #{v}" do
    user node['rbenv']['user']
    cwd home
    action :run
    code <<-EOF
      export RBENV_ROOT="#{home}/.rbenv"
      export PATH=#{bin}:$PATH
      eval "$(rbenv init -)"
      rbenv install #{v}
      rbenv rehash
    EOF
    not_if { ::File.directory?("#{home}/.rbenv/versions/#{v}") }
  end

end


# define curent global python
if(node['rbenv'].attribute?("version"))

  bash "use python -v #{node['rbenv']['version']}" do
    user node['rbenv']['user']
    cwd home
    action :run
    code <<-EOF
      export RBENV_ROOT="#{home}/.rbenv"
      export PATH=#{bin}:$PATH
      eval "$(rbenv init -)"
      rbenv global #{node['rbenv']['version']}
      rbenv rehash
    EOF
  end

end