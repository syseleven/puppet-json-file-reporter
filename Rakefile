# frozen_string_literal: true

require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'
require 'puppet-strings/tasks'

require 'beaker/tasks/quick_start'

begin
  if Gem::Specification.find_by_name('puppet-lint')
    require 'puppet-lint/tasks/puppet-lint'
    PuppetLint.configuration.ignore_paths = ['spec/**/*.pp', 'vendor/**/*.pp']
    task default: [:rspec, :lint]
  end
rescue Gem::LoadError
  task default: :rspec
end

desc 'Run syntax, lint, and spec tests.'
task test: [:syntax, :lint, :rubocop, :spec, :beaker]
