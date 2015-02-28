# coding: utf-8

require 'spec_helper'

RSpec.describe Verse::Wrapping, '.wrap' do
  context 'when unicode' do
    let(:text) { 'ラドクリフ、マラソン五輪代表に1万m出場にも含み' }

    it "doesn't wrap at zero length" do
      wrapping = Verse::Wrapping.new(text)
      expect(wrapping.wrap(0)).to eq(text)
    end

    it "doesn't wrap at nil length" do
      wrapping = Verse::Wrapping.new(text)
      expect(wrapping.wrap(nil)).to eq(text)
    end

    it "doesn't wrap at length exceeding content length" do
      wrapping = Verse::Wrapping.new(text)
      expect(wrapping.wrap(100)).to eq(text)
    end

    it "wraps correctly unbreakable words" do
      wrapping = Verse::Wrapping.new('foobar1')
      expect(wrapping.wrap(3)).to eq([
        "foo",
        "bar",
        "1"
      ].join("\n"))
    end

    it "wraps ascii text" do
      text = "for there is no folly of the beast of the earth which is not infinitely outdone by the madness of men "
      wrapping = Verse::Wrapping.new(text)
      expect(wrapping.wrap(16)).to eq([
        "for there is no ",
        "folly of the ",
        "beast of the ",
        "earth which is ",
        "not infinitely ",
        "outdone by the ",
        "madness of men "
      ].join("\n"))
    end

    it 'wraps at 8 characters' do
      wrapping = Verse::Wrapping.new(text)
      expect(wrapping.wrap(8)).to eq([
        "ラドクリ",
        "フ、マラ",
        "ソン五輪",
        "代表に1",
        "万m出場",
        "にも含み"
      ].join("\n"))
    end

    it 'preserves whitespace' do
     # text = "  As for me,   I am    tormented"
      text = "  As for me,   I am    tormented with   an everlasting   itch for   things remote.  "
      wrapping = Verse::Wrapping.new(text)
      expect(wrapping.wrap(10)).to eq([
        "  As for ",
        "me,   I ",
        "am    ",
        "tormented ",
        "with   an ",
        "e",
        "verlasting",
        "   itch ",
        "for   ",
        "things ",
        "remote.  "
      ].join("\n"))
    end
  end

  context 'when long text' do
    it "wraps long text at 45 characters" do
      text =
      "What of it, if some old hunks of a sea-captain orders me to get a broom and sweep down the decks? What does that indignity amount to, weighed, I mean, in the scales of the New Testament? Do you think the archangel Gabriel thinks anything the less of me, because I promptly and respectfully obey that old hunks in that particular instance? Who ain't a slave? Tell me that. Well, then, however the old sea-captains may order me about--however they may thump and punch me about, I have the satisfaction of knowing that it is all right;"
      wrapping = Verse::Wrapping.new(text)
      expect(wrapping.wrap(45)).to eq unindent <<-EOS
    What of it, if some old hunks of a \nsea-captain orders me to get a broom and \n sweep down the decks? What does that \nindignity amount to, weighed, I mean, in the \n scales of the New Testament? Do you think \nthe archangel Gabriel thinks anything the \nless of me, because I promptly and \nrespectfully obey that old hunks in that \nparticular instance? Who ain't a slave? Tell \nme that. Well, then, however the old \nsea-captains may order me about--however \nthey may thump and punch me about, I have \nthe satisfaction of knowing that it is all \nright;
      EOS
    end
  end

  context 'with newlines' do
    it "preserves newlines for both prefix and postfix" do
      text = "\n\nラドクリフ、マラソン五輪代表に1万m出場にも含み\n\n\n"
      wrapping = Verse::Wrapping.new(text)
      expect(wrapping.wrap(10)).to eq([
        "\n\nラドクリフ",
        "、マラソン",
        "五輪代表に",
        "1万m出場に",
        "も含み\n\n\n"
      ].join("\n"))
    end
  end
end
