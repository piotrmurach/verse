# coding: utf-8

require 'spec_helper'

RSpec.describe Verse::Alignment, '.align' do

  it "doesn't align unrecognized direction" do
    text = "the madness of men"
    alignment = Verse::Alignment.new(text)
    expect {
      alignment.align(22, :unknown)
    }.to raise_error(ArgumentError, /Unknown alignment/)
  end

  it "centers line" do
    text = "the madness of men"
    alignment = Verse::Alignment.new(text)
    expect(alignment.center(22)).to eq("  the madness of men  ")
  end

  it "centers multiline text" do
    text = "for there is no folly of the beast\n of the earth which\n is not infinitely\n outdone by the madness of men"
    alignment = Verse::Alignment.new(text)
    expect(alignment.center(40)).to eq([
     "   for there is no folly of the beast   \n",
     "           of the earth which           \n",
     "           is not infinitely            \n",
     "     outdone by the madness of men      "
    ].join)
  end

  it "centers multiline text with fill of '*'" do
    text = "for there is no folly of the beast\n of the earth which\n is not infinitely\n outdone by the madness of men"
    alignment = Verse::Alignment.new(text, fill: '*')
    expect(alignment.center(40)).to eq([
     "***for there is no folly of the beast***\n",
     "***********of the earth which***********\n",
     "***********is not infinitely************\n",
     "*****outdone by the madness of men******"
    ].join)
  end
end
