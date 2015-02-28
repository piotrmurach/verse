# coding: utf-8

require 'spec_helper'

RSpec.describe Verse::Padder, 'accessors' do
  subject(:padder) { described_class }

  it "allows to set padding through accessors" do
    instance = padder.parse([1,2,3,4])
    instance.top = 5
    expect(instance.padding).to eq([5,2,3,4])
  end
end

