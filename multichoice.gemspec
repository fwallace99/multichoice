# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'multichoice/version'

Gem::Specification.new do |spec|
  spec.name          = "multichoice"
  spec.version       = Multichoice::VERSION
  spec.authors       = ["Floyd Wallace"]
  spec.email         = ["fwallace99@gmail.com"]

  spec.summary       = %q{Creates a Multiple Choice Amazon Mechanical Turk Human Intellgince Task using radio buttons.}
  spec.description   = %q{Create Checkboxes and also parse the answer for a HIT.}
  spec.homepage      = "https://github.com/fwallace99/multichoice"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]



  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
