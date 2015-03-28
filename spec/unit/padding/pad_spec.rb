# coding: utf-8

require 'spec_helper'

RSpec.describe Verse::Padding, '.pad' do
  it "doesn't pad without padding option" do
    text = "Ignorance is the parent of fear."
    padding = Verse::Padding.new(text)
    expect(padding.pad).to eq(text)
  end

  it "pads content with specific padding" do
    text = "Ignorance is the parent of fear."
    padding = Verse::Padding.new(text)
    expect(padding.pad([1,1,1,1])).to eq([
      "                                  ",
      " Ignorance is the parent of fear. ",
      "                                  ",
    ].join("\n"))
  end

  it "pads content with global padding" do
    text = "Ignorance is the parent of fear."
    padding = Verse::Padding.new(text, padding: [1,1,1,1])
    expect(padding.pad).to eq([
      "                                  ",
      " Ignorance is the parent of fear. ",
      "                                  ",
    ].join("\n"))
  end

  it "pads unicode content" do
    text = "ラドクリフ、マラソン"
    padding = Verse::Padding.new(text)
    expect(padding.pad([1,1,1,1])).to eq([
      "                      ",
      " ラドクリフ、マラソン ",
      "                      "
    ].join("\n"))
  end

  it "pads multiline content" do
    text = "It is the easiest thing\nin the world for a man\nto look as if he had \na great secret in him."
    padding = Verse::Padding.new(text, padding: [1,1,1,1])
    expect(padding.pad()).to eq([
      "                         ",
      " It is the easiest thing ",
      " in the world for a man ",
      " to look as if he had  ",
      " a great secret in him. ",
      "                         ",
    ].join("\n"))
  end

  it "pads ANSI codes inside content" do
    text = "It is \e[35mthe easiest\e[0m thing\nin the \e[34mworld\e[0m for a man\nto look as if he had \na great \e[33msecret\e[0m in him."
    padding = Verse::Padding.new(text, padding: [1,1,1,1])
    expect(padding.pad()).to eq([
      "                         ",
      " It is \e[35mthe easiest\e[0m thing ",
      " in the \e[34mworld\e[0m for a man ",
      " to look as if he had  ",
      " a great \e[33msecret\e[0m in him. ",
      "                         ",
    ].join("\n"))
  end
end
