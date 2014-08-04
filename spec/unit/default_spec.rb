require 'spec_helper'

describe 'gpac::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
end
