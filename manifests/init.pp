# @summary converts the report into json and store it on the disk
#
# @author
#   Mike Fröhner <m.froehner@syseleven.de> www.syseleven.de
#
# @see https://www.github.com/syseleven/puppet-json-file-reporter
#
# @param report_dir
#   Directory to store the reports
# @param enable_hosts_subdir
#   enables/disables a subdir within $report named after the hostname for the report
# @param config_owner
#   Owner of the configuration file
# @param config_group
#   Group of the configuration file
#
# @example simple usage
#   include json_file_reporter
#
# @example change the directory for the reports to "/var/cache/foo"
#   class { 'json_file_reporter':
#     report_dir => '/var/cache/foo',
#   }
#
# @example enable the hosts sub directory
#   class { 'json_file_reporter':
#     enable_hosts_subdir => true,
#   }
#
class json_file_reporter (
  Stdlib::Absolutepath $report_dir          = '/opt/puppetlabs/server/data/puppetserver/reports-json',
  Boolean              $enable_hosts_subdir = false,
  Boolean              $enable_newline      = true,
  String               $config_owner        = $json_file_reporter::params::config_owner,
  String               $config_group        = $json_file_reporter::params::config_group,
) inherits json_file_reporter::params {
  file { '/etc/puppetlabs/puppet/json_file.yaml':
    ensure  => file,
    content => template("${module_name}/json_file.yaml.erb"),
    mode    => '0440',
    owner   => $config_owner,
    group   => $config_group,
  }
}
