# frozen_string_literal: true

require 'spec_helper'

describe 'json_file_reporter' do
  let(:facts) do
    {
      is_pe: false,
    }
  end

  context 'with invalid report_dir parameter' do
    let(:params) do
      {
        report_dir: 'asdf/asdf',
      }
    end

    it {
      expect(subject).to compile.and_raise_error(%r{Class\[Json_file_reporter\]: parameter 'report_dir' expects a Stdlib::Absolutepath = Variant\[Stdlib::Windowspath = Pattern\[.*\], Stdlib::Unixpath = Pattern\[.*\] value, got String})
    }
  end

  context 'with invalid enable_hosts_subdir parameter' do
    let(:params) do
      {
        enable_hosts_subdir: 'false',
      }
    end

    it {
      expect(subject).to compile.and_raise_error(%r{Class\[Json_file_reporter\]: parameter 'enable_hosts_subdir' expects a Boolean value, got String})
    }
  end
end
