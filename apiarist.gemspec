# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'apiarist/version'

Gem::Specification.new do |spec|
  spec.name          = "apiarist"
  spec.version       = Apiarist::VERSION
  spec.authors       = ["Victor Martinez"]
  spec.email         = ["knoopx@gmail.com"]
  spec.description   = %q{An opinionated ActiveModel::Serializers alternative}
  spec.summary       = %q{An opinionated ActiveModel::Serializers alternative}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', '>= 3.0'
  spec.add_dependency 'actionpack', '>= 3.0'
  spec.add_dependency 'inherited_resources', '>= 1.3.1'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
