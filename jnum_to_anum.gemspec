# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jnum_to_anum/version'

Gem::Specification.new do |spec|
  spec.name          = "jnum_to_anum"
  spec.version       = JnumToAnum::VERSION
  spec.authors       = ["NishinoTakuma"]
  spec.email         = ["takuuma.717@gmail.com"]

  spec.summary       = %q{test}
  spec.description   = %q{test}
  spec.homepage      = "https://github.com/nishinotakuma/jnum_to_anum"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
 

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
