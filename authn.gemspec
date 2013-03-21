# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "authn/version"

Gem::Specification.new do |spec|
  spec.name          = "authn"
  spec.version       = AuthN::VERSION
  spec.authors       = ["Kurtis Rainbolt-Greene"]
  spec.email         = ["me@kurtisrainboltgreene.name"]
  spec.summary       = %q{An incredibly bare bones authentication library}
  spec.description   = spec.summary
  spec.homepage      = "http://krainboltgreene.github.com/authn"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'activemodel', '~> 3.0'
  spec.add_runtime_dependency 'astruct', '~> 2.9'
  spec.add_runtime_dependency 'bcrypt-ruby', '~> 3.0'
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "kramdown"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "coveralls"
end
