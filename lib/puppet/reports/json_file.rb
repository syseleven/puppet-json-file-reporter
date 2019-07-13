# frozen_string_literal: true

require 'puppet'
require 'puppet/util'
require 'puppet/util/logging'
require 'yaml'
require 'json'
require 'fileutils'

SEPARATOR = [Regexp.escape(File::SEPARATOR.to_s), Regexp.escape(File::ALT_SEPARATOR.to_s)].join

Puppet::Reports.register_report(:json_file) do
  desc "Store the report converted to json on disk. Each host sends its report as a YAML dump
    and this just converts the dump to json and stores the file on disk, in the `reportdir`-json directory."

  CONFIGURATION_FILE = File.join([File.dirname(Puppet.settings[:config]), 'json_file.yaml'])

  unless File.exist?(CONFIGURATION_FILE)
    raise(Puppet::ParseError, "Logstash tcp configuration file #{CONFIGURATION_FILE} missing or not readable!")
  end

  def process
    validate_host(host)

    now = Time.now
    name = ['year', 'month', 'day', 'hour', 'min', 'sec'].map { |method| '%02d' % now.send(method).to_s }.join

    reportdir = YAML.load_file(CONFIGURATION_FILE)[:json_reportdir]
    hosts_subdir = YAML.load_file(CONFIGURATION_FILE)[:hosts_subdir]
    newline = YAML.load_file(CONFIGURATION_FILE)[:newline]

    if hosts_subdir
      dir = File.join(reportdir.to_s, host.to_s)
      file = File.join(dir, "#{name}.json")
    else
      dir = reportdir.to_s
      file = File.join(dir, "#{host}-#{name}.json")
    end

    unless Puppet::FileSystem.exist?(dir)
      FileUtils.mkdir_p(dir)
      FileUtils.chmod_R(0o750, dir)
    end

    report = {}

    report = {
      'host' => host,
      '@timestamp' => Time.now.utc.iso8601,
      '@version' => 1,
      'puppet_configuration_version' => configuration_version,
      'puppet_environment' => environment,
      'puppet_noop' => noop ? 'true' : 'false',
      'puppet_version' => puppet_version,
      'puppet_report_format' => report_format,
      'puppet_status' => status,
      'puppet_time_start' => logs.first.time.utc.iso8601,
      'puppet_time_end' => logs.last.time.utc.iso8601,
    }

    messages = []
    tags = []

    logs.each do |log|
      time = log.time.utc.iso8601
      level = log.level
      message = log.message

      messages << "(#{time})\t(#{level}) #{message}"
      tags << log.tags.join(',')
    end

    report['puppet_logs'] = messages.join("\n")
    report['puppet_tags'] = tags.flatten.join(',').split(',').sort.uniq

    report['metrics'] = {}

    metrics.each do |key, value|
      report['metrics'][key] = {}

      value.values.each do |item|
        report['metrics'][key][item[1].tr('[A-Z ]', '[a-z_]')] = item[2]
      end
    end

    begin
      File.open(file, 'a') do |f|
        f.puts(report.to_json)

        if newline
          f.puts("\n")
        end
      end
    rescue StandardError => detail
      Puppet.log_exception(detail, "Could not write json report for #{host} at #{file}: #{detail}")
    end
  end

  def validate_host(host)
    return unless host&.match?(Regexp.union(%r{[#{SEPARATOR}]}, %r{\A\.\.?\Z}))

    raise ArgumentError, _('Invalid node name %{host}') % { host: host.inspect }
  end

  module_function :validate_host
end
