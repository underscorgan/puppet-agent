component "facter-source-gem" do |pkg, settings, platform|
  pkg.build_requires 'facter-source'
  pkg.build_requires 'leatherman-source'
  pkg.build_requires 'cpp-hocon-source'
  pkg.build_requires 'puppet-agent'

  pkg.add_source("file://resources/files/cfacter-gem/cfacter.gemspec.erb", erb: 'true')
  pkg.add_source("file://resources/files/cfacter-gem/extconf.rb")
  pkg.add_source("file://resources/files/cfacter-gem/Makefile.erb")
  pkg.install_file('cfacter.gemspec', "#{settings[:gemdir]}")
  pkg.install_file('extconf.rb', "#{settings[:gemdir]}/ext/facter")
  pkg.install_file('Makefile.erb', "#{settings[:gemdir]}/ext/facter")

  pkg.install do
    [
      "pushd #{settings[:gemdir]}",
      "#{settings[:runtime_dir]}/gem build cfacter.gemspec",
      "popd"
    ]
  end
end
