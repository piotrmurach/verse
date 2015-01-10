# coding: utf-8

require 'spec_helper'

RSpec.describe Verse::Truncation, '.truncate' do
  let(:text) { 'ラドクリフ、マラソン五輪代表に1万m出場にも含み' }

  it "doesn't change text for 0 length" do
    truncation = Verse::Truncation.new(text)
    expect(truncation.truncate(0)).to eq(text)
  end

  it "doensn't change text for nil length" do
    truncation = Verse::Truncation.new(text)
    expect(truncation.truncate(nil)).to eq(text)
  end

  it "doesn't change text for equal length" do
    truncation = Verse::Truncation.new(text)
    expect(truncation.truncate(text.length)).to eq(text)
  end

  it 'truncates text' do
    truncation = Verse::Truncation.new(text)
    trailing = '…'
    expect(truncation.truncate(12)).to eq("ラドクリフ、マラソン五#{trailing}")
  end

  it "doesn't truncate text when length exceeds content" do
    truncation = Verse::Truncation.new(text)
    expect(truncation.truncate(100)).to eq(text)
  end

  it 'truncates text with string separator' do
    truncation = Verse::Truncation.new(text)
    trailing = '…'
    expect(truncation.truncate(12, separator: ' ')).to eq("ラドクリフ、マラソン五#{trailing}")
  end

  it 'truncates text with regex separator' do
    truncation = Verse::Truncation.new(text)
    trailing = '…'
    expect(truncation.truncate(12, separator: /\s/)).to eq("ラドクリフ、マラソン五#{trailing}")
  end

  it 'truncates text with custom trailing' do
    truncation = Verse::Truncation.new(text)
    trailing = '... (see more)'
    expect(truncation.truncate(20, trailing: trailing)).to eq("ラドクリフ、#{trailing}")
  end

  it 'correctly truncates with ANSI characters' do
    text = "This is a \e[1m\e[34mbold blue text\e[0m"
    truncation = Verse::Truncation.new(text)
    expect(truncation.truncate).to eq 'This is a bold blue text'
  end

  it "finishes on word boundary" do
    text = "for there is no folly of the beast of the earth"
    truncation = Verse::Truncation.new(text)
    expect(truncation.truncate(20, separator: ' ')).to eq('for there is no…')
  end
end
