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
    and this just converts the dump to json and stores the file on disk, in the `reportdir`json directory."

  def process
    validate_host(host)

    now = Time.now

    name = %w{year month day hour min sec}.collect do |method| "%02d" % now.send(method).to_s end.join

    json_dir = File.join(Puppet[:reportdir], 'json')
    json_file = File.join(json_dir, "#{host}-#{name}.json")

    if ! Puppet::FileSystem.exist?(json_dir)
      FileUtils.mkdir_p(json_dir)
      FileUtils.chmod_R(0750, json_dir)
    end

    begin
      File.open(json_file, 'w') { |file| file.write(self.to_json) }
      Puppet.send_log(:notice, "Json formatted report written to #{json_file}.")
    rescue => detail
      Puppet.log_exception(detail, "Could not write json report for #{host} at #{json_file}: #{detail}")
    end
  end

  def validate_host(host)
    if host =~ Regexp.union(/[#{SEPARATOR}]/, /\A\.\.?\Z/)
      raise ArgumentError, _("Invalid node name %{host}") % { host: host.inspect }
    end
  end

  module_function :validate_host
end
