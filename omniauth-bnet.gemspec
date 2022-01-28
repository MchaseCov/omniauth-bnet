lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-bnet/version'

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-bnet'
  spec.version       = OmniAuth::Bnet::VERSION
  spec.authors       = ['Christopher Giroir']
  spec.email         = ['cgiroir@blizzard.com']
  spec.summary       = 'Omniauth Strategy for Battle.net'
  spec.description   = 'Omniauth Strategy for Battle.net OAuth Login. For more info visit https://dev.battle.net'
  spec.homepage      = 'https://github.com/Blizzard/omniauth-bnet'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'omniauth', '~> 2.0.4'
  spec.add_dependency 'omniauth-oauth2'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 0'
end
