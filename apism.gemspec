# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'apism/version'

Gem::Specification.new do |spec|
  spec.name          = "apism"
  spec.version       = Apism::VERSION
  spec.authors       = ["Jared Grippe"]
  spec.email         = ["jared@deadlyicon.com"]
  spec.description   = %q{a simple json api framework}
  spec.summary       = %q{A simple framework, build on top of Sinatra, for building JSON APIs}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sinatra", "~> 1.4"
  spec.add_dependency "slop"
  spec.add_dependency "activerecord", "~> 4.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rack-test"
end
