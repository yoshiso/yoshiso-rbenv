

default["rbenv"]["user"] = "vagrant"
default["rbenv"]["git_url"] = "https://github.com/sstephenson/rbenv.git"
default['rbenv']['rubybuild_git_url'] = "https://github.com/sstephenson/ruby-build.git"
default["rbenv"]["install_pkgs"] = %w{
  gcc make zlib zlib-devel readline readline-devel openssl openssl-devel curl curl-devel
}

# Any python versions you want to install
# default["rbenv"]["versions"] = []

# global python version
# defalut['rbenv']['version'] = "2.7.6"