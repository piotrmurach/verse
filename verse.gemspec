# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'verse/version'

Gem::Specification.new do |spec|
  spec.name          = "verse"
  spec.version       = Verse::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = [""]
  spec.summary       = %q{Text transformations such as truncation, wrapping, aligning, indentation and grouping of words.}
  spec.description   = %q{Text transformations such as truncation, wrapping, aligning, indentation and grouping of words.}
  spec.homepage      = "https://github.com/piotrmurach/verse"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'unicode_utils',        '~> 1.4.0'
  spec.add_dependency 'unicode-display_width','~> 1.1.0'

  spec.add_development_dependency 'bundler', '~> 1.5'
end
