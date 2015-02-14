# coding: utf-8

require 'spec_helper'

RSpec.describe Verse, '#truncate' do
  it "truncates text" do
    text = 'ラドクリフ、マラソン五輪代表に1万m出場にも含み'
    expect(Verse.truncate(text, 12)).to eq('ラドクリフ…')
  end
end
