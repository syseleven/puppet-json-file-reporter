# frozen_string_literal: true

require 'spec_helper'
require 'puppet/reports'
require 'time'
require 'pathname'
require 'tempfile'
require 'fileutils'
require 'json'

processor = Puppet::Reports.report(:json_file)

describe processor do
  describe '#process' do
    it 'sends the right data to the disk' do
      data = JSON.parse(File.read("#{fixtures_directory}/report.json"))

      expect(data).not_to be_empty
      expect(data['host']).to eq('4f3ba3f15148.local')
      expect(data['configuration_version']).to eq(1_559_728_231)
      expect(data['environment']).to eq('production')
      expect(data['noop']).to eq(false)
      expect(data['report_format']).to eq(10)
      expect(data['status']).to eq('unchanged')
      expect(data['time']).to eq('2019-06-05T09:50:28.503928200+00:00')
      expect(data['puppet_version']).to eq('6.4.2')
    end
  end
end
