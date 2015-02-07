# coding: utf-8

require 'spec_helper'

RSpec.describe Verse, '#wrap' do
  it "wraps text" do
    text = 'ラドクリフ、マラソン五輪代表に1万m出場にも含み'
    expect(Verse.wrap(text, 8)).to eql("ラドクリフ、マラ\nソン五輪代表に1\n万m出場にも含み")
  end
end
