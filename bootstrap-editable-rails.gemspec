# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bootstrap-editable-rails/version'

Gem::Specification.new do |gem|
  gem.name          = "bootstrap-editable-rails"
  gem.version       = Bootstrap::Editable::Rails::VERSION
  gem.authors       = ["Toru KAWAMURA"]
  gem.email         = ["tkawa@4bit.net"]
  gem.description   = %q{In-place editing with Twitter Bootstrap for Rails}
  gem.summary       = %q{In-place editing with Twitter Bootstrap for Rails}
  gem.homepage      = "https://github.com/bootstrap-ruby/bootstrap-editable-rails"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "railties", ">= 3.1"
  gem.add_dependency "sass-rails"
end
