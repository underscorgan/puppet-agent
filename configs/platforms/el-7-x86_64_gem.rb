## ///////////////////////
## DO NOT REVIEW THIS!!##
## ///////////////////////
##
## This will be removed when the agent runtime is merged and
## the runtime component can be added to the cfacter project
## It is only left here to allow others to attempt a build
## while this PR is under review
platform "el-7-x86_64" do |plat|
  plat.servicedir "/usr/lib/systemd/system"
  plat.defaultdir "/etc/sysconfig"
  plat.servicetype "systemd"
  plat.make "make"

  plat.add_build_repository "http://pl-build-tools.delivery.puppetlabs.net/yum/pl-build-tools-release-#{plat.get_os_name}-#{plat.get_os_version}.noarch.rpm"
  plat.provision_with "curl -O http://builds.puppetlabs.lan/puppet-runtime/201801240/artifacts/agent-runtime-master-201801240.el-7-x86_64.tar.gz"
  plat.provision_with "gunzip -c agent-runtime-master-201801240.el-7-x86_64.tar.gz | tar -k -C / -xf -"
  plat.provision_with "yum install --assumeyes autoconf automake createrepo rsync gcc make rpmdevtools rpm-libs yum-utils rpm-sign"
  plat.install_build_dependencies_with "yum install --assumeyes"
  plat.vmpooler_template "centos-7-x86_64"
end
