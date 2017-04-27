require 'spec_helper'
describe 'firewall_wrap' do
  context 'with default values for all parameters' do
    it { should contain_class('firewall_wrap') }
  end
end
