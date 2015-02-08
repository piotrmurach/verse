# coding: utf-8

require 'spec_helper'

RSpec.describe Verse, '#align' do
  it "aligns text" do
    text = "the madness of men"
    expect(Verse.align(text, 22, :center)).to eq("  the madness of men  ")
  end
end
