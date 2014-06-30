package "apt"
cookbook_file '/home/vagrant/showversion.R' do
  source "showversion.R"
  owner "vagrant"
  group "vagrant"
  mode "0755"
end

package "git"

package "subversion"
package "build-essential"
package "gfortran"
package "libreadline6-dev"
package "xorg-dev"

package "openjdk-7-jdk"
package "texlive-latex-base"
# for incosolata.sty zi4.sty
package "texlive-fonts-extra"
package "cm-super"
package "texi2html"
#package "texi2dvi"

log "package install"


directory "#{Chef::Config[:file_cache_path]}/r-devel/" do
  owner "vagrant"
  group "vagrant"
  recursive true
  mode "0755"
  action :create
end

remote_file "#{Chef::Config[:file_cache_path]}/r-devel/R-latest.tar.gz" do
  source "http://cran.r-project.org/src/base-prerelease/R-latest.tar.gz"
end

execute "R patched source compile and install" do
  command <<-CODE
set -e
(cd #{Chef::Config[:file_cache_path]}/r-devel/ && tar zxvf R-latest.tar.gz)
(cd #{Chef::Config[:file_cache_path]}/r-devel/R-patched && ./configure --without-recommended-packages --enable-R-shlib)
(cd #{Chef::Config[:file_cache_path]}/r-devel/R-patched && ./tools/rsync-recommended)
(cd #{Chef::Config[:file_cache_path]}/r-devel/R-patched && ./tools/link-recommended)
(cd #{Chef::Config[:file_cache_path]}/r-devel/R-patched && make)
(cd #{Chef::Config[:file_cache_path]}/r-devel/R-patched && bin/R CMD INSTALL src/library/Recommended/MASS.tgz)
(cd #{Chef::Config[:file_cache_path]}/r-devel/R-patched && make check)
(cd #{Chef::Config[:file_cache_path]}/r-devel/R-patched && make install)
CODE
  action :run
end

