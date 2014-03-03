# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tzformater/version'

Gem::Specification.new do |spec|
  spec.name          = 'tzformater'
  spec.version       = TZFormater::VERSION
  spec.authors       = ["Dmitry Tonkonogov"]
  spec.email         = ["omun.spambox@gmail.com"]
  spec.summary       = %q{Library for converting timezone to different formats (POSIX, Olson, windows-like, windows-registry)}
  spec.description   = %q{Just first gem.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency 'coveralls', '>= 0.7.0'
  spec.add_development_dependency "rake"
  spec.add_development_dependency "require_all"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov", ">= 0.8.2"
end
