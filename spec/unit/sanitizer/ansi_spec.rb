# coding: utf-8

require 'spec_helper'

RSpec.describe Verse::Sanitizer, '.ansi?' do
  subject(:sanitizer) { described_class }

  it "checks if code is ansi" do
    expect(sanitizer.ansi?("\e[0;33m")).to eq(true)
  end
end
