# coding: utf-8

require 'spec_helper'

RSpec.describe Verse::Alignment, '.left' do
  it "aligns line to left" do
    text = "the madness of men"
    alignment = Verse::Alignment.new(text)
    expect(alignment.left(22)).to eq("the madness of men    ")
  end

  it "fills empty" do
    alignment = Verse::Alignment.new('')
    expect(alignment.left(22)).to eq("                      ")
  end

  it "left justifies utf line" do
    text = "こんにちは"
    alignment = Verse::Alignment.new(text)
    expect(alignment.align(20, :left)).to eq("こんにちは          ")
  end

  it "left justifies ansi line" do
    text = "\e[32mthe madness of men\e[0m"
    alignment = Verse::Alignment.new(text)
    expect(alignment.align(22, :left)).to eq("\e[32mthe madness of men\e[0m    ")
  end

  it "aligns multiline text to left" do
    text = "for there is no folly of the beast\nof the earth which\nis not infinitely\noutdone by the madness of men"
    alignment = Verse::Alignment.new(text)
    expect(alignment.left(40)).to eq([
     "for there is no folly of the beast      \n",
     "of the earth which                      \n",
     "is not infinitely                       \n",
     "outdone by the madness of men           "
    ].join)
  end

  it "left justifies multiline utf text" do
    text = "ラドクリフ\n、マラソン五輪\n代表に1万m出\n場にも含み"
    alignment = Verse::Alignment.new(text)
    expect(alignment.left(20)).to eq([
      "ラドクリフ          \n",
      "、マラソン五輪      \n",
      "代表に1万m出        \n",
      "場にも含み          "
    ].join)
  end

  it "left justifies ansi text" do
    text = "for \e[35mthere\e[0m is no folly of the beast\nof the \e[33mearth\e0m which\nis \e[34mnot infinitely\e[0m\n\e[33moutdone\e[0m by the madness of men"
    alignment = Verse::Alignment.new(text)
    expect(alignment.left(40)).to eq([
     "for \e[35mthere\e[0m is no folly of the beast      \n",
     "of the \e[33mearth\e0m which                      \n",
     "is \e[34mnot infinitely\e[0m                       \n",
     "\e[33moutdone\e[0m by the madness of men           "
    ].join)
  end

  it "left justifies multiline text with fill of '*'" do
    text = "for there is no folly of the beast\nof the earth which\nis not infinitely\noutdone by the madness of men"
    alignment = Verse::Alignment.new(text, fill: '*')
    expect(alignment.left(40)).to eq([
     "for there is no folly of the beast******\n",
     "of the earth which**********************\n",
     "is not infinitely***********************\n",
     "outdone by the madness of men***********"
    ].join)
  end
end
