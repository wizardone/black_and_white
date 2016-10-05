# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'black_and_white/version'

Gem::Specification.new do |spec|
  spec.name          = "black_and_white"
  spec.version       = BlackAndWhite::VERSION
  spec.authors       = ["Stefan Slaveykov"]
  spec.email         = ["wizard.oneandonly@gmail.com"]

  spec.summary       = %q{A/B testing for ActiveRecord}
  spec.description   = %q{A/B testing made easy}
  spec.homepage      = "https://github.com/wizardone/black_and_white"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    #spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.required_ruby_version = '>= 2.2.2'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "activerecord", ">= 4.2"
  spec.add_development_dependency "activesupport", ">= 4.2"
  spec.add_development_dependency "pg"
  spec.add_development_dependency "mongoid", ">= 5.1.4"
  spec.add_development_dependency 'database_cleaner'
end
