# frozen_string_literal: true

source ENV['GEM_SOURCE'] || 'https://rubygems.org'

gem 'metadata-json-lint'

gem 'puppet', ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'].to_s : '6.2.0'
gem 'puppet-lint'
gem 'puppet-lint-absolute_template_path'
gem 'puppet-lint-alias-check'
gem 'puppet-lint-duplicate_class_parameters-check'
gem 'puppet-lint-no_file_path_attribute-check'
gem 'puppet-lint-no_symbolic_file_modes-check'
gem 'puppet-lint-package_ensure-check'
gem 'puppet-lint-resource_reference_syntax'
gem 'puppet-lint-trailing_comma-check'
gem 'puppet-lint-trailing_newline-check'
gem 'puppet-lint-unquoted_string-check'
gem 'puppet-lint-variable_contains_upcase'
gem 'puppet-lint-version_comparison-check'
gem 'puppet-strings'
gem 'puppet-syntax'
gem 'puppetlabs_spec_helper'

gem 'rubocop', '~> 0.63.0'
gem 'rubocop-rspec', '~> 1.31.0'

gem 'rspec-puppet-facts', '~> 1.7'
gem 'rspec-puppet-facts-unsupported', '~> 0.1'

group :acceptance do
  gem 'beaker', '~>4.0'
  gem 'beaker-docker', require: false
  gem 'beaker-hostgenerator', '>= 1.1.10', require: false
  gem 'beaker-module_install_helper', require: false
  gem 'beaker-puppet', require: false
  gem 'beaker-puppet_install_helper', require: false
  gem 'beaker-rspec'
end
