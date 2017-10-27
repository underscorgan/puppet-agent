component 'puppet-agent-52-runtime' do |pkg, settings, platform|
  pkg.version '201710240'
  pkg.sha1sum "http://builds.puppetlabs.lan/puppet-runtime/artifacts/#{pkg.get_name}-#{pkg.get_version}.#{platform.name}.tar.gz.sha1"
  pkg.url "http://builds.puppetlabs.lan/puppet-runtime/artifacts/#{pkg.get_name}-#{pkg.get_version}.#{platform.name}.tar.gz"
  pkg.install_only true

  pkg.install do
    ["gunzip -c puppet-agent-52-runtime-#{pkg.get_version}.#{platform.name}.tar.gz | tar -C / -xf -"]
  end
end
