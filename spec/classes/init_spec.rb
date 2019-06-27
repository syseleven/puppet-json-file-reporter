# frozen_string_literal: true

require 'spec_helper'

describe 'json_file_reporter' do
  on_supported_os.each do |os, os_facts|
    let(:facts) do
      os_facts.merge(
        is_pe: false,
      )
    end

    context "on #{os}" do
      context 'with default parameters' do
        it {
          expect(subject).to compile.with_all_deps
          expect(subject).to contain_class('json_file_reporter')
          expect(subject).to contain_class('json_file_reporter::params')

          expect(subject).to contain_file('/etc/puppetlabs/puppet/json_file.yaml').with(
            'ensure' => 'file',
            'content' => "---\n:json_reportdir: /opt/puppetlabs/server/data/puppetserver/reports-json\n:hosts_subdir: Off\n:newline: On\n",
            'mode' => '0440',
            'owner' => 'puppet',
            'group' => 'puppet',
          )
        }
      end

      context 'with given parameter' do
        let(:params) do
          {
            report_dir: '/foo/bar/asdf/yxcv',
            enable_hosts_subdir: true,
            enable_newline: false,
            config_owner: 'somebody_else',
            config_group: 'somebody_else',
          }
        end

        it {
          expect(subject).to compile.with_all_deps
          expect(subject).to contain_class('json_file_reporter')
          expect(subject).to contain_class('json_file_reporter::params')

          expect(subject).to contain_file('/etc/puppetlabs/puppet/json_file.yaml').with(
            'ensure' => 'file',
            'content' => "---\n:json_reportdir: /foo/bar/asdf/yxcv\n:hosts_subdir: On\n:newline: Off\n",
            'mode' => '0440',
            'owner' => 'somebody_else',
            'group' => 'somebody_else',
          )
        }
      end
    end
  end
end
