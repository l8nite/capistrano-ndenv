# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "capistrano-ndenv"
  gem.version       = '1.2.0'
  gem.authors       = ["Shaun Guth"]
  gem.email         = ["shaun.guth@gmail.com"]
  gem.description   = %q{ndenv integration for Capistrano}
  gem.summary       = %q{This gem lets you use ndenv for node/npm integration in Capistrano}
  gem.homepage      = "https://github.com/l8nite/capistrano-ndenv"
  gem.licenses      = ['MIT']

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'capistrano', '>= 3.1.0', '< 4'
  gem.add_dependency 'sshkit', '~> 1.3'
end
