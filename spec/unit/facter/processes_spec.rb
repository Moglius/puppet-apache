# frozen_string_literal: true

require 'spec_helper'
require 'facter'
require 'facter/processes'

describe :processes, type: :fact do
  subject(:fact) { Facter.fact(:processes) }

  before :each do
    # perform any action that should be run before every test
    Facter.clear
  end

  it 'returns a value' do
    expect(fact.value).to eq('hello facter')
  end
end
