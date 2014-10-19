$:.push File.expand_path("../lib", __FILE__)

require 'falco/version'

Gem::Specification.new do |s|
  s.name        = 'falco'
  s.version     = Falco::VERSION
  s.date        = Time.now.strftime('%Y-%m-%d')
  s.summary     = ''
  s.description = ''
  s.authors     = ['Rene Klacan']
  s.email       = 'rene@klacan.sk'
  s.files       = Dir["{lib}/**/*", "LICENSE", "README.md"]
  s.executables = []
  #s.homepage    = 'https://github.com/reneklacan/steroid'
  s.license     = 'Beerware'

  s.required_ruby_version = '>= 1.9'

  s.add_dependency 'activesupport'

  s.add_development_dependency 'rspec', '~> 3.0'
end
