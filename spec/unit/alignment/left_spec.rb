# coding: utf-8

require 'spec_helper'

RSpec.describe Verse::Alignment, '.left' do
  it "aligns line to left" do
    text = "the madness of men"
    alignment = Verse::Alignment.new(text)
    expect(alignment.left(22)).to eq("the madness of men    ")
  end

  it "aligns multiline text to left" do
    text = "for there is no folly of the beast\n of the earth which\n is not infinitely\n outdone by the madness of men"
    alignment = Verse::Alignment.new(text)
    expect(alignment.left(40)).to eq([
     "for there is no folly of the beast      \n",
     " of the earth which                     \n",
     " is not infinitely                      \n",
     " outdone by the madness of men          "
    ].join)
  end

  it "centers multiline text with fill of '*'" do
    text = "for there is no folly of the beast\n of the earth which\n is not infinitely\n outdone by the madness of men"
    alignment = Verse::Alignment.new(text, fill: '*')
    expect(alignment.left(40)).to eq([
     "for there is no folly of the beast******\n",
     " of the earth which*********************\n",
     " is not infinitely**********************\n",
     " outdone by the madness of men**********"
    ].join)
  end
end
