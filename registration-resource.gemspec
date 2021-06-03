# -*- encoding: utf-8 -*-
Gem::Specification.new do |spec|
  spec.name = 'registration-resource'
  spec.version = '0.0.0'
  spec.summary = 'Registration Resource'
  spec.description = ' '

  spec.authors = ['Joseph Choe']
  spec.email = ['joseph@josephchoe.com']
  spec.homepage = 'https://github.com/bluepuppetcompany/registration-resource'

  spec.require_paths = ['lib']
  spec.files = Dir.glob('{lib}/**/*')
  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.6'

  spec.add_runtime_dependency 'rack'

  spec.add_development_dependency 'test_bench'
end