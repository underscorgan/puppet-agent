require 'json'
require 'git'

project "cfacter" do |proj|
  platform = proj.get_platform
  # It's not ideal that we need to clone the facter repo
  # to obtain the correct facter version/release. However
  # I couldn't see any other way to obtain the information
  # about facter's version an # of commits since last tag.
  #
  #               Sean P. McD. 2/13/18
  facter_data = JSON.parse(File.read(File.join(File.dirname(__FILE__), '../components/facter.json')))
  Dir.mktmpdir do |dir|
    Dir.chdir(dir) do
      g = Git.clone(facter_data['url'], 'facter')
      g.checkout(facter_data['ref'])
      @facter_version = File.read('facter/CMakeLists.txt').match(/project\(FACTER VERSION [\d\.]*\)/).to_s.gsub(/[^\d\.]/, '')
      @facter_release = g.describe('HEAD').split('-')[-2]
    end
  end
  gem_version = @facter_release.nil? ? @facter_version : @facter_version + '.rc' + @facter_release
  proj.version gem_version
  proj.setting(:project_version, gem_version)
  proj.setting(:gemdir, '/var/tmp/facter_gem')
  proj.setting(:runtime_dir, '/opt/puppetlabs/puppet/bin')

  proj.component "facter-source"
  proj.component "leatherman-source"
  proj.component "cpp-hocon-source"
  proj.component "cfacter-source-gem"
  proj.fetch_artifact "#{settings[:gemdir]}/cfacter-#{settings[:project_version]}.gem"
  proj.no_packaging true
end