# coding: utf-8

require 'spec_helper'

RSpec.describe Verse::Padder, '#parse' do
  subject(:padder) { described_class }

  it "parses nil" do
    instance = padder.parse(nil)
    expect(instance.padding).to eq([])
  end

  it 'parses self' do
    value = described_class.new([])
    instance = padder.parse(value)
    expect(instance.padding).to eq([])
  end

  it "parses digit" do
    instance = padder.parse(5)
    expect(instance.padding).to eq([5,5,5,5])
  end

  it "parses 2-element array" do
    instance = padder.parse([2,3])
    expect(instance.padding).to eq([2,3,2,3])
  end

  it "parses 4-element array" do
    instance = padder.parse([1,2,3,4])
    expect(instance.padding).to eq([1,2,3,4])
  end

  it "fails to parse unknown value" do
    expect {
      padder.parse(:unknown)
    }.to raise_error(Verse::ParseError)
  end
end
