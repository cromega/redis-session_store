Gem::Specification.new do |s|
  s.name        = 'redis-session_store'
  s.version     = '0.0.1'
  s.summary     = 'Redis SessionStore'
  s.description = 'A Rails SessionStorage implementation that uses Redis as storage'
  s.author      = 'Bence Monus'
  s.email       = 'crome@sublimia.nl'
  s.homepage    = 'http://github.com/cromega/redis-session_store'
  s.files       = `git ls-files`.split("\n")
  s.require_path = 'lib'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency('actionpack', '=> 4.0.0', '< 5')
  s.add_dependency('railties', '=> 4.0.0', '< 5')
  s.add_dependency('redis')
end
