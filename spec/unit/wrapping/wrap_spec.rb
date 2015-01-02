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

    it 'wraps at 8 characters' do
      wrapping = Verse::Wrapping.new(text)
      expect(wrapping.wrap(8)).to eq("ラドクリフ、マラ\nソン五輪代表に1\n万m出場にも含み")
    end

    it "doesn't wrap at length exceeding content length" do
      wrapping = Verse::Wrapping.new(text)
      expect(wrapping.wrap(100)).to eq(text)
    end
  end

  context 'when long text' do
    it "wraps long text at 45 characters" do
      text =
      "What of it, if some old hunks of a sea-captain orders me to get a broom
      and sweep down the decks? What does that indignity amount to, weighed,
      I mean, in the scales of the New Testament? Do you think the archangel
      Gabriel thinks anything the less of me, because I promptly and
      respectfully obey that old hunks in that particular instance? Who ain't
      a slave? Tell me that. Well, then, however the old sea-captains may
      order me about--however they may thump and punch me about, I have the
      satisfaction of knowing that it is all right;
      "
      wrapping = Verse::Wrapping.new(text)
      expect(wrapping.wrap(45)).to eq unindent <<-EOS
    What of it, if some old hunks of a\n sea-captain orders me to get a broom
    and sweep down the decks? What does that\n indignity amount to, weighed,
    I mean, in the scales of the New Testament?\n Do you think the archangel
    Gabriel thinks anything the less of me,\n because I promptly and
    respectfully obey that old hunks in that\nparticular instance? Who ain't
    a slave? Tell me that. Well, then, however\n the old sea-captains may
    order me about--however they may thump and\n punch me about, I have the
    satisfaction of knowing that it is all right;\n
      EOS
    end
  end

  context 'when indented' do
    let(:length) { 8 }
    let(:indent) { 4 }

    it "wraps with indentation" do
      text = 'ラドクリフ、マラソン五輪代表に1万m出場にも含み'
      wrapping = Verse::Wrapping.new(text)
      expect(wrapping.wrap(8, indent: 4)).to eq("    ラドクリフ、マラ\n    ソン五輪代表に1\n    万m出場にも含み")
    end
  end

  context 'with ansi colors' do
    it "wraps text with ANSII codes" do
      text = "\[\033[01;32m\]Hey have\[\033[01;34m\]some cake\[\033[00m\]"
      wrapping = Verse::Wrapping.new(text)
      expect(wrapping.wrap(8)).to eq("\[\033[01;32m\]Hey have\[\033[01;34m\]some\ncake\[\033[00m\]")
    end
  end

  context 'with newlines' do
    it "preserves newlines for both prefix and postfix" do
      text = "\n\nラドクリフ、マラソン五輪代表に1万m出場にも含み\n\n\n"
      wrapping = Verse::Wrapping.new(text)
      expect(wrapping.wrap(10)).to eq("\n\nラドクリフ、マラソン\n五輪代表に1万m出場\nにも含み\n\n\n")
    end

    it "preserves newlines with padding" do
      text = "\n\nラドクリフ、マラソン五輪代表に1万m出場にも含み\n\n"
      wrapping = Verse::Wrapping.new(text)
      expect(wrapping.wrap(10, padding: [1,2,3,4])).to eq("\n\n    ラドクリフ、マラソン  \n    五輪代表に1万m出場  \n    にも含み  \n\n")
    end
  end
end
