# frozen_string_literal: true

require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
require 'rspec-puppet-facts-unsupported'

include RspecPuppetFacts
include RspecPuppetFactsUnsupported

default_facts = {
  puppetversion: Puppet.version,
  facterversion: Facter.version,
  puppet_vardir: '/opt/puppetlabs/puppet/cache',
}

def fixtures_directory
  File.expand_path(File.join(__FILE__, '..', 'fixtures'))
end

RSpec.configure do |config|
  config.hiera_config  = 'spec/fixtures/hiera.yaml'
  config.default_facts = default_facts

  config.add_setting :fixtures_directory, default: fixtures_directory
  config.mock_with(:rspec)

  config.after(:suite) do
    RSpec::Puppet::Coverage.report!
  end

  Puppet.settings[:config] = File.join(fixtures_directory, 'puppet.conf')
end
