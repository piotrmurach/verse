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
    expect(truncation.truncate(text.length * 2)).to eq(text)
  end

  it 'truncates text' do
    truncation = Verse::Truncation.new(text)
    trailing = '…'
    expect(truncation.truncate(12)).to eq("ラドクリフ#{trailing}")
  end

  it "estimates total width correctly " do
    truncation = Verse::Truncation.new('太丸ゴシック体')
    trailing = '…'
    expect(truncation.truncate(8)).to eq("太丸ゴ#{trailing}")
  end

  it "doesn't truncate text when length exceeds content" do
    truncation = Verse::Truncation.new(text)
    expect(truncation.truncate(100)).to eq(text)
  end

  it 'truncates text with string separator' do
    truncation = Verse::Truncation.new(text)
    trailing = '…'
    expect(truncation.truncate(12, separator: '')).to eq("ラドクリフ#{trailing}")
  end

  it 'truncates text with regex separator' do
    truncation = Verse::Truncation.new(text)
    trailing = '…'
    expect(truncation.truncate(12, separator: /\s/)).to eq("ラドクリフ#{trailing}")
  end

  it 'truncates text with custom trailing' do
    truncation = Verse::Truncation.new(text)
    trailing = '... (see more)'
    expect(truncation.truncate(20, trailing: trailing)).to eq("ラド#{trailing}")
  end

  it 'correctly truncates with ANSI characters' do
    text = "I try \e[34mall things\e[0m, I achieve what I can"
    truncation = Verse::Truncation.new(text)
    expect(truncation.truncate(18)).to eq("I try \e[34mall things\e[0m…")
  end

  it "finishes on word boundary" do
    text = "for there is no folly of the beast of the earth"
    truncation = Verse::Truncation.new(text)
    expect(truncation.truncate(20, separator: ' ')).to eq('for there is no…')
  end
end
