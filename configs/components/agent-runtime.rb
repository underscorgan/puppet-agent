component 'agent-runtime' do |pkg, settings, platform|
  pkg.version '0.0.0'
  pkg.md5sum '60a0c4ff47c30f2d0382d81506eb1c12'
  pkg.url "http://builds.puppetlabs.lan/agent-runtime/artifacts/el/7/PC1/x86_64/agent-runtime-0.0.0.tar.gz"
  pkg.install_only true

  pkg.install do
    ["gunzip -c agent-runtime-#{pkg.get_version}.tar.gz | tar -C / -xf -"]
  end
end
