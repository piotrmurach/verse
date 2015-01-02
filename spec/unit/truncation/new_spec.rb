# coding: utf-8

require 'spec_helper'

RSpec.describe Verse::Truncation, '#new' do
  let(:text) { 'There go the ships; there is that Leviathan whom thou hast made to play therein.'}

  it "defaults to no separator and unicode trailing" do
    truncation = Verse::Truncation.new text
    expect(truncation.separator).to eq(nil)
  end

  it "defaults to unicode trailing" do
    truncation = Verse::Truncation.new text
    expect(truncation.trailing).to eq('…')
  end


  it "allows to setup global separator value" do
    truncation = Verse::Truncation.new text, separator: ' '
    expect(truncation.separator).to eq(' ')
  end

  it "allows to setup global trailing value" do
    truncation = Verse::Truncation.new text, trailing: '...'
    expect(truncation.trailing).to eq('...')
  end
end
