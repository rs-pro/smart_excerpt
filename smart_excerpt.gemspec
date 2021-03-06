# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smart_excerpt/version'

Gem::Specification.new do |spec|
  spec.name          = "smart_excerpt"
  spec.version       = SmartExcerpt::VERSION
  spec.authors       = ["glebtv"]
  spec.email         = ["glebtv@gmail.com"]
  spec.summary       = %q{Allows to create intellegent excerpt fields.}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/rs-pro/smart_excerpt"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport'
  spec.add_dependency 'htmlentities'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
