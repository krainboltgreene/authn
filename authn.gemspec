# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'authn/version'

Gem::Specification.new do |gem|
  gem.name          = "authn"
  gem.version       = AuthN::VERSION
  gem.authors       = ["Kurtis Rainbolt-Greene"]
  gem.email         = ["kurtisrainboltgreene@gmail.com"]
  gem.summary       = %q{An incredibly bare bones authentication library}
  gem.description   = gem.summary
  gem.homepage      = "http://github.com/krainboltgreene/authn"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'activemodel', '~> 3.0'
  gem.add_runtime_dependency 'bcrypt-ruby', '~> 3.0'
  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'kramdown'
  # gem.add_runtime_dependency 'gemname', '~> 1.0'
  # gem.add_development_dependency 'gemname', '~> 1.0'
end
