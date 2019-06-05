# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'json_file_reporter' do
  let(:manifest) do
    <<-INCLUDE_CLASS
      include json_file_reporter
    INCLUDE_CLASS
  end

  it 'runs first time with changes and without errors' do
    expect(apply_manifest(manifest, catch_failures: true).exit_code).to eq 2
  end

  it 'runs a second time without changes' do
    expect(apply_manifest(manifest, catch_changes: true).exit_code).to eq 0
  end

  describe file('/etc/puppetlabs/puppet/json_file.yaml') do
    it { is_expected.to be_file }
    it { is_expected.to contain ':json_reportdir: /opt/puppetlabs/server/data/puppetserver/reports-json' }
    it { is_expected.to contain ':hosts_subdir: Off' }
  end
end
