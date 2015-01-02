# coding: utf-8

require 'spec_helper'

RSpec.describe Verse::Wrapping, '#new' do
  let(:text) { "There go the ships; there is that Leviathan whom thou hast made to play therein."}

  it "defaults indentation to 0" do
    wrapping = Verse::Wrapping.new(text)
    expect(wrapping.indent).to eq(0)
  end

  it "defaults paddnig to empty array" do
    wrapping = Verse::Wrapping.new(text)
    expect(wrapping.padding).to eq([])
  end

  it "allows to set global indenation" do
    wrapping = Verse::Wrapping.new(text, indent: 5)
    expect(wrapping.indent).to eq(5)
  end

  it "allows to set global padding" do
    wrapping = Verse::Wrapping.new(text, padding: [1,2,3,4])
    expect(wrapping.padding).to eq([1,2,3,4])
  end
end
